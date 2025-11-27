import request from '@/utils/http'

/**
 * 分类管理API
 */

/**
 * 查询分类列表（分页）
 */
export const getCategoryPage = (params: any) => {
  return request.get({
    url: '/admin/category/page',
    params
  })
}

/**
 * 删除分类
 */
export const deleCategory = (ids: string) => {
  return request.del({
    url: '/admin/category',
    params: { id: ids }
  })
}

/**
 * 修改分类
 */
export const editCategory = (params: any) => {
  return request.put({
    url: '/admin/category',
    params
  })
}

/**
 * 新增分类
 */
export const addCategory = (params: any) => {
  return request.post({
    url: '/admin/category',
    params
  })
}

/**
 * 启用/禁用分类
 */
export const enableOrDisableCategory = (params: any) => {
  return request.post({
    url: `/admin/category/status/${params.status}`,
    params: { id: params.id }
  })
}

