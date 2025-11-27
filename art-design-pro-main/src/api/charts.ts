import request from '@/utils/http'

/**
 * 报表数据API
 */

/**
 * 获取当日销售数据（顶部数据）
 */
export const getDataes = (params: any) => {
  return request.get({
    url: `/report/amountCollect/${params.date}`
  })
}

/**
 * 获取当日销售数据（营收概况）
 */
export const getChartsDataes = (params: any) => {
  return request.get({
    url: `/report/dayCollect/${params.start}/${params.end}`
  })
}

/**
 * 获取当日销售趋势数据（24小时）
 */
export const getDayDataes = (params: any) => {
  return request.get({
    url: `/report/hourCollect/${params.type}/${params.date}`
  })
}

/**
 * 支付类型数据汇总（店内收款构成 - 当日）
 */
export const getDayPayType = (params: any) => {
  return request.get({
    url: `/report/payTypeCollect/${params.date}`
  })
}

/**
 * 获取当日各种优惠类型数据汇总（优惠指标）
 */
export const getprivilege = (params: any) => {
  return request.get({
    url: `/report/privilegeCollect/${params.date}`
  })
}

/**
 * 获取菜品分类销售排行（菜品分类占比 - 当日）
 */
export const getSalesRanking = (params: any) => {
  return request.get({
    url: `/report/categoryCollect/${params.type}/${params.date}`
  })
}

/**
 * 获取当日菜品销售排行
 */
export const getDayRanking = (params: any) => {
  return request.get({
    url: `/report/currentDishRank/${params.date}`
  })
}

/**
 * 获取一定日期之内的销售趋势（销售趋势图）
 */
export const getTimeQuantumDataes = (params: any) => {
  return request.get({
    url: `/report/dayAmountCollect/${params.type}/${params.start}/${params.end}`
  })
}

/**
 * 获取时间范围之内的各种支付类型数据汇总（店内收款构成 - 时间段）
 */
export const getTimeQuantumReceivables = (params: any) => {
  return request.get({
    url: `/report/datePayTypeCollect/${params.start}/${params.end}`
  })
}

/**
 * 获取时间范围之内的菜品类别销售汇总（菜品分类占比 - 时间段）
 */
export const getTimeQuantumType = (params: any) => {
  return request.get({
    url: `/report/dateCategoryCollect/${params.type}/${params.start}/${params.end}`
  })
}

/**
 * 获取时间范围之内的菜品销售排行（菜品销售排行）
 */
export const getTimeQuantumDishes = (params: any) => {
  return request.get({
    url: `/report/dishRankForDate/${params.start}/${params.end}`
  })
}

/**
 * 获取时间范围之内的优惠指标汇总数据（顶部信息）
 */
export const getTimeQuantumDiscount = (params: any) => {
  return request.get({
    url: `/report/privilegeByDate/${params.start}/${params.end}`
  })
}

