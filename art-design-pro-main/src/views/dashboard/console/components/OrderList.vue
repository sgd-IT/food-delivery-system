<template>
  <div class="art-card p-5">
    <h2 class="text-xl font-semibold mb-5 m-0">
      订单信息
      <ul class="inline-flex gap-2 ml-4">
        <li
          v-for="(item, index) in tabList"
          :key="index"
          :class="[
            'px-3 py-1 rounded cursor-pointer transition-colors',
            activeIndex === index ? 'bg-theme text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
          ]"
          @click="handleClass(index)"
        >
          <ElBadge
            :value="item.num > 99 ? '99+' : item.num"
            :hidden="!([2, 3].includes(item.value) && item.num)"
            class="item"
          >
            {{ item.label }}
          </ElBadge>
        </li>
      </ul>
    </h2>
    <div>
      <ArtTable
        v-if="orderData.length > 0"
        :data="orderData"
        stripe
        @row-click="handleTable"
      >
        <ElTableColumn prop="number" label="订单号" />
        <ElTableColumn label="订单菜品">
          <template #default="{ row }">
            <ElPopover
              placement="top-start"
              width="200"
              trigger="hover"
              :content="row.orderDishes"
            >
              <template #reference>
                <span class="ellipsis">{{ row.orderDishes }}</span>
              </template>
            </ElPopover>
          </template>
        </ElTableColumn>
        <ElTableColumn label="地址">
          <template #default="{ row }">
            <ElPopover
              placement="top-start"
              width="200"
              trigger="hover"
              :content="row.address"
            >
              <template #reference>
                <span class="ellipsis">{{ row.address }}</span>
              </template>
            </ElPopover>
          </template>
        </ElTableColumn>
        <ElTableColumn prop="estimatedDeliveryTime" label="预计送达时间" sortable min-width="130" />
        <ElTableColumn prop="amount" label="实收金额" />
        <ElTableColumn label="备注">
          <template #default="{ row }">
            <ElPopover
              placement="top-start"
              width="200"
              trigger="hover"
              :content="row.remark"
            >
              <template #reference>
                <span class="ellipsis">{{ row.remark }}</span>
              </template>
            </ElPopover>
          </template>
        </ElTableColumn>
        <ElTableColumn
          v-if="status === 3"
          prop="tablewareNumber"
          label="餐具数量"
          min-width="80"
          align="center"
        />
        <ElTableColumn label="操作" align="center" min-width="140">
          <template #default="{ row }">
            <div class="flex items-center justify-center gap-2">
              <ElButton
                v-if="row.status === 2"
                type="primary"
                link
                @click.stop="handleOrderAccept(row, $event)"
              >
                接单
              </ElButton>
              <ElButton
                v-if="row.status === 3"
                type="primary"
                link
                @click.stop="cancelOrDeliveryOrComplete(3, row.id, $event)"
              >
                派送
              </ElButton>
              <ElButton
                v-if="row.status === 2"
                type="danger"
                link
                @click.stop="handleOrderReject(row, $event)"
              >
                拒单
              </ElButton>
              <ElButton
                v-if="[1, 3, 4, 5].includes(row.status)"
                type="danger"
                link
                @click.stop="cancelOrder(row, $event)"
              >
                取消
              </ElButton>
              <ElButton type="primary" link @click.stop="goDetail(row.id, row.status, row, $event)">
                查看
              </ElButton>
            </div>
          </template>
        </ElTableColumn>
      </ArtTable>
      <ElEmpty v-else description="暂无订单数据" :image-size="120" />
      <ElPagination
        v-if="counts > 10"
        class="mt-5"
        :page-sizes="[10, 20, 30, 40]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="counts"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>

    <!-- 查看订单详情弹窗 -->
    <ElDialog
      v-model="dialogVisible"
      title="订单信息"
      width="53%"
      :before-close="handleClose"
    >
      <ElScrollbar style="height: 400px">
        <div class="order-top pb-4 border-b mb-4">
          <div class="flex items-center">
            <div class="inline-block">
              <label class="text-base">订单号：</label>
              <div class="order-num inline-block text-base font-bold ml-2">
                {{ diaForm.number }}
              </div>
            </div>
            <div
              class="inline-block ml-4 px-3 py-1 rounded text-white text-sm"
              :class="[3, 4].includes(dialogOrderStatus) ? 'bg-red-500' : 'bg-gray-800'"
            >
              {{ orderList.find((item) => item.value === dialogOrderStatus)?.label }}
            </div>
          </div>
          <p class="mt-2 text-gray-600">
            <label>下单时间：</label>{{ diaForm.orderTime }}
          </p>
        </div>

        <div class="order-middle">
          <div class="user-info bg-gray-50 p-5 rounded mb-4">
            <div class="user-info-box flex flex-wrap gap-4 mb-3">
              <div class="user-name">
                <label class="text-gray-600 mr-2">用户名：</label>
                <span>{{ diaForm.consignee }}</span>
              </div>
              <div class="user-phone">
                <label class="text-gray-600 mr-2">手机号：</label>
                <span>{{ diaForm.phone }}</span>
              </div>
              <div v-if="[2, 3, 4, 5].includes(dialogOrderStatus)" class="user-getTime w-full mt-2">
                <label class="text-gray-600 mr-2">
                  {{ dialogOrderStatus === 5 ? '送达时间：' : '预计送达时间：' }}
                </label>
                <span>
                  {{ dialogOrderStatus === 5 ? diaForm.deliveryTime : diaForm.estimatedDeliveryTime }}
                </span>
              </div>
              <div class="user-address w-full mt-2">
                <label class="text-gray-600 mr-2">地址：</label>
                <span>{{ diaForm.address }}</span>
              </div>
            </div>
            <div
              class="user-remark p-3 rounded flex items-center"
              :class="dialogOrderStatus === 6 ? 'bg-white border border-gray-300' : 'bg-yellow-50 border border-yellow-300'"
            >
              <div
                class="inline-block min-w-[53px] h-8 rounded text-center leading-8 mr-4"
                :class="dialogOrderStatus === 6 ? 'bg-gray-200 text-gray-700' : 'bg-yellow-300 text-gray-700'"
              >
                {{ dialogOrderStatus === 6 ? '取消原因' : '备注' }}
              </div>
              <span :class="dialogOrderStatus === 6 ? 'text-red-500' : 'text-yellow-600'">
                {{
                  dialogOrderStatus === 6
                    ? diaForm.cancelReason || diaForm.rejectionReason
                    : diaForm.remark
                }}
              </span>
            </div>
          </div>

          <div class="dish-info flex flex-wrap p-5 border-b">
            <div class="dish-label text-gray-600 mb-4 w-full">菜品</div>
            <div class="dish-list flex-1 flex flex-wrap gap-4">
              <div
                v-for="(item, index) in diaForm.orderDetailList"
                :key="index"
                class="dish-item flex-1 min-w-[200px]"
              >
                <span class="dish-name">{{ item.name }}</span>
                <span class="dish-num mx-4">x{{ item.number }}</span>
                <span class="dish-price text-red-500">￥{{ item.amount ? item.amount.toFixed(2) : '' }}</span>
              </div>
            </div>
            <div class="dish-all-amount w-full mt-4 text-right">
              <label class="font-bold mr-2">菜品小计</label>
              <span class="text-red-500">
                ￥{{ ((diaForm.amount - 6 - diaForm.packAmount) || 0).toFixed(2) }}
              </span>
            </div>
          </div>
        </div>

        <div class="order-bottom mt-4">
          <div class="amount-info flex flex-wrap p-5">
            <div class="amount-label text-gray-600 mb-4 w-full">费用</div>
            <div class="amount-list flex-1 flex flex-wrap gap-4">
              <div class="dish-amount w-[300px]">
                <span class="amount-name">菜品小计：</span>
                <span class="amount-price">
                  ￥{{ ((diaForm.amount - 6 - (diaForm.packAmount || 2)) || 0).toFixed(2) }}
                </span>
              </div>
              <div class="send-amount w-[300px]">
                <span class="amount-name">派送费：</span>
                <span class="amount-price">￥6</span>
              </div>
              <div class="package-amount w-[300px]">
                <span class="amount-name">打包费：</span>
                <span class="amount-price">
                  ￥{{ (diaForm.packAmount || 2).toFixed(2) }}
                </span>
              </div>
              <div class="all-amount w-[300px]">
                <span class="amount-name">合计：</span>
                <span class="amount-price text-red-500">
                  ￥{{ diaForm.amount ? diaForm.amount.toFixed(2) : '0.00' }}
                </span>
              </div>
              <div class="pay-type w-[300px]">
                <span class="pay-name">支付渠道：</span>
                <span class="pay-value">{{ diaForm.payMethod === 1 ? '微信支付' : '支付宝支付' }}</span>
              </div>
              <div class="pay-time w-[300px]">
                <span class="pay-name">支付时间：</span>
                <span class="pay-value">{{ diaForm.checkoutTime }}</span>
              </div>
            </div>
          </div>
        </div>
      </ElScrollbar>
      <template v-if="dialogOrderStatus !== 6" #footer>
        <div class="flex items-center justify-between">
          <ElCheckbox
            v-if="dialogOrderStatus === 2 && status === 2"
            v-model="isAutoNext"
          >
            处理完自动跳转下一条
          </ElCheckbox>
          <div class="flex gap-2">
            <ElButton v-if="dialogOrderStatus === 2" @click="handleOrderReject(row, $event)">
              拒 单
            </ElButton>
            <ElButton
              v-if="dialogOrderStatus === 2"
              type="primary"
              @click="handleOrderAccept(row, $event)"
            >
              接 单
            </ElButton>
            <ElButton v-if="[1, 3, 4, 5].includes(dialogOrderStatus)" @click="dialogVisible = false">
              返 回
            </ElButton>
            <ElButton
              v-if="dialogOrderStatus === 3"
              type="primary"
              @click="cancelOrDeliveryOrComplete(3, row.id, $event)"
            >
              派 送
            </ElButton>
            <ElButton
              v-if="dialogOrderStatus === 4"
              type="primary"
              @click="cancelOrDeliveryOrComplete(4, row.id, $event)"
            >
              完 成
            </ElButton>
            <ElButton
              v-if="[1].includes(dialogOrderStatus)"
              type="primary"
              @click="cancelOrder(row, $event)"
            >
              取消订单
            </ElButton>
          </div>
        </div>
      </template>
    </ElDialog>

    <!-- 拒单/取消弹窗 -->
    <ElDialog
      v-model="cancelDialogVisible"
      :title="cancelDialogTitle + '原因'"
      width="42%"
      :before-close="() => ((cancelDialogVisible = false), (cancelReason = ''))"
    >
      <ElForm label-width="90px">
        <ElFormItem :label="cancelDialogTitle + '原因：'">
          <ElSelect
            v-model="cancelReason"
            :placeholder="'请选择' + cancelDialogTitle + '原因'"
            class="w-full"
          >
            <ElOption
              v-for="(item, index) in cancelDialogTitle === '取消' ? cancelrReasonList : cancelOrderReasonList"
              :key="index"
              :label="item.label"
              :value="item.label"
            />
          </ElSelect>
        </ElFormItem>
        <ElFormItem v-if="cancelReason === '自定义原因'" label="原因：">
          <ElInput
            v-model.trim="remark"
            type="textarea"
            :placeholder="'请填写您' + cancelDialogTitle + '的原因（限20字内）'"
            maxlength="20"
          />
        </ElFormItem>
      </ElForm>
      <template #footer>
        <ElButton @click="cancelDialogVisible = false; cancelReason = ''">取 消</ElButton>
        <ElButton type="primary" @click="confirmCancel">确 定</ElButton>
      </template>
    </ElDialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import {
  getOrderDetailPage,
  queryOrderDetailById,
  completeOrder,
  deliveryOrder,
  orderCancel,
  orderReject,
  orderAccept
} from '@/api/order'
import ArtTable from '@/components/core/tables/art-table/index.vue'

defineOptions({ name: 'OrderList' })

interface Props {
  orderStatics: any
}

const props = defineProps<Props>()

const emit = defineEmits<{
  'get-order-list-by3-status': []
}>()

const orderId = ref('')
const dialogOrderStatus = ref(0)
const activeIndex = ref(0)
const dialogVisible = ref(false)
const cancelDialogVisible = ref(false)
const cancelDialogTitle = ref('')
const cancelReason = ref('')
const remark = ref('')
const diaForm = ref<any>({})
const row = ref<any>({})
const isAutoNext = ref(true)
const counts = ref(0)
const page = ref(1)
const pageSize = ref(10)
const status = ref(2)
const orderData = ref<any[]>([])

const cancelOrderReasonList = [
  { value: 1, label: '订单量较多，暂时无法接单' },
  { value: 2, label: '菜品已销售完，暂时无法接单' },
  { value: 3, label: '餐厅已打烊，暂时无法接单' },
  { value: 0, label: '自定义原因' }
]

const cancelrReasonList = [
  { value: 1, label: '订单量较多，暂时无法接单' },
  { value: 2, label: '菜品已销售完，暂时无法接单' },
  { value: 3, label: '骑手不足无法配送' },
  { value: 4, label: '客户电话取消' },
  { value: 0, label: '自定义原因' }
]

const orderList = [
  { label: '全部订单', value: 0 },
  { label: '待付款', value: 1 },
  { label: '待接单', value: 2 },
  { label: '待派送', value: 3 },
  { label: '派送中', value: 4 },
  { label: '已完成', value: 5 },
  { label: '已取消', value: 6 }
]

const tabList = computed(() => [
  {
    label: '待接单',
    value: 2,
    num: props.orderStatics?.toBeConfirmed || 0
  },
  {
    label: '待派送',
    value: 3,
    num: props.orderStatics?.confirmed || 0
  }
])

// 获取订单数据
const getOrderListData = async (orderStatus: number) => {
  const params = {
    page: page.value,
    pageSize: pageSize.value,
    status: orderStatus
  }
  try {
    const data = await getOrderDetailPage(params)
    orderData.value = data?.records || []
    counts.value = data?.total || 0
    emit('get-order-list-by3-status')
    
    if (
      dialogOrderStatus.value === 2 &&
      status.value === 2 &&
      isAutoNext.value &&
      data?.records?.length > 1
    ) {
      const firstRow = data.records[0]
      goDetail(firstRow.id, firstRow.status, firstRow, firstRow)
    }
  } catch (error) {
    console.error('获取订单列表失败:', error)
  }
}

// 接单
const handleOrderAccept = async (rowItem: any, event: Event) => {
  event.stopPropagation()
  orderId.value = rowItem.id
  dialogOrderStatus.value = rowItem.status
  try {
    await orderAccept({ id: orderId.value })
    ElMessage.success('操作成功')
    orderId.value = ''
    dialogVisible.value = false
    getOrderListData(status.value)
  } catch (error: any) {
    ElMessage.error(error.message || '操作失败')
  }
}

// 打开取消订单弹窗
const cancelOrder = (rowItem: any, event: Event) => {
  event.stopPropagation()
  cancelDialogVisible.value = true
  orderId.value = rowItem.id
  dialogOrderStatus.value = rowItem.status
  cancelDialogTitle.value = '取消'
  dialogVisible.value = false
  cancelReason.value = ''
}

// 打开拒单弹窗
const handleOrderReject = (rowItem: any, event: Event) => {
  event.stopPropagation()
  cancelDialogVisible.value = true
  orderId.value = rowItem.id
  dialogOrderStatus.value = rowItem.status
  cancelDialogTitle.value = '拒绝'
  dialogVisible.value = false
  cancelReason.value = ''
}

// 确认取消或拒绝订单
const confirmCancel = async () => {
  if (!cancelReason.value) {
    ElMessage.error(`请选择${cancelDialogTitle.value}原因`)
    return
  }
  if (cancelReason.value === '自定义原因' && !remark.value) {
    ElMessage.error(`请输入${cancelDialogTitle.value}原因`)
    return
  }

  const params = {
    id: orderId.value,
    [cancelDialogTitle.value === '取消' ? 'cancelReason' : 'rejectionReason']:
      cancelReason.value === '自定义原因' ? remark.value : cancelReason.value
  }

  try {
    if (cancelDialogTitle.value === '取消') {
      await orderCancel(params)
    } else {
      await orderReject(params)
    }
    ElMessage.success('操作成功')
    cancelDialogVisible.value = false
    orderId.value = ''
    getOrderListData(status.value)
  } catch (error: any) {
    ElMessage.error(error.message || '操作失败')
  }
}

// 派送/完成
const cancelOrDeliveryOrComplete = async (orderStatus: number, id: string, event: Event) => {
  event.stopPropagation()
  try {
    if (orderStatus === 3) {
      await deliveryOrder({ id })
    } else {
      await completeOrder({ id })
    }
    ElMessage.success('操作成功')
    orderId.value = ''
    dialogVisible.value = false
    getOrderListData(status.value)
  } catch (error: any) {
    ElMessage.error(error.message || '操作失败')
  }
}

// 查看详情
const goDetail = async (id: any, orderStatus: number, rowItem: any, event: Event) => {
  event.stopPropagation()
  diaForm.value = {}
  dialogVisible.value = true
  dialogOrderStatus.value = orderStatus
  try {
    const data = await queryOrderDetailById({ orderId: id })
    diaForm.value = data || {}
    row.value = rowItem
  } catch (error) {
    console.error('获取订单详情失败:', error)
  }
}

// 关闭弹层
const handleClose = () => {
  dialogVisible.value = false
}

// tab切换
const handleClass = (index: number) => {
  activeIndex.value = index
  if (index === 0) {
    status.value = 2
    getOrderListData(2)
  } else {
    status.value = 3
    getOrderListData(3)
  }
}

// 触发table某一行
const handleTable = (rowItem: any) => {
  goDetail(rowItem.id, rowItem.status, rowItem, new Event('click'))
}

// 分页
const handleSizeChange = (val: number) => {
  pageSize.value = val
  getOrderListData(status.value)
}

const handleCurrentChange = (val: number) => {
  page.value = val
  getOrderListData(status.value)
}

onMounted(() => {
  getOrderListData(status.value)
})
</script>

<style lang="scss" scoped>
.ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 200px;
  display: inline-block;
}
</style>

