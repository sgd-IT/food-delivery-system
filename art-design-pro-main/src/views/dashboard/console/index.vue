<template>
  <div class="dashboard-container p-5">
    <!-- 营业数据 -->
    <Overview :overview-data="overviewData" />

    <!-- 订单管理 -->
    <Orderview :orderview-data="orderviewData" />

    <div class="home-main grid grid-cols-2 gap-5 mt-5">
      <!-- 菜品总览 -->
      <CuisineStatistics :dishes-data="dishesData" />

      <!-- 套餐总览 -->
      <SetMealStatistics :set-meal-data="setMealData" />
    </div>

    <!-- 订单信息 -->
    <OrderList
      :order-statics="orderStatics"
      @get-order-list-by3-status="getOrderListBy3Status"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import {
  getBusinessData,
  getOrderData,
  getOverviewDishes,
  getSetMealStatistics
} from '@/api/index'
import { getOrderListBy } from '@/api/order'
import Overview from './components/Overview.vue'
import Orderview from './components/Orderview.vue'
import CuisineStatistics from './components/CuisineStatistics.vue'
import SetMealStatistics from './components/SetMealStatistics.vue'
import OrderList from './components/OrderList.vue'

defineOptions({ name: 'Dashboard' })

// 营业数据
const overviewData = ref<any>({})
// 订单管理数据
const orderviewData = ref<any>({})
// 菜品总览数据
const dishesData = ref<any>({})
// 套餐总览数据
const setMealData = ref<any>({})
// 订单统计
const orderStatics = ref<any>({})

// 初始化数据
const init = () => {
  fetchBusinessData()
  getOrderStatisticsData()
  getOverStatisticsData()
  getSetMealStatisticsData()
}

// 获取营业数据
const fetchBusinessData = async () => {
  try {
    const data = await getBusinessData()
    overviewData.value = data || {}
  } catch (error) {
    console.error('获取营业数据失败:', error)
  }
}

// 获取今日订单
const getOrderStatisticsData = async () => {
  try {
    const data = await getOrderData()
    orderviewData.value = data || {}
  } catch (error) {
    console.error('获取订单数据失败:', error)
  }
}

// 获取菜品总览数据
const getOverStatisticsData = async () => {
  try {
    const data = await getOverviewDishes()
    dishesData.value = data || {}
  } catch (error) {
    console.error('获取菜品总览数据失败:', error)
  }
}

// 获取套餐总览数据
const getSetMealStatisticsData = async () => {
  try {
    const data = await getSetMealStatistics()
    setMealData.value = data || {}
  } catch (error) {
    console.error('获取套餐总览数据失败:', error)
  }
}

// 获取待处理，待派送，派送中数量
const getOrderListBy3Status = async () => {
  try {
    const data = await getOrderListBy({})
    orderStatics.value = data || {}
  } catch (error) {
    console.error('获取订单统计失败:', error)
  }
}

onMounted(() => {
  init()
})
</script>

<style lang="scss" scoped>
.dashboard-container {
  .home-main {
    @media (max-width: 768px) {
      grid-template-columns: 1fr;
    }
  }
}
</style>
