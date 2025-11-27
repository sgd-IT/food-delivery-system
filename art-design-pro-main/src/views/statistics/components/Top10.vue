<template>
  <div class="art-card p-5">
    <h2 class="text-xl font-semibold mb-5 m-0">销量排名TOP10</h2>
    <div class="char-box">
      <ArtHBarChart
        :height="'380px'"
        :data="top10Data.numberList || []"
        :x-axis-data="top10Data.nameList || []"
        :colors="['#FFD000']"
        :bar-width="'20%'"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import ArtHBarChart from '@/components/core/charts/art-h-bar-chart/index.vue'

defineOptions({ name: 'Top10' })

interface Props {
  top10Data: {
    nameList: string[]
    numberList: string[]
  }
}

defineProps<Props>()
</script>

<style lang="scss" scoped>
</style>

