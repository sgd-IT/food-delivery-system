import { AppRouteRecord } from '@/types/router'
// import { dashboardRoutes } from './dashboard'  // 已隐藏：仪表盘
// import { templateRoutes } from './template'  // 已隐藏：模组中心
// import { widgetsRoutes } from './widgets'  // 已隐藏：组件
// import { examplesRoutes } from './examples'  // 已隐藏：示例
// import { systemRoutes } from './system'  // 已隐藏：系统管理（用户、角色、菜单等）
// import { articleRoutes } from './article'  // 已隐藏：文章
// import { resultRoutes } from './result'  // 已隐藏：结果页
// import { exceptionRoutes } from './exception'  // 已隐藏：异常页
// import { safeguardRoutes } from './safeguard'  // 已隐藏：安全
// import { helpRoutes } from './help'  // 已隐藏：帮助
import { businessRoutes } from './business'

/**
 * 导出所有模块化路由
 * 只保留业务逻辑路由
 */
export const routeModules: AppRouteRecord[] = [
  ...businessRoutes,  // 业务路由：工作台、数据统计、订单管理、套餐管理、菜品管理、分类管理、员工管理
  // systemRoutes,  // 已隐藏：系统管理（用户、角色、菜单等）- 后端无对应接口
  // dashboardRoutes,  // 已隐藏：仪表盘
  // templateRoutes,  // 已隐藏：模组中心
  // widgetsRoutes,  // 已隐藏：组件
  // examplesRoutes,  // 已隐藏：示例
  // articleRoutes,  // 已隐藏：文章
  // resultRoutes,  // 已隐藏：结果页
  // exceptionRoutes,  // 已隐藏：异常页
  // safeguardRoutes,  // 已隐藏：安全
  // ...helpRoutes  // 已隐藏：帮助
]
