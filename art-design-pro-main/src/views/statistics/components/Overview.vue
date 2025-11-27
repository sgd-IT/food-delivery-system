<template>
  <div class="art-card p-5">
    <h2 class="text-xl font-semibold mb-5 m-0">数据概览</h2>
    <div class="grid grid-cols-6 gap-4">
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">营业额</p>
        <p class="text-2xl font-semibold text-theme">{{ overviewData.turnover || 0 }}</p>
        <p class="text-xs text-gray-500 mt-1">
          同比增长
          <span
            v-if="overviewData.turnoverGrowth"
            :class="overviewData.turnoverGrowth > 0 ? 'text-red-500' : 'text-green-500'"
          >
            {{ overviewData.turnoverGrowth > 0 ? '+' : '' }}{{ overviewData.turnoverGrowth }}%
          </span>
          <span v-else>-</span>
        </p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">有效订单</p>
        <p class="text-2xl font-semibold text-theme">{{ overviewData.validOrderCount || 0 }}</p>
        <p class="text-xs text-gray-500 mt-1">
          同比增长
          <span
            v-if="overviewData.validOrderCountGrowth"
            :class="overviewData.validOrderCountGrowth > 0 ? 'text-red-500' : 'text-green-500'"
          >
            {{ overviewData.validOrderCountGrowth > 0 ? '+' : '' }}{{ overviewData.validOrderCountGrowth }}%
          </span>
          <span v-else>-</span>
        </p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">订单完成率</p>
        <p class="text-2xl font-semibold text-theme">
          {{ ((overviewData.orderCompletionRate || 0) * 100).toFixed(2) }}%
        </p>
        <p class="text-xs text-gray-500 mt-1">
          同比增长
          <span
            v-if="overviewData.orderCompletionRateGrowth"
            :class="overviewData.orderCompletionRateGrowth > 0 ? 'text-red-500' : 'text-green-500'"
          >
            {{ overviewData.orderCompletionRateGrowth > 0 ? '+' : '' }}{{ overviewData.orderCompletionRateGrowth }}%
          </span>
          <span v-else>-</span>
        </p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">平均客单价</p>
        <p class="text-2xl font-semibold text-theme">
          {{ (overviewData.unitPrice || 0).toFixed(2) }}
        </p>
        <p class="text-xs text-gray-500 mt-1">
          同比增长
          <span
            v-if="overviewData.unitPriceGrowth"
            :class="overviewData.unitPriceGrowth > 0 ? 'text-red-500' : 'text-green-500'"
          >
            {{ overviewData.unitPriceGrowth > 0 ? '+' : '' }}{{ overviewData.unitPriceGrowth }}%
          </span>
          <span v-else>-</span>
        </p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">用户总量</p>
        <p class="text-2xl font-semibold text-theme">{{ overviewData.totalUsers || 0 }}</p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">新增用户</p>
        <p class="text-2xl font-semibold text-theme">{{ overviewData.newUsers || 0 }}</p>
        <p class="text-xs text-gray-500 mt-1">
          同比增长
          <span
            v-if="overviewData.newUsersGrowth"
            :class="overviewData.newUsersGrowth > 0 ? 'text-red-500' : 'text-green-500'"
          >
            {{ overviewData.newUsersGrowth > 0 ? '+' : '' }}{{ overviewData.newUsersGrowth }}%
          </span>
          <span v-else>-</span>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'Overview' })

interface Props {
  overviewData: any
}

defineProps<Props>()
</script>

<style lang="scss" scoped>
</style>

