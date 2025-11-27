import request from '@/utils/http'

/**
 * 工作台数据API
 */

/**
 * 订单管理数据
 */
export const getOrderData = () => {
  return request.get({
    url: '/admin/workspace/overviewOrders'
  })
}

/**
 * 菜品总览
 */
export const getOverviewDishes = () => {
  return request.get({
    url: '/admin/workspace/overviewDishes'
  })
}

/**
 * 套餐总览
 */
export const getSetMealStatistics = () => {
  return request.get({
    url: '/admin/workspace/overviewSetmeals'
  })
}

/**
 * 营业数据
 */
export const getBusinessData = () => {
  return request.get({
    url: '/admin/workspace/businessData'
  })
}

/**
 * 营业额统计
 */
export const getTurnoverStatistics = (params: any) => {
  return request.get({
    url: '/admin/report/turnoverStatistics',
    params
  })
}

/**
 * 用户统计
 */
export const getUserStatistics = (params: any) => {
  return request.get({
    url: '/admin/report/userStatistics',
    params
  })
}

/**
 * 订单统计
 */
export const getOrderStatistics = (params: any) => {
  return request.get({
    url: '/admin/report/ordersStatistics',
    params
  })
}

/**
 * 销量排名TOP10
 */
export const getTop = (params: any) => {
  return request.get({
    url: '/admin/report/top10',
    params
  })
}

/**
 * 数据概览
 */
export const getDataOverView = (params: any) => {
  return request.get({
    url: '/admin/report/dataOverView',
    params
  })
}

/**
 * 导出数据
 */
export function exportInfor() {
  return request.get({
    url: '/admin/report/export',
    responseType: 'blob'
  })
}

