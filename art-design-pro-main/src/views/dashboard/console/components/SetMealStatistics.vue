<template>
  <div class="art-card p-5">
    <div class="flex items-center justify-between mb-5">
      <h2 class="text-xl font-semibold m-0">套餐总览</h2>
      <RouterLink to="/setmeal" class="text-theme text-sm">套餐管理</RouterLink>
    </div>
    <div class="flex items-center gap-4">
      <div class="flex-1 text-center p-4 bg-blue-50 rounded-lg">
        <div class="flex items-center justify-center mb-2">
          <ElIcon class="mr-1 text-green-500"><CircleCheck /></ElIcon>
          <span class="text-sm text-gray-600">已启售</span>
        </div>
        <p class="text-2xl font-semibold text-theme m-0">{{ setMealData.sold || 0 }}</p>
      </div>
      <div class="flex-1 text-center p-4 bg-red-50 rounded-lg">
        <div class="flex items-center justify-center mb-2">
          <ElIcon class="mr-1 text-red-500"><Close /></ElIcon>
          <span class="text-sm text-gray-600">已停售</span>
        </div>
        <p class="text-2xl font-semibold text-theme m-0">{{ setMealData.discontinued || 0 }}</p>
      </div>
      <RouterLink
        to="/setmeal/add"
        class="flex-1 text-center p-4 bg-theme/10 rounded-lg hover:bg-theme/20 transition-colors"
      >
        <ElIcon class="text-3xl text-theme mb-2"><Plus /></ElIcon>
        <p class="text-sm text-theme m-0 font-medium">新增套餐</p>
      </RouterLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import { CircleCheck, Close, Plus } from '@element-plus/icons-vue'

defineOptions({ name: 'SetMealStatistics' })

interface Props {
  setMealData: any
}

defineProps<Props>()
</script>

<style lang="scss" scoped>
</style>

