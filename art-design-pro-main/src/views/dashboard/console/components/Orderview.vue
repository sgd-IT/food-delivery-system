<template>
  <div class="art-card p-5 mb-5">
    <div class="flex items-center justify-between mb-5">
      <h2 class="text-xl font-semibold m-0">
        订单管理<i class="ml-2 text-sm text-gray-500">{{ days[1] }}</i>
      </h2>
      <RouterLink to="/order" class="text-theme text-sm">订单明细</RouterLink>
    </div>
    <div class="grid grid-cols-5 gap-4">
      <div class="text-center">
        <div class="flex items-center justify-center mb-2">
          <ElIcon class="mr-1 text-blue-500"><Clock /></ElIcon>
          <span class="text-sm text-gray-600">待接单</span>
        </div>
        <RouterLink to="/order?status=2" class="text-2xl font-semibold text-theme block">
          {{ orderviewData.waitingOrders || 0 }}
        </RouterLink>
      </div>
      <div class="text-center">
        <div class="flex items-center justify-center mb-2">
          <ArtSvgIcon icon="ri:truck-line" class="mr-1 text-orange-500 text-lg" />
          <span class="text-sm text-gray-600">待派送</span>
        </div>
        <RouterLink to="/order?status=3" class="text-2xl font-semibold text-theme block">
          {{ orderviewData.deliveredOrders || 0 }}
        </RouterLink>
      </div>
      <div class="text-center">
        <div class="flex items-center justify-center mb-2">
          <ElIcon class="mr-1 text-green-500"><CircleCheck /></ElIcon>
          <span class="text-sm text-gray-600">已完成</span>
        </div>
        <RouterLink to="/order?status=5" class="text-2xl font-semibold text-theme block">
          {{ orderviewData.completedOrders || 0 }}
        </RouterLink>
      </div>
      <div class="text-center">
        <div class="flex items-center justify-center mb-2">
          <ElIcon class="mr-1 text-red-500"><Close /></ElIcon>
          <span class="text-sm text-gray-600">已取消</span>
        </div>
        <RouterLink to="/order?status=6" class="text-2xl font-semibold text-theme block">
          {{ orderviewData.cancelledOrders || 0 }}
        </RouterLink>
      </div>
      <div class="text-center">
        <div class="flex items-center justify-center mb-2">
          <ElIcon class="mr-1 text-gray-500"><List /></ElIcon>
          <span class="text-sm text-gray-600">全部订单</span>
        </div>
        <RouterLink to="/order" class="text-2xl font-semibold text-theme block">
          {{ orderviewData.allOrders || 0 }}
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Clock, CircleCheck, Close, List } from '@element-plus/icons-vue'
import ArtSvgIcon from '@/components/core/base/art-svg-icon/index.vue'
import { getday } from '@/utils/date'

defineOptions({ name: 'Orderview' })

interface Props {
  orderviewData: any
}

const props = defineProps<Props>()

const days = computed(() => getday())
</script>

<style lang="scss" scoped>
</style>

