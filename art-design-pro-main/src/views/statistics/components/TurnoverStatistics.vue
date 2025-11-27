<template>
  <div class="art-card p-5">
    <h2 class="text-xl font-semibold mb-5 m-0">营业额统计</h2>
    <div class="char-box">
      <ArtLineChart
        :height="'320px'"
        :data="turnoverData.turnoverList || []"
        :x-axis-data="turnoverData.dateList || []"
        :colors="['#FFD000']"
        :smooth="false"
        :show-area-color="false"
        :line-width="2.5"
      />
      <ul class="flex justify-center gap-4 mt-4">
        <li class="text-sm text-gray-600">营业额(元)</li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import ArtLineChart from '@/components/core/charts/art-line-chart/index.vue'

defineOptions({ name: 'TurnoverStatistics' })

interface Props {
  turnoverData: {
    dateList: string[]
    turnoverList: string[]
  }
}

defineProps<Props>()
</script>

<style lang="scss" scoped>
</style>

