<template>
  <div class="art-card p-5">
    <h2 class="text-xl font-semibold mb-5 m-0">订单统计</h2>
    <div class="char-box">
      <div class="order-proportion flex items-center justify-center gap-4 mb-4 p-4 bg-gray-50 rounded">
        <div class="text-center">
          <p class="text-sm text-gray-600 mb-1">订单完成率</p>
          <p class="text-xl font-semibold text-theme">
            {{ ((orderData.orderCompletionRate || 0) * 100).toFixed(1) }}%
          </p>
        </div>
        <div class="text-2xl text-gray-400">=</div>
        <div class="text-center">
          <p class="text-sm text-gray-600 mb-1">有效订单</p>
          <p class="text-xl font-semibold text-theme">{{ orderData.validOrderCount || 0 }}</p>
        </div>
        <div class="text-2xl text-gray-400">/</div>
        <div class="text-center">
          <p class="text-sm text-gray-600 mb-1">订单总数</p>
          <p class="text-xl font-semibold text-theme">{{ orderData.totalOrderCount || 0 }}</p>
        </div>
      </div>
      <ArtLineChart
        :height="'300px'"
        :data="[
          { name: '订单总数', data: orderData.data.orderCountList || [] },
          { name: '有效订单', data: orderData.data.validOrderCountList || [] }
        ]"
        :x-axis-data="orderData.data.dateList || []"
        :colors="['#FFD000', '#FD7F7F']"
        :smooth="false"
        :show-area-color="false"
        :line-width="2.5"
        :show-legend="true"
      />
      <ul class="flex justify-center gap-4 mt-4">
        <li class="flex items-center gap-2 text-sm">
          <span class="w-3 h-3 bg-[#FFD000] rounded"></span>
          订单总数（个）
        </li>
        <li class="flex items-center gap-2 text-sm">
          <span class="w-3 h-3 bg-[#FD7F7F] rounded"></span>
          有效订单（个）
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import ArtLineChart from '@/components/core/charts/art-line-chart/index.vue'

defineOptions({ name: 'OrderStatistics' })

interface Props {
  orderData: {
    data: {
      dateList: string[]
      orderCountList: string[]
      validOrderCountList: string[]
    }
    totalOrderCount: number
    validOrderCount: number
    orderCompletionRate: number
  }
  overviewData: any
}

defineProps<Props>()
</script>

<style lang="scss" scoped>
</style>









