import { AppRouteRecord } from '@/types/router'

/**
 * 业务路由模块
 * 包含：工作台、数据统计、订单管理、套餐管理、菜品管理、分类管理、员工管理等
 */

export const businessRoutes: AppRouteRecord[] = [
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: '/dashboard/console/index',
    meta: {
      title: '工作台',
      icon: 'ri:home-smile-2-line',
      keepAlive: false,
      fixedTab: true
    }
  },
  {
    path: '/statistics',
    name: 'Statistics',
    component: '/statistics/index',
    meta: {
      title: '数据统计',
      icon: 'ri:bar-chart-box-line',
      keepAlive: false
    }
  },
  {
    path: '/order',
    name: 'Order',
    component: '/order/index',
    meta: {
      title: '订单管理',
      icon: 'ri:file-list-3-line',
      keepAlive: false
    }
  },
  {
    path: '/setmeal',
    name: 'Setmeal',
    component: '/setmeal/index',
    meta: {
      title: '套餐管理',
      icon: 'ri:restaurant-line',
      keepAlive: false
    }
  },
  {
    path: '/dish',
    name: 'Dish',
    component: '/dish/index',
    meta: {
      title: '菜品管理',
      icon: 'ri:bowl-line',
      keepAlive: false
    }
  },
  {
    path: '/category',
    name: 'Category',
    component: '/category/index',
    meta: {
      title: '分类管理',
      icon: 'ri:folder-line',
      keepAlive: false
    }
  },
  {
    path: '/employee',
    name: 'Employee',
    component: '/employee/index',
    meta: {
      title: '员工管理',
      icon: 'ri:user-line',
      keepAlive: false
    }
  }
]

