<template>
  <div class="order-page art-full-height">
    <!-- Tab切换 -->
    <TabChange
      :order-statics="orderStatics"
      :default-activity="defaultActivity"
      @tab-change="handleTabChange"
    />

    <!-- 搜索栏 -->
    <ArtSearchBar
      v-model="searchForm"
      :items="searchItems"
      :is-expand="false"
      :show-expand="false"
      :show-reset-button="true"
      :show-search-button="true"
      @search="handleSearch"
      @reset="handleReset"
    />

    <ElCard class="art-table-card" shadow="never">
      <!-- 表格头部 -->
      <ArtTableHeader v-model:columns="columnChecks" :loading="loading" @refresh="refreshData" />

      <!-- 表格 -->
      <ArtTable
        :loading="loading"
        :data="data"
        :columns="columns"
        :pagination="pagination"
        @pagination:size-change="handleSizeChange"
        @pagination:current-change="handleCurrentChange"
      />

      <!-- 空状态 -->
      <ElEmpty v-if="!loading && data.length === 0" :description="isSearch ? 'Sorry，木有找到您搜索的内容哦~' : '这里空空如也~'" />
    </ElCard>

    <!-- 订单详情弹窗 -->
    <OrderDetailDialog
      v-model:visible="dialogVisible"
      :order-data="currentOrderData"
      :order-status="dialogOrderStatus"
      @accept="handleOrderAccept"
      @reject="handleOrderReject"
      @delivery="handleDelivery"
      @complete="handleComplete"
      @cancel="handleCancel"
    />

    <!-- 拒单/取消弹窗 -->
    <CancelOrderDialog
      v-model:visible="cancelDialogVisible"
      :title="cancelDialogTitle"
      :order-id="orderId"
      @confirm="handleConfirmCancel"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, h, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useTable } from '@/hooks/core/useTable'
import {
  getOrderDetailPage,
  queryOrderDetailById,
  completeOrder,
  deliveryOrder,
  orderCancel,
  orderReject,
  orderAccept,
  getOrderListBy
} from '@/api/order'
import { ElMessage, ElTag, ElButton as ElBtn } from 'element-plus'
import TabChange from './components/TabChange.vue'
import OrderDetailDialog from './components/OrderDetailDialog.vue'
import CancelOrderDialog from './components/CancelOrderDialog.vue'

defineOptions({ name: 'Order' })

const route = useRoute()
const router = useRouter()

// Tab相关
const defaultActivity = ref(Number(route.query.status) || 0)
const orderStatus = ref(defaultActivity.value)
const orderStatics = ref<any>({})

// 搜索状态
const isSearch = ref(false)
// 是否启用自动搜索（避免初始化时触发）
const enableAutoSearch = ref(false)

// 弹窗相关
const dialogVisible = ref(false)
const cancelDialogVisible = ref(false)
const cancelDialogTitle = ref('')
const orderId = ref('')
const currentOrderData = ref<any>({})
const dialogOrderStatus = ref(0)

// 搜索表单
const searchForm = ref({
  number: undefined,
  phone: undefined,
  timeRange: undefined, // 日期范围选择器字段
  beginTime: undefined,
  endTime: undefined,
  orderType: undefined
})

// 搜索项配置
const searchItems = computed(() => [
  {
    key: 'number',
    label: '订单号',
    type: 'input',
    props: {
      placeholder: '请填写订单号',
      clearable: true
    }
  },
  {
    key: 'phone',
    label: '手机号',
    type: 'input',
    props: {
      placeholder: '请填写手机号',
      clearable: true
    }
  },
  {
    key: 'timeRange',
    label: '下单时间',
    type: 'daterange',
    props: {
      type: 'daterange',
      rangeSeparator: '至',
      startPlaceholder: '开始日期',
      endPlaceholder: '结束日期',
      valueFormat: 'YYYY-MM-DD HH:mm:ss',
      defaultTime: [new Date(2000, 1, 1, 0, 0, 0), new Date(2000, 2, 1, 23, 59, 59)],
      clearable: true
    }
  },
  {
    key: 'orderType',
    label: '订单类型',
    type: 'select',
    props: {
      placeholder: '请选择订单类型',
      clearable: true,
      options: [
        { value: 1, label: '到店自取' },
        { value: 2, label: '外卖配送' }
      ]
    }
  }
])

// 获取订单状态文本
const getOrderStatusText = (status: number) => {
  const statusMap: Record<number, string> = {
    1: '待付款',
    2: '待接单',
    3: '待派送',
    4: '派送中',
    5: '已完成',
    6: '已取消'
  }
  return statusMap[status] || '退款'
}

// 表格列配置（根据订单状态动态显示）
const getColumns = (status: number) => {
  const baseColumns: any[] = [
    { prop: 'number', label: '订单号' },
    {
      prop: 'orderType',
      label: '订单类型',
      align: 'center',
      formatter: (row: any) => {
        const type = row.orderType === 1 ? 'warning' : 'success'
        const text = row.orderType === 1 ? '到店自取' : '外卖配送'
        return h(ElTag, { type, size: 'small' }, () => text)
      }
    }
  ]

  // 根据状态添加不同列
  if ([2, 3, 4].includes(status)) {
    baseColumns.splice(1, 0, { prop: 'orderDishes', label: '订单菜品' })
  }

  if (status === 0) {
    baseColumns.splice(1, 0, {
      prop: 'status',
      label: '订单状态',
      formatter: (row: any) => getOrderStatusText(row.status)
    })
  }

  if ([0, 5, 6].includes(status)) {
    baseColumns.push(
      { prop: 'consignee', label: '用户名', showOverflowTooltip: true },
      { prop: 'phone', label: '手机号' }
    )
  }

  if ([0, 2, 3, 4, 5, 6].includes(status)) {
    baseColumns.push({ prop: 'address', label: '地址' })
  }

  if ([0, 6].includes(status)) {
    baseColumns.push({ prop: 'orderTime', label: '下单时间', minWidth: 110 })
  }

  if (status === 6) {
    baseColumns.push(
      { prop: 'cancelTime', label: '取消时间', minWidth: 110 },
      { prop: 'cancelReason', label: '取消原因', minWidth: 80 }
    )
  }

  if (status === 5) {
    baseColumns.push({ prop: 'deliveryTime', label: '送达时间' })
  }

  if ([2, 3, 4].includes(status)) {
    baseColumns.push({ prop: 'estimatedDeliveryTime', label: '预计送达时间', minWidth: 110 })
  }

  if ([0, 2, 5].includes(status)) {
    baseColumns.push({
      prop: 'amount',
      label: '实收金额',
      align: 'center',
      formatter: (row: any) => `￥${((row.amount * 100) / 100).toFixed(2)}`
    })
  }

  if ([2, 3, 4].includes(status)) {
    baseColumns.push(
      { prop: 'remark', label: '备注', align: 'center' },
      { prop: 'tablewareNumber', label: '餐具数量', align: 'center', minWidth: 80 }
    )
  }

  // 操作列
  baseColumns.push({
    prop: 'operation',
    label: '操作',
    align: 'center',
    fixed: 'right',
    minWidth: status === 0 ? 140 : [2, 3, 4].includes(status) ? 130 : 'auto',
    formatter: (row: any) => {
      const buttons: any[] = []
      
      if (row.status === 2) {
        buttons.push(
          h(ElBtn, { type: 'primary', link: true, onClick: () => handleOrderAccept(row) }, () => '接单'),
          h(ElBtn, { type: 'danger', link: true, onClick: () => handleOrderReject(row) }, () => '拒单')
        )
      }
      
      if (row.status === 3) {
        buttons.push(
          h(ElBtn, { type: 'primary', link: true, onClick: () => handleDelivery(row) }, () => '派送')
        )
      }
      
      if (row.status === 4) {
        buttons.push(
          h(ElBtn, { type: 'primary', link: true, onClick: () => handleComplete(row) }, () => '完成')
        )
      }
      
      if ([1, 3, 4, 5].includes(row.status)) {
        buttons.push(
          h(ElBtn, { type: 'danger', link: true, onClick: () => handleCancel(row) }, () => '取消')
        )
      }
      
      buttons.push(
        h(ElBtn, { type: 'primary', link: true, onClick: () => goDetail(row) }, () => '查看')
      )
      
      return h('div', { class: 'flex gap-2 justify-center' }, buttons)
    }
  })

  return baseColumns
}

// 表格配置
const {
  columns,
  columnChecks,
  data,
  loading,
  pagination,
  getData,
  getDataDebounced,
  searchParams,
  resetSearchParams,
  handleSizeChange,
  handleCurrentChange,
  refreshData
} = useTable({
  core: {
    apiFn: getOrderDetailPage,
    apiParams: {
      page: 1,
      pageSize: 10,
      status: orderStatus.value,
      ...searchForm.value
    },
    paginationKey: {
      current: 'page',
      size: 'pageSize'
    },
    columnsFactory: () => getColumns(orderStatus.value)
  }
})

// 监听订单状态变化，更新列配置和搜索参数
watch(orderStatus, (newStatus) => {
  columns.value = getColumns(newStatus)
  // 同步更新搜索参数中的 status，确保查询使用正确的状态
  // 注意：这里不触发自动查询，由 handleTabChange 或用户操作触发
  const paramsRecord = searchParams as Record<string, unknown>
  if (paramsRecord.status !== newStatus) {
    paramsRecord.status = newStatus
  }
}, { immediate: false })

// 自动搜索处理函数
const handleAutoSearch = () => {
  // 如果未启用自动搜索，不执行
  if (!enableAutoSearch.value) {
    return
  }
  
  // 从 searchForm 获取表单数据
  const params: Record<string, any> = { ...searchForm.value }
  
  // 检查是否有搜索条件（订单号、手机号或下单时间）
  const numberValue = params.number?.trim()
  const phoneValue = params.phone?.trim()
  const hasTimeRange = params.timeRange && Array.isArray(params.timeRange) && params.timeRange.length === 2
  
  // 处理时间范围
  if (hasTimeRange) {
    params.beginTime = params.timeRange[0]
    params.endTime = params.timeRange[1]
    delete params.timeRange
  } else {
    // 如果没有时间范围，清除时间相关参数
    params.beginTime = undefined
    params.endTime = undefined
    delete params.timeRange
  }
  
  // 清除空字符串，避免传递空值
  if (!numberValue) {
    params.number = undefined
  }
  if (!phoneValue) {
    params.phone = undefined
  }
  
  // 添加订单状态
  params.status = orderStatus.value
  
  // 更新搜索参数
  Object.assign(searchParams, params)
  
  // 使用防抖搜索，避免频繁请求（即使没有搜索条件也会执行，显示所有数据）
  getDataDebounced(params)
}

// 监听搜索表单字段变化，自动触发查询
watch(
  () => [searchForm.value.number, searchForm.value.phone, searchForm.value.timeRange],
  () => {
    handleAutoSearch()
  },
  { deep: true }
)

/**
 * 获取订单统计
 */
const getOrderStatistics = async () => {
  try {
    const res = await getOrderListBy({})
    if (res) {
      orderStatics.value = res
    }
  } catch (err) {
    console.error('获取订单统计失败:', err)
  }
}

/**
 * Tab切换
 */
const handleTabChange = (activeIndex: number) => {
  if (activeIndex === orderStatus.value) return
  orderStatus.value = activeIndex
  defaultActivity.value = activeIndex
  searchForm.value = {
    number: undefined,
    phone: undefined,
    timeRange: undefined,
    beginTime: undefined,
    endTime: undefined,
    orderType: undefined
  }
  dialogOrderStatus.value = 0
  // 更新路由参数，保持 URL 和状态同步
  router.push({
    path: '/order',
    query: activeIndex === 0 ? {} : { status: activeIndex }
  })
  // 更新搜索参数中的 status，然后刷新数据
  Object.assign(searchParams, { status: activeIndex, page: 1 })
  refreshData()
}

/**
 * 搜索处理
 */
const handleSearch = () => {
  isSearch.value = true
  // 暂时禁用自动搜索，避免重复触发
  enableAutoSearch.value = false
  // 从 searchForm 获取表单数据
  const params: Record<string, any> = { ...searchForm.value }
  // 处理时间范围
  if (params.timeRange && Array.isArray(params.timeRange)) {
    params.beginTime = params.timeRange[0]
    params.endTime = params.timeRange[1]
    delete params.timeRange
  }
  // 添加订单状态
  params.status = orderStatus.value
  // 更新搜索参数
  Object.assign(searchParams, params)
  // 调用 getData，它会自动重置到第一页并清空缓存
  getData(params)
  // 搜索完成后重新启用自动搜索
  setTimeout(() => {
    enableAutoSearch.value = true
  }, 100)
}

/**
 * 重置搜索
 */
const handleReset = () => {
  isSearch.value = false
  resetSearchParams()
  // 重置后，回到全部订单状态（status=0）
  orderStatus.value = 0
  defaultActivity.value = 0
  // 清空搜索表单，包括日期范围
  searchForm.value = {
    number: undefined,
    phone: undefined,
    timeRange: undefined,
    beginTime: undefined,
    endTime: undefined,
    orderType: undefined
  }
  Object.assign(searchParams, { 
    status: 0,
    page: 1,
    pageSize: 10
  })
  // 更新路由，移除 status 参数
  router.push({ path: '/order', query: {} })
  getData()
}

/**
 * 查看详情
 */
const goDetail = async (row: any) => {
  try {
    const res = await queryOrderDetailById({ orderId: row.id })
    currentOrderData.value = res
    dialogOrderStatus.value = row.status
    orderId.value = String(row.id)
    dialogVisible.value = true
  } catch (err: any) {
    ElMessage.error('获取订单详情失败：' + err.message)
  }
}

/**
 * 接单
 */
const handleOrderAccept = async (row: any) => {
  try {
    await orderAccept({ id: row.id })
    ElMessage.success('操作成功')
    dialogVisible.value = false
    refreshData()
    getOrderStatistics()
  } catch (err: any) {
    ElMessage.error('操作失败：' + err.message)
  }
}

/**
 * 拒单
 */
const handleOrderReject = (row: any) => {
  orderId.value = row.id
  dialogOrderStatus.value = row.status
  cancelDialogTitle.value = '拒绝'
  dialogVisible.value = false
  cancelDialogVisible.value = true
}

/**
 * 派送
 */
const handleDelivery = async (row: any) => {
  try {
    await deliveryOrder({ id: row.id })
    ElMessage.success('操作成功')
    dialogVisible.value = false
    refreshData()
    getOrderStatistics()
  } catch (err: any) {
    ElMessage.error('操作失败：' + err.message)
  }
}

/**
 * 完成
 */
const handleComplete = async (row: any) => {
  try {
    await completeOrder({ id: row.id })
    ElMessage.success('操作成功')
    dialogVisible.value = false
    refreshData()
    getOrderStatistics()
  } catch (err: any) {
    ElMessage.error('操作失败：' + err.message)
  }
}

/**
 * 取消订单
 */
const handleCancel = (row: any) => {
  orderId.value = row.id
  dialogOrderStatus.value = row.status
  cancelDialogTitle.value = '取消'
  dialogVisible.value = false
  cancelDialogVisible.value = true
}

/**
 * 确认取消/拒单
 */
const handleConfirmCancel = async (reason: string, isCancel: boolean) => {
  try {
    if (isCancel) {
      await orderCancel({ id: orderId.value, cancelReason: reason })
    } else {
      await orderReject({ id: orderId.value, rejectionReason: reason })
    }
    ElMessage.success('操作成功')
    cancelDialogVisible.value = false
    refreshData()
    getOrderStatistics()
  } catch (err: any) {
    ElMessage.error('操作失败：' + err.message)
  }
}

// 初始化
onMounted(() => {
  getOrderStatistics()
  // 如果有订单ID参数，打开详情
  if (route.query.orderId && route.query.orderId !== 'undefined') {
    goDetail({ id: route.query.orderId, status: Number(route.query.status) || 2 })
  }
  // 启用自动搜索功能
  enableAutoSearch.value = true
})
</script>

<style scoped lang="scss">
.order-page {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>

