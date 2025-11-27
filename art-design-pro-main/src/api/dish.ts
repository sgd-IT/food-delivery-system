import request from '@/utils/http'

/**
 * 菜品管理API
 */

/**
 * 查询菜品列表（分页）
 */
export const getDishPage = (params: any) => {
  return request.get({
    url: '/admin/dish/page',
    params
  })
}

/**
 * 删除菜品
 */
export const deleteDish = (ids: string) => {
  return request.del({
    url: '/admin/dish',
    params: { ids }
  })
}

/**
 * 修改菜品
 */
export const editDish = (params: any) => {
  return request.put({
    url: '/admin/dish',
    params
  })
}

/**
 * 新增菜品
 */
export const addDish = (params: any) => {
  return request.post({
    url: '/admin/dish',
    params
  })
}

/**
 * 根据ID查询菜品详情
 */
export const queryDishById = (id: string | (string | null)[]) => {
  return request.get({
    url: `/admin/dish/${id}`
  })
}

/**
 * 获取菜品分类列表
 */
export const getCategoryList = (params: any) => {
  return request.get({
    url: '/admin/category/list',
    params
  })
}

/**
 * 查询菜品列表（不分页）
 */
export const queryDishList = (params: any) => {
  return request.get({
    url: '/admin/dish/list',
    params
  })
}

/**
 * 文件下载预览
 */
export const commonDownload = (params: any) => {
  return request.get({
    url: '/admin/common/download',
    params,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    }
  })
}

/**
 * 起售/停售菜品（批量）
 */
export const dishStatusByStatus = (params: any) => {
  return request.post({
    url: `/admin/dish/status/${params.status}`,
    params: { id: params.id }
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

