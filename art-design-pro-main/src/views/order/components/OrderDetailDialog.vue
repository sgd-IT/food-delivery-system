<template>
  <ElDialog
    v-model="dialogVisible"
    title="订单信息"
    width="53%"
    :before-close="handleClose"
    class="order-dialog"
  >
    <ElScrollbar style="height: 100%">
      <div class="order-top">
        <div>
          <div style="display: inline-block">
            <label style="font-size: 16px">订单号：</label>
            <div class="order-num">{{ orderData.number }}</div>
          </div>
          <div
            class="order-status"
            :class="{ status3: [3, 4].includes(orderStatus) }"
          >
            {{ getOrderStatusText(orderStatus) }}
          </div>
        </div>
        <p><label>下单时间：</label>{{ orderData.orderTime }}</p>
      </div>

      <div class="order-middle">
        <div class="user-info">
          <div class="user-info-box">
            <div class="user-name">
              <label>用户名：</label>
              <span>{{ orderData.consignee }}</span>
            </div>
            <div class="user-phone">
              <label>手机号：</label>
              <span>{{ orderData.phone }}</span>
            </div>
            <div v-if="[2, 3, 4, 5].includes(orderStatus)" class="user-getTime">
              <label>{{ orderStatus === 5 ? '送达时间：' : '预计送达时间：' }}</label>
              <span>{{ orderStatus === 5 ? orderData.deliveryTime : orderData.estimatedDeliveryTime }}</span>
            </div>
            <div v-if="orderData.orderType" class="user-order-type">
              <label>订单类型：</label>
              <ElTag :type="orderData.orderType === 1 ? 'warning' : 'success'" size="small">
                {{ orderData.orderType === 1 ? '到店自取' : '外卖配送' }}
              </ElTag>
            </div>
            <div class="user-address">
              <label>地址：</label>
              <span>{{ orderData.address }}</span>
            </div>
          </div>
          <div
            class="user-remark"
            :class="{ orderCancel: orderStatus === 6 }"
          >
            <div>{{ orderStatus === 6 ? '取消原因' : '备注' }}</div>
            <span>{{ orderStatus === 6 ? orderData.cancelReason || orderData.rejectionReason : orderData.remark }}</span>
          </div>
        </div>

        <div class="dish-info">
          <div class="dish-label">菜品</div>
          <div class="dish-list">
            <div
              v-for="(item, index) in orderData.orderDetailList"
              :key="index"
              class="dish-item"
            >
              <div class="dish-item-box">
                <span class="dish-name">{{ item.name }}</span>
                <span class="dish-num">x{{ item.number }}</span>
              </div>
              <span class="dish-price">￥{{ item.amount ? item.amount.toFixed(2) : '' }}</span>
            </div>
          </div>
          <div class="dish-all-amount">
            <label>菜品小计</label>
            <span>￥{{ ((orderData.amount - 6 - (orderData.packAmount || 0)) * 100) / 100 }}</span>
          </div>
        </div>
      </div>

      <div class="order-bottom">
        <div class="amount-info">
          <div class="amount-label">费用</div>
          <div class="amount-list">
            <div class="dish-amount">
              <span class="amount-name">菜品小计：</span>
              <span class="amount-price">￥{{ ((orderData.amount - 6 - (orderData.packAmount || 0)) * 100) / 100 }}</span>
            </div>
            <div class="send-amount">
              <span class="amount-name">派送费：</span>
              <span class="amount-price">￥6</span>
            </div>
            <div class="package-amount">
              <span class="amount-name">打包费：</span>
              <span class="amount-price">￥{{ orderData.packAmount ? ((orderData.packAmount * 100) / 100).toFixed(2) : '' }}</span>
            </div>
            <div class="all-amount">
              <span class="amount-name">合计：</span>
              <span class="amount-price">￥{{ orderData.amount ? ((orderData.amount * 100) / 100).toFixed(2) : '' }}</span>
            </div>
            <div class="pay-type">
              <span class="pay-name">支付渠道：</span>
              <span class="pay-value">{{ orderData.payMethod === 1 ? '微信支付' : '支付宝支付' }}</span>
            </div>
            <div class="pay-time">
              <span class="pay-name">支付时间：</span>
              <span class="pay-value">{{ orderData.checkoutTime }}</span>
            </div>
          </div>
        </div>
      </div>
    </ElScrollbar>
    <template v-if="orderStatus !== 6" #footer>
      <ElCheckbox v-if="orderStatus === 2" v-model="isAutoNext">处理完自动跳转下一条</ElCheckbox>
      <ElButton v-if="orderStatus === 2" @click="handleReject">拒 单</ElButton>
      <ElButton v-if="orderStatus === 2" type="primary" @click="handleAccept">接 单</ElButton>
      <ElButton v-if="[1, 3, 4, 5].includes(orderStatus)" @click="dialogVisible = false">返 回</ElButton>
      <ElButton v-if="orderStatus === 3" type="primary" @click="handleDelivery">派 送</ElButton>
      <ElButton v-if="orderStatus === 4" type="primary" @click="handleComplete">完 成</ElButton>
      <ElButton v-if="[1].includes(orderStatus)" type="primary" @click="handleCancel">取消订单</ElButton>
    </template>
  </ElDialog>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { ElDialog, ElScrollbar, ElTag, ElCheckbox, ElButton } from 'element-plus'

defineOptions({ name: 'OrderDetailDialog' })

interface Props {
  visible: boolean
  orderData?: any
  orderStatus?: number
}

const props = withDefaults(defineProps<Props>(), {
  visible: false,
  orderData: () => ({}),
  orderStatus: 0
})

const emit = defineEmits<{
  'update:visible': [value: boolean]
  accept: [data: any]
  reject: [data: any]
  delivery: [data: any]
  complete: [data: any]
  cancel: [data: any]
}>()

const dialogVisible = computed({
  get: () => props.visible,
  set: (val) => emit('update:visible', val)
})

const isAutoNext = ref(true)

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

const handleClose = () => {
  dialogVisible.value = false
}

const handleAccept = () => {
  emit('accept', props.orderData)
}

const handleReject = () => {
  emit('reject', props.orderData)
}

const handleDelivery = () => {
  emit('delivery', props.orderData)
}

const handleComplete = () => {
  emit('complete', props.orderData)
}

const handleCancel = () => {
  emit('cancel', props.orderData)
}
</script>

<style scoped lang="scss">
.order-top {
  border-bottom: 1px solid #e7e6e6;
  padding-bottom: 26px;
  padding-left: 22px;
  padding-right: 22px;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .order-status {
    width: 57.25px;
    height: 27px;
    background: #0091ff;
    border-radius: 13.5px;
    color: white;
    margin-left: 19px;
    text-align: center;
    line-height: 27px;
    font-size: 12px;
  }

  .status3 {
    background: #ffc200;
  }

  p {
    color: #333;
    label {
      color: #666;
    }
  }

  .order-num {
    font-size: 16px;
    color: #2a2929;
    font-weight: bold;
    display: inline-block;
  }
}

.order-middle {
  .user-info {
    min-height: 140px;
    background: #fbfbfa;
    margin-top: 23px;
    padding: 20px 43px;
    color: #333;

    .user-info-box {
      min-height: 55px;
      display: flex;
      flex-wrap: wrap;

      .user-name {
        flex: 67%;
      }

      .user-phone {
        flex: 33%;
      }

      .user-getTime {
        margin-top: 14px;
        flex: 80%;
        label {
          margin-right: 3px;
        }
      }

      label {
        margin-right: 17px;
        color: #666;
      }

      .user-address {
        margin-top: 14px;
        flex: 80%;
        label {
          margin-right: 30px;
        }
      }

      .user-order-type {
        margin-top: 14px;
        flex: 80%;
        label {
          margin-right: 17px;
          color: #666;
        }
      }
    }

    .user-remark {
      min-height: 43px;
      line-height: 43px;
      background: #fffbf0;
      border: 1px solid #fbe396;
      border-radius: 4px;
      margin-top: 10px;
      padding: 6px;
      display: flex;
      align-items: center;

      div {
        display: inline-block;
        min-width: 53px;
        height: 32px;
        background: #fbe396;
        border-radius: 4px;
        text-align: center;
        line-height: 32px;
        color: #333;
        margin-right: 30px;
      }

      span {
        color: #f2a402;
        line-height: 1.15;
      }
    }

    .orderCancel {
      background: #ffffff;
      border: 1px solid #b6b6b6;

      div {
        padding: 0 10px;
        background-color: #e5e4e4;
      }

      span {
        color: #f56c6c;
      }
    }
  }

  .dish-info {
    display: flex;
    flex-wrap: wrap;
    padding: 20px 40px;
    border-bottom: 1px solid #e7e6e6;

    .dish-label {
      color: #666;
      margin-right: 65px;
    }

    .dish-list {
      flex: 80%;
      display: flex;
      flex-wrap: wrap;

      .dish-item {
        flex: 50%;
        margin-bottom: 14px;
        color: #333;
        display: flex;
        justify-content: space-between;

        .dish-item-box {
          display: inline-block;
          width: 120px;
        }
      }
    }

    .dish-all-amount {
      flex: 1;
      padding-left: 92px;
      margin-top: 10px;

      label {
        color: #333333;
        font-weight: bold;
        margin-right: 5px;
      }

      span {
        color: #f56c6c;
      }
    }
  }
}

.order-bottom {
  .amount-info {
    display: flex;
    flex-wrap: wrap;
    padding: 20px 40px;
    padding-bottom: 0px;

    .amount-label {
      color: #666;
      margin-right: 65px;
    }

    .amount-list {
      flex: 80%;
      display: flex;
      flex-wrap: wrap;
      color: #333;

      .dish-amount,
      .package-amount,
      .pay-type {
        display: inline-block;
        width: 300px;
        margin-bottom: 14px;
        flex: 50%;
      }

      .send-amount,
      .all-amount,
      .pay-time {
        display: inline-block;
        flex: 50%;
        padding-left: 10%;
      }

      .all-amount {
        .amount-price {
          color: #f56c6c;
        }
      }
    }
  }
}
</style>

