<template>
  <div class="tab-change">
    <div
      v-for="item in changedOrderList"
      :key="item.value"
      class="tab-item"
      :class="{ active: item.value === activeIndex }"
      @click="tabChange(item.value)"
    >
      <ElBadge
        :class="{ 'special-item': item.num < 10 }"
        class="item"
        :value="item.num > 99 ? '99+' : item.num"
        :hidden="!([2, 3, 4].includes(item.value) && item.num)"
      >
        {{ item.label }}
      </ElBadge>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { ElBadge } from 'element-plus'

defineOptions({ name: 'TabChange' })

interface Props {
  orderStatics?: {
    toBeConfirmed?: number
    confirmed?: number
    deliveryInProgress?: number
  }
  defaultActivity?: number
}

const props = withDefaults(defineProps<Props>(), {
  orderStatics: () => ({}),
  defaultActivity: 0
})

const emit = defineEmits<{
  tabChange: [value: number]
}>()

const activeIndex = ref(props.defaultActivity || 0)

watch(
  () => props.defaultActivity,
  (val) => {
    activeIndex.value = Number(val)
  }
)

const changedOrderList = computed(() => {
  return [
    {
      label: '全部订单',
      value: 0
    },
    {
      label: '待接单',
      value: 2,
      num: props.orderStatics.toBeConfirmed
    },
    {
      label: '待派送',
      value: 3,
      num: props.orderStatics.confirmed
    },
    {
      label: '派送中',
      value: 4,
      num: props.orderStatics.deliveryInProgress
    },
    {
      label: '已完成',
      value: 5
    },
    {
      label: '已取消',
      value: 6
    }
  ]
})

const tabChange = (value: number) => {
  activeIndex.value = value
  emit('tabChange', value)
}
</script>

<style scoped lang="scss">
.tab-change {
  display: flex;
  border-radius: 4px;
  margin-bottom: 20px;

  .tab-item {
    width: 120px;
    height: 40px;
    text-align: center;
    line-height: 40px;
    color: #333;
    border: 1px solid #e5e4e4;
    background-color: white;
    border-left: none;
    cursor: pointer;

    .special-item {
      :deep(.el-badge__content) {
        width: 20px;
        padding: 0 5px;
      }
    }

    .item {
      :deep(.el-badge__content) {
        background-color: #fd3333 !important;
        line-height: 18px;
        height: auto;
        min-width: 18px;
        min-height: 18px;
      }
      :deep(.el-badge__content.is-fixed) {
        top: 14px;
        right: 2px;
      }
    }

    &:hover {
      background-color: #f0f9ff;
    }
  }

  .active {
    background-color: #0091ff;
    color: white;
    font-weight: bold;
    border-color: #0091ff;
  }

  .tab-item:first-child {
    border-left: 1px solid #e5e4e4;
  }
}
</style>

