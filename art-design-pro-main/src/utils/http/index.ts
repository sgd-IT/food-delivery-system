/**
 * HTTP 请求封装模块
 * 基于 Axios 封装的 HTTP 请求工具，提供统一的请求/响应处理
 *
 * ## 主要功能
 *
 * - 请求/响应拦截器（自动添加 Token、统一错误处理）
 * - 401 未授权自动登出（带防抖机制）
 * - 请求失败自动重试（可配置）
 * - 统一的成功/错误消息提示
 * - 支持 GET/POST/PUT/DELETE 等常用方法
 *
 * @module utils/http
 * @author Art Design Pro Team
 */

import axios, { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from 'axios'
import { useUserStore } from '@/store/modules/user'
import { ApiStatus } from './status'
import { HttpError, handleError, showError, showSuccess } from './error'
import { $t } from '@/locales'
import { BaseResponse } from '@/types'

/** 请求配置常量 */
const REQUEST_TIMEOUT = 600000 // 适配旧前端超时时间
const LOGOUT_DELAY = 500
const MAX_RETRIES = 0
const RETRY_DELAY = 1000
const UNAUTHORIZED_DEBOUNCE_TIME = 3000
/** 成功响应码（适配旧后端：code=1表示成功） */
const SUCCESS_CODE = 1

/** 401防抖状态 */
let isUnauthorizedErrorShown = false
let unauthorizedTimer: NodeJS.Timeout | null = null

/** 扩展 AxiosRequestConfig */
interface ExtendedAxiosRequestConfig extends AxiosRequestConfig {
  showErrorMessage?: boolean
  showSuccessMessage?: boolean
}

const { VITE_API_URL, VITE_WITH_CREDENTIALS } = import.meta.env

/** Axios实例 */
const axiosInstance = axios.create({
  timeout: REQUEST_TIMEOUT,
  baseURL: VITE_API_URL,
  withCredentials: VITE_WITH_CREDENTIALS === 'true',
  validateStatus: (status) => status >= 200 && status < 300,
  transformResponse: [
    (data, headers) => {
      const contentType = headers['content-type']
      if (contentType?.includes('application/json')) {
        try {
          return JSON.parse(data)
        } catch {
          return data
        }
      }
      return data
    }
  ]
})

/** GET请求参数序列化（适配旧前端逻辑） */
function serializeGetParams(url: string, params: any): string {
  if (!params) return url
  let result = url + '?'
  for (const propName of Object.keys(params)) {
    const value = params[propName]
    if (value !== null && typeof value !== 'undefined') {
      if (typeof value === 'object') {
        // 处理对象参数，格式：propName[key]=value
        for (const key of Object.keys(value)) {
          const paramKey = `${propName}[${key}]`
          result += `${encodeURIComponent(paramKey)}=${encodeURIComponent(value[key])}&`
        }
      } else {
        result += `${encodeURIComponent(propName)}=${encodeURIComponent(value)}&`
      }
    }
  }
  return result.slice(0, -1) // 移除最后一个&
}

/** 请求拦截器 */
axiosInstance.interceptors.request.use(
  (request: InternalAxiosRequestConfig) => {
    const { accessToken } = useUserStore()
    // 适配旧后端：使用token字段而非Authorization
    if (accessToken) request.headers.set('token', accessToken)

    // GET请求特殊处理：手动序列化参数到URL（适配旧前端逻辑）
    if (request.method?.toUpperCase() === 'GET' && request.params) {
      const originalUrl = request.url || ''
      request.url = serializeGetParams(originalUrl, request.params)
      // 添加调试日志
      if (process.env.NODE_ENV === 'development') {
        console.log('[HTTP] GET 请求:', {
          originalUrl,
          params: request.params,
          finalUrl: request.url
        })
      }
      request.params = {}
    }

    // POST/PUT请求：自动设置Content-Type和序列化数据
    if (request.data && !(request.data instanceof FormData) && !request.headers['Content-Type']) {
      request.headers.set('Content-Type', 'application/json')
      request.data = JSON.stringify(request.data)
    }

    return request
  },
  (error) => {
    showError(createHttpError($t('httpMsg.requestConfigError'), ApiStatus.error))
    return Promise.reject(error)
  }
)

/** 响应拦截器 */
axiosInstance.interceptors.response.use(
  async (response: AxiosResponse<BaseResponse | Blob>) => {
    // 处理 Blob 响应（如文件下载、导出等）
    if (response.config.responseType === 'blob' || response.data instanceof Blob) {
      const blob = response.data as Blob
      const contentType = response.headers['content-type'] || response.headers['Content-Type'] || ''
      
      // 检查是否是错误响应（Spring 错误页面通常是 text/xml 或 text/html）
      if (contentType.includes('text/xml') || contentType.includes('text/html') || contentType.includes('application/json')) {
        // 尝试读取 Blob 内容，检查是否是错误响应
        try {
          const text = await blob.text()
          // 如果是 JSON 格式的错误响应，解析并抛出错误
          if (contentType.includes('application/json') || text.trim().startsWith('{')) {
            try {
              const errorData = JSON.parse(text)
              const errorCode = errorData.code ?? response.status ?? ApiStatus.error
              const errorMessage = errorData.msg || errorData.message || $t('httpMsg.requestFailed')
              throw createHttpError(errorMessage, errorCode, {
                url: response.config?.url,
                method: response.config?.method?.toUpperCase(),
                data: errorData
              })
            } catch (e) {
              // JSON 解析失败，继续处理
            }
          }
          // 如果是 XML 或 HTML 错误页面，检查状态码
          if (response.status && response.status >= 400) {
            const errorCode = response.status
            const errorMessage = $t('httpMsg.requestFailed')
            throw createHttpError(errorMessage, errorCode, {
              url: response.config?.url,
              method: response.config?.method?.toUpperCase(),
              data: { contentType, size: blob.size }
            })
          }
        } catch (error) {
          // 如果已经是 HttpError，直接抛出
          if (error instanceof HttpError) {
            throw error
          }
          // 其他错误，继续处理 Blob
        }
      }
      // 正常返回 Blob 响应
      return response
    }

    // 处理 JSON 响应
    const responseData = response.data as BaseResponse
    const { code, msg, data } = responseData
    // 添加调试日志
    if (process.env.NODE_ENV === 'development') {
      let dataPreview: any = null
      if (data) {
        if (Array.isArray(data)) {
          dataPreview = `Array(${data.length})`
        } else if (typeof data === 'object') {
          dataPreview = JSON.stringify(data).substring(0, 500)
        } else if (typeof data === 'string') {
          dataPreview = data.length > 500 ? data.substring(0, 500) + '...' : data
        } else {
          dataPreview = data
        }
      }
      console.log('[HTTP] 响应数据:', {
        url: response.config.url,
        code,
        msg,
        data: dataPreview,
        dataType: typeof data,
        isString: typeof data === 'string',
        isObject: typeof data === 'object' && data !== null,
        isArray: Array.isArray(data)
      })
    }
    // 适配旧后端：code=1表示成功
    if (code === SUCCESS_CODE) return response
    // 处理401未授权
    if (code === ApiStatus.unauthorized || (responseData as any).status === 401) {
      handleUnauthorizedError(
        msg,
        response.config?.url,
        response.config?.method?.toUpperCase()
      )
    }
    // 其他错误码抛出错误
    const errorCode = code ?? ApiStatus.error
    const errorMessage = msg || $t('httpMsg.requestFailed')
    throw createHttpError(errorMessage, errorCode, {
      url: response.config?.url,
      method: response.config?.method?.toUpperCase(),
      data: responseData
    })
  },
  (error) => {
    // HTTP状态码401处理
    if (error.response?.status === ApiStatus.unauthorized) {
      handleUnauthorizedError(
        undefined,
        error.config?.url,
        error.config?.method?.toUpperCase()
      )
    }
    return Promise.reject(handleError(error))
  }
)

/** 统一创建HttpError */
function createHttpError(
  message: string,
  code: number | undefined,
  options?: {
    url?: string
    method?: string
    data?: unknown
  }
) {
  return new HttpError(message, code ?? ApiStatus.error, {
    url: options?.url,
    method: options?.method,
    data: options?.data
  })
}

/** 处理401错误（带防抖） */
function handleUnauthorizedError(message?: string, url?: string, method?: string): never {
  const error = createHttpError(
    message || $t('httpMsg.unauthorized'),
    ApiStatus.unauthorized,
    {
      url,
      method
    }
  )

  if (!isUnauthorizedErrorShown) {
    isUnauthorizedErrorShown = true
    logOut()

    unauthorizedTimer = setTimeout(resetUnauthorizedError, UNAUTHORIZED_DEBOUNCE_TIME)

    showError(error, true)
    throw error
  }

  throw error
}

/** 重置401防抖状态 */
function resetUnauthorizedError() {
  isUnauthorizedErrorShown = false
  if (unauthorizedTimer) clearTimeout(unauthorizedTimer)
  unauthorizedTimer = null
}

/** 退出登录函数 */
function logOut() {
  setTimeout(() => {
    useUserStore().logOut()
  }, LOGOUT_DELAY)
}

/** 是否需要重试 */
function shouldRetry(statusCode: number) {
  return [
    ApiStatus.requestTimeout,
    ApiStatus.internalServerError,
    ApiStatus.badGateway,
    ApiStatus.serviceUnavailable,
    ApiStatus.gatewayTimeout
  ].includes(statusCode)
}

/** 请求重试逻辑 */
async function retryRequest<T>(
  config: ExtendedAxiosRequestConfig,
  retries: number = MAX_RETRIES
): Promise<T> {
  try {
    return await request<T>(config)
  } catch (error) {
    if (retries > 0 && error instanceof HttpError && shouldRetry(error.code)) {
      await delay(RETRY_DELAY)
      return retryRequest<T>(config, retries - 1)
    }
    throw error
  }
}

/** 延迟函数 */
function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

/** 请求函数 */
async function request<T = any>(config: ExtendedAxiosRequestConfig): Promise<T> {
  // POST | PUT 参数自动填充
  if (
    ['POST', 'PUT'].includes(config.method?.toUpperCase() || '') &&
    config.params &&
    !config.data
  ) {
    config.data = config.params
    config.params = undefined
  }

  try {
    const res = await axiosInstance.request<BaseResponse<T> | Blob>(config)

    // 处理 Blob 响应（如文件下载、导出等）
    if (config.responseType === 'blob' || res.data instanceof Blob) {
      return res.data as T
    }

    // 适配旧后端响应格式：直接返回response.data（包含code、msg、data）
    // 如果只需要data，在API调用层处理
    const responseData = res.data as BaseResponse<T>

    // 显示成功消息
    if (config.showSuccessMessage && responseData.msg) {
      showSuccess(responseData.msg)
    }

    // 返回data字段（保持与旧前端一致）
    let result = responseData.data as T
    
    // 如果 data 是字符串，尝试解析为 JSON
    if (typeof result === 'string') {
      try {
        const parsed = JSON.parse(result)
        if (process.env.NODE_ENV === 'development') {
          const originalStr = result.length > 100 ? result.substring(0, 100) + '...' : result
          const parsedStr = typeof parsed === 'object' && parsed !== null 
            ? (JSON.stringify(parsed).length > 200 ? JSON.stringify(parsed).substring(0, 200) + '...' : JSON.stringify(parsed))
            : String(parsed)
          console.log('[HTTP] 解析 JSON 字符串成功:', {
            original: originalStr,
            parsed: parsedStr
          })
        }
        result = parsed as T
      } catch (e) {
        // 如果解析失败，返回原始字符串
        const errorMsg = typeof result === 'string' && result.length > 100 
          ? result.substring(0, 100) + '...' 
          : String(result)
        console.warn('[HTTP] 无法解析 data 字段为 JSON:', e, '原始数据:', errorMsg)
      }
    }
    
    // 添加调试日志
    if (process.env.NODE_ENV === 'development') {
      const preview = typeof result === 'object' && result !== null
        ? (JSON.stringify(result).length > 200 ? JSON.stringify(result).substring(0, 200) + '...' : JSON.stringify(result))
        : String(result)
      console.log('[HTTP] 最终返回的数据:', {
        type: typeof result,
        isArray: Array.isArray(result),
        keys: typeof result === 'object' && result !== null ? Object.keys(result) : null,
        preview
      })
    }
    
    return result
  } catch (error) {
    if (error instanceof HttpError && error.code !== ApiStatus.unauthorized) {
      const showMsg = config.showErrorMessage !== false
      showError(error, showMsg)
    }
    return Promise.reject(error)
  }
}

/** API方法集合 */
const api = {
  get<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'GET' })
  },
  post<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'POST' })
  },
  put<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'PUT' })
  },
  del<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'DELETE' })
  },
  request<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>(config)
  }
}

export default api
