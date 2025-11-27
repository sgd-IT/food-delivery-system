<template>
  <div class="art-card p-5 mb-5">
    <div class="flex items-center justify-between mb-5">
      <h2 class="text-xl font-semibold m-0">
        今日数据<i class="ml-2 text-sm text-gray-500">{{ days[1] }}</i>
      </h2>
      <RouterLink to="/statistics" class="text-theme text-sm">详细数据</RouterLink>
    </div>
    <div class="grid grid-cols-5 gap-4">
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">营业额</p>
        <p class="text-2xl font-semibold text-theme">¥ {{ overviewData.turnover || 0 }}</p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">有效订单</p>
        <p class="text-2xl font-semibold text-theme">{{ overviewData.validOrderCount || 0 }}</p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">订单完成率</p>
        <p class="text-2xl font-semibold text-theme">
          {{ ((overviewData.orderCompletionRate || 0) * 100).toFixed(0) }}%
        </p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">平均客单价</p>
        <p class="text-2xl font-semibold text-theme">¥ {{ overviewData.unitPrice || 0 }}</p>
      </div>
      <div class="text-center">
        <p class="text-sm text-gray-600 mb-2">新增用户</p>
        <p class="text-2xl font-semibold text-theme">{{ overviewData.newUsers || 0 }}</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { getday } from '@/utils/date'

defineOptions({ name: 'Overview' })

interface Props {
  overviewData: any
}

const props = defineProps<Props>()

const days = computed(() => getday())
</script>

<style lang="scss" scoped>
</style>

