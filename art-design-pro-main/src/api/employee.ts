import request from '@/utils/http'

/**
 * 员工管理API
 */

/**
 * 登录
 */
export const login = (data: any) => {
  return request.post({
    url: '/admin/employee/login',
    params: data
  })
}

/**
 * 退出登录
 */
export const userLogout = (params: any) => {
  return request.post({
    url: '/admin/employee/logout',
    params
  })
}

/**
 * 获取员工列表（分页）
 */
export const getEmployeeList = (params: any) => {
  return request.get({
    url: '/admin/employee/page',
    params
  })
}

/**
 * 启用/禁用员工
 */
export const enableOrDisableEmployee = (params: any) => {
  return request.post({
    url: `/admin/employee/status/${params.status}`,
    params: { id: params.id }
  })
}

/**
 * 新增员工
 */
export const addEmployee = (params: any) => {
  return request.post({
    url: '/admin/employee',
    params
  })
}

/**
 * 修改员工
 */
export const editEmployee = (params: any) => {
  return request.put({
    url: '/admin/employee',
    params
  })
}

/**
 * 删除员工
 */
export const deleteEmployee = (id: string | number) => {
  return request.delete({
    url: `/admin/employee/${id}`
  })
}

/**
 * 根据ID查询员工详情
 */
export const queryEmployeeById = (id: string | (string | null)[]) => {
  return request.get({
    url: `/admin/employee/${id}`
  })
}

/**
 * 修改密码
 */
export const editPassword = (data: any) => {
  return request.put({
    url: '/admin/employee/editPassword',
    params: data
  })
}

/**
 * 获取营业状态
 */
export const getStatus = () => {
  return request.get({
    url: '/admin/shop/status'
  })
}

/**
 * 设置营业状态
 */
export const setStatus = (data: any) => {
  return request.put({
    url: `/admin/shop/${data}`,
    params: data
  })
}

