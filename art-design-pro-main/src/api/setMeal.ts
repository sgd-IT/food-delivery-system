import request from '@/utils/http'

/**
 * 套餐管理API
 */

/**
 * 查询套餐列表（分页）
 */
export const getSetmealPage = (params: any) => {
  return request.get({
    url: '/admin/setmeal/page',
    params
  })
}

/**
 * 删除套餐
 */
export const deleteSetmeal = (ids: string) => {
  return request.del({
    url: '/admin/setmeal',
    params: { ids }
  })
}

/**
 * 修改套餐
 */
export const editSetmeal = (params: any) => {
  return request.put({
    url: '/admin/setmeal',
    params
  })
}

/**
 * 新增套餐
 */
export const addSetmeal = (params: any) => {
  return request.post({
    url: '/admin/setmeal',
    params
  })
}

/**
 * 根据ID查询套餐详情
 */
export const querySetmealById = (id: string | (string | null)[]) => {
  return request.get({
    url: `/admin/setmeal/${id}`
  })
}

/**
 * 批量起售/禁售套餐
 */
export const setmealStatusByStatus = (params: any) => {
  return request.post({
    url: `/admin/setmeal/status/${params.status}`,
    params: { id: params.ids }
  })
}

/**
 * 菜品分类数据查询
 */
export const dishCategoryList = (params: any) => {
  return request.get({
    url: '/admin/category/list',
    params
  })
}

