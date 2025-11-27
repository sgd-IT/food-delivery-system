<template>
  <div class="dashboard-container p-5">
    <!-- 标题和时间选择 -->
    <TitleIndex @send-title-ind="getTitleNum" :flag="flag" :tate-data="tateData" />

    <div class="grid grid-cols-2 gap-5 mt-5">
      <!-- 营业额统计 -->
      <TurnoverStatistics :turnover-data="turnoverData" />

      <!-- 用户统计 -->
      <UserStatistics :user-data="userData" />
    </div>

    <div class="grid grid-cols-2 gap-5 mt-5">
      <!-- 订单统计 -->
      <OrderStatistics :order-data="orderData" :overview-data="overviewData" />

      <!-- 销量排名TOP10 -->
      <Top :top10-data="top10Data" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import {
  get1stAndToday,
  past7Day,
  past30Day,
  pastWeek,
  pastMonth
} from '@/utils/date'
import {
  getDataOverView,
  getTurnoverStatistics,
  getUserStatistics,
  getOrderStatistics,
  getTop
} from '@/api/index'
import TitleIndex from './components/TitleIndex.vue'
import Overview from './components/Overview.vue'
import TurnoverStatistics from './components/TurnoverStatistics.vue'
import UserStatistics from './components/UserStatistics.vue'
import OrderStatistics from './components/OrderStatistics.vue'
import Top from './components/Top10.vue'

defineOptions({ name: 'Statistics' })

const overviewData = ref<any>({})
const flag = ref(2)
const tateData = ref<string[]>([])
const turnoverData = ref<any>({})
const userData = ref<any>({})
const orderData = ref<any>({
  data: {}
})
const top10Data = ref<any>({})

// 获取数据概览
const getDataOverViewData = async (begin: string, end: string) => {
  try {
    const data = await getDataOverView({ begin, end })
    overviewData.value = data || {}
  } catch (error) {
    console.error('获取数据概览失败:', error)
  }
}

// 获取基本数据
const init = (begin: string, end: string) => {
  getDataOverViewData(begin, end)
  getTurnoverStatisticsData(begin, end)
  getUserStatisticsData(begin, end)
  getOrderStatisticsData(begin, end)
  getTopData(begin, end)
}

// 获取营业额统计数据
const getTurnoverStatisticsData = async (begin: string, end: string) => {
  try {
    const data = await getTurnoverStatistics({ begin, end })
    const turnoverDataResult = data || {}
    turnoverData.value = {
      dateList: turnoverDataResult.dateList?.split(',') || [],
      turnoverList: turnoverDataResult.turnoverList?.split(',') || []
    }
  } catch (error) {
    console.error('获取营业额统计数据失败:', error)
  }
}

// 获取用户统计数据
const getUserStatisticsData = async (begin: string, end: string) => {
  try {
    const data = await getUserStatistics({ begin, end })
    const userDataResult = data || {}
    userData.value = {
      dateList: userDataResult.dateList?.split(',') || [],
      totalUserList: userDataResult.totalUserList?.split(',') || [],
      newUserList: userDataResult.newUserList?.split(',') || []
    }
  } catch (error) {
    console.error('获取用户统计数据失败:', error)
  }
}

// 获取订单统计数据
const getOrderStatisticsData = async (begin: string, end: string) => {
  try {
    const data = await getOrderStatistics({ begin, end })
    const orderDataResult = data || {}
    orderData.value = {
      data: {
        dateList: orderDataResult.dateList?.split(',') || [],
        orderCountList: orderDataResult.orderCountList?.split(',') || [],
        validOrderCountList: orderDataResult.validOrderCountList?.split(',') || []
      },
      totalOrderCount: orderDataResult.totalOrderCount || 0,
      validOrderCount: orderDataResult.validOrderCount || 0,
      orderCompletionRate: orderDataResult.orderCompletionRate || 0
    }
  } catch (error) {
    console.error('获取订单统计数据失败:', error)
  }
}

// 获取排行数据
const getTopData = async (begin: string, end: string) => {
  try {
    const data = await getTop({ begin, end })
    const top10DataResult = data || {}
    top10Data.value = {
      nameList: top10DataResult.nameList?.split(',').reverse() || [],
      numberList: top10DataResult.numberList?.split(',').reverse() || []
    }
  } catch (error) {
    console.error('获取排行数据失败:', error)
  }
}

// 获取当前选中的tab时间
const getTitleNum = (data: number) => {
  let dateRange: string[] = []
  switch (data) {
    case 1:
      dateRange = get1stAndToday()
      break
    case 2:
      dateRange = past7Day()
      break
    case 3:
      dateRange = past30Day()
      break
    case 4:
      dateRange = pastWeek()
      break
    case 5:
      dateRange = pastMonth()
      break
  }
  tateData.value = dateRange
  init(dateRange[0], dateRange[1])
}

onMounted(() => {
  getTitleNum(2)
})
</script>

<style lang="scss" scoped>
.dashboard-container {
  @media (max-width: 768px) {
    .grid {
      grid-template-columns: 1fr;
    }
  }
}
</style>

