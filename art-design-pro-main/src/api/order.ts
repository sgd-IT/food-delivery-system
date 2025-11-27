import request from '@/utils/http'

/**
 * 订单管理API
 */

/**
 * 查询订单列表（条件搜索）
 */
export const getOrderDetailPage = (params: any) => {
  return request.get({
    url: '/admin/order/conditionSearch',
    params
  })
}

/**
 * 根据订单ID查询订单详情
 */
export const queryOrderDetailById = (params: any) => {
  return request.get({
    url: `/admin/order/details/${params.orderId}`
  })
}

/**
 * 派送订单
 */
export const deliveryOrder = (params: any) => {
  return request.put({
    url: `/admin/order/delivery/${params.id}`
  })
}

/**
 * 完成订单
 */
export const completeOrder = (params: any) => {
  return request.put({
    url: `/admin/order/complete/${params.id}`
  })
}

/**
 * 取消订单
 */
export const orderCancel = (params: any) => {
  return request.put({
    url: '/admin/order/cancel',
    params
  })
}

/**
 * 接单
 */
export const orderAccept = (params: any) => {
  return request.put({
    url: '/admin/order/confirm',
    params
  })
}

/**
 * 拒单
 */
export const orderReject = (params: any) => {
  return request.put({
    url: '/admin/order/rejection',
    params
  })
}

/**
 * 获取订单统计（待处理、待派送、派送中数量）
 */
export const getOrderListBy = (params: any) => {
  return request.get({
    url: '/admin/order/statistics',
    params
  })
}

