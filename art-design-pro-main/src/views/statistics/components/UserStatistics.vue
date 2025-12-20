<template>
  <div class="art-card p-5">
    <h2 class="text-xl font-semibold mb-5 m-0">用户统计</h2>
    <div class="char-box">
      <ArtLineChart
        :height="'320px'"
        :data="[
          { name: '用户总量', data: userData.totalUserList || [] },
          { name: '新增用户', data: userData.newUserList || [] }
        ]"
        :x-axis-data="userData.dateList || []"
        :colors="['#FFD000', '#FD7F7F']"
        :smooth="false"
        :show-area-color="false"
        :line-width="2.5"
        :show-legend="true"
      />
      <ul class="flex justify-center gap-4 mt-4">
        <li class="flex items-center gap-2 text-sm">
          <span class="w-3 h-3 bg-[#FFD000] rounded"></span>
          用户总量（个）
        </li>
        <li class="flex items-center gap-2 text-sm">
          <span class="w-3 h-3 bg-[#FD7F7F] rounded"></span>
          新增用户（个）
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import ArtLineChart from '@/components/core/charts/art-line-chart/index.vue'

defineOptions({ name: 'UserStatistics' })

interface Props {
  userData: {
    dateList: string[]
    totalUserList: string[]
    newUserList: string[]
  }
}

defineProps<Props>()
</script>

<style lang="scss" scoped>
</style>









