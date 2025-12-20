<template>
  <div class="art-card p-5 mb-5">
    <div class="flex items-center justify-between">
      <div class="flex items-center gap-4">
        <div class="month">
          <ul class="flex gap-2">
            <li
              v-for="(item, index) in tabsParam"
              :key="index"
              :class="[
                'px-4 py-2 rounded cursor-pointer transition-colors',
                nowIndex === index
                  ? 'bg-theme text-white'
                  : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              ]"
              @click="toggleTabs(index)"
            >
              {{ item }}
            </li>
          </ul>
        </div>
        <div class="get-time">
          <p class="text-sm text-gray-600 m-0">
            已选时间：{{ tateData[0] }} 至 {{ tateData[tateData.length - 1] }}
          </p>
        </div>
      </div>
      <ElButton
        type="primary"
        :icon="Download"
        @click="handleExport"
      >
        数据导出
      </ElButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import { ElMessageBox } from 'element-plus'
import { Download } from '@element-plus/icons-vue'
import { exportInfor } from '@/api/index'
import { saveAs } from 'file-saver'

defineOptions({ name: 'TitleIndex' })

interface Props {
  flag: number
  tateData: string[]
}

const props = defineProps<Props>()

const emit = defineEmits<{
  'send-title-ind': [value: number]
}>()

const nowIndex = ref(2 - 1)
const tabsParam = ['昨日', '近7日', '近30日', '本周', '本月']

watch(
  () => props.flag,
  (val) => {
    nowIndex.value = val - 1
  }
)

// tab切换
const toggleTabs = (index: number) => {
  nowIndex.value = index
  emit('send-title-ind', index + 1)
}

// 数据导出
const handleExport = async () => {
  try {
    await ElMessageBox.confirm('是否确认导出最近30天运营数据?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    const blob = await exportInfor()
    saveAs(blob, '运营数据统计报表.xlsx')
  } catch (error) {
    // 用户取消
  }
}
</script>

<style lang="scss" scoped>
</style>









