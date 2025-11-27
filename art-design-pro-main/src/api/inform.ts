import request from '@/utils/http'

/**
 * 通知管理API
 */

/**
 * 获取通知列表（分页）
 */
export const getInformData = (params: any) => {
  return request.get({
    url: '/messages/page',
    params
  })
}

/**
 * 获取未读消息数量
 */
export const getCountUnread = () => {
  return request.get({
    url: '/messages/countUnread'
  })
}

/**
 * 批量标记已读
 */
export const batchMsg = (data: any) => {
  return request.put({
    url: '/messages/batch',
    params: data
  })
}

/**
 * 标记单条消息已读
 */
export const setStatus = (params: any) => {
  return request.put({
    url: `/messages/${params}`
  })
}

