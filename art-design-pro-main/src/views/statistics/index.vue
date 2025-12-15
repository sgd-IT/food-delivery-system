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
    
    // 处理日期列表：过滤空字符串
    const dateListStr = turnoverDataResult.dateList || ''
    let dateList = dateListStr
      ? dateListStr.split(',').filter((item: string) => item && item.trim())
      : []
    
    // 处理营业额列表：转换为数字数组
    const turnoverListStr = turnoverDataResult.turnoverList || ''
    let turnoverList = turnoverListStr
      ? turnoverListStr
          .split(',')
          .map((item: string) => {
            const num = parseFloat(item.trim())
            return isNaN(num) ? 0 : num
          })
      : []
    
    // 确保日期列表和营业额列表长度一致（取较短的长度）
    const minLength = Math.min(dateList.length, turnoverList.length)
    if (minLength > 0) {
      dateList = dateList.slice(0, minLength)
      turnoverList = turnoverList.slice(0, minLength)
    } else {
      // 如果数据为空，重置为空数组
      dateList = []
      turnoverList = []
    }
    
    turnoverData.value = {
      dateList,
      turnoverList
    }
    
    // 调试日志
    if (process.env.NODE_ENV === 'development') {
      console.log('[营业额统计] 原始数据:', turnoverDataResult)
      console.log('[营业额统计] 处理后的数据:', turnoverData.value)
      console.log('[营业额统计] 数据长度:', {
        dateListLength: dateList.length,
        turnoverListLength: turnoverList.length
      })
    }
  } catch (error) {
    console.error('获取营业额统计数据失败:', error)
    // 发生错误时重置为空数据
    turnoverData.value = {
      dateList: [],
      turnoverList: []
    }
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
    
    // 调试日志 - 记录原始数据
    if (process.env.NODE_ENV === 'development') {
      console.log('[销量排名TOP10] 原始API响应:', top10DataResult)
      console.log('[销量排名TOP10] nameList 原始值:', top10DataResult.nameList)
      console.log('[销量排名TOP10] numberList 原始值:', top10DataResult.numberList)
    }
    
    // 处理名称列表：过滤空字符串
    const nameListStr = top10DataResult.nameList || ''
    let nameList = nameListStr
      ? nameListStr.split(',').filter((item: string) => item && item.trim())
      : []
    
    // 处理数量列表：转换为数字数组
    const numberListStr = top10DataResult.numberList || ''
    let numberList = numberListStr
      ? numberListStr
          .split(',')
          .map((item: string) => {
            const trimmed = item.trim()
            if (!trimmed) return null
            const num = parseInt(trimmed, 10)
            return isNaN(num) ? null : num
          })
          .filter((item: number | null): item is number => item !== null)
      : []
    
    // 确保名称列表和数量列表长度一致（取较短的长度，避免数据不匹配）
    const minLength = Math.min(nameList.length, numberList.length)
    if (minLength > 0) {
      nameList = nameList.slice(0, minLength)
      numberList = numberList.slice(0, minLength)
    } else {
      // 如果数据为空，重置为空数组
      nameList = []
      numberList = []
    }
    
    // 注意：后端返回的数据已经是按销量降序排列的，所以不需要反转
    // 但为了在图表中从高到低显示（顶部显示最高），我们需要反转数组
    top10Data.value = {
      nameList: nameList.reverse(),
      numberList: numberList.reverse()
    }
    
    // 调试日志 - 记录处理后的数据
    if (process.env.NODE_ENV === 'development') {
      console.log('[销量排名TOP10] 处理后的数据:', top10Data.value)
      console.log('[销量排名TOP10] 数据统计:', {
        nameListLength: nameList.length,
        numberListLength: numberList.length,
        nameList: nameList,
        numberList: numberList,
        note: nameList.length < 10 ? `只显示了 ${nameList.length} 个菜品，可能是数据库中在选定时间范围内只有这些菜品有销量` : '显示了完整的TOP10数据'
      })
    }
  } catch (error) {
    console.error('获取排行数据失败:', error)
    // 发生错误时重置为空数据
    top10Data.value = {
      nameList: [],
      numberList: []
    }
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

