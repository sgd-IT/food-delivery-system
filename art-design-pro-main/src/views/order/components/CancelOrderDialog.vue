<template>
  <ElDialog
    v-model="dialogVisible"
    :title="title + '原因'"
    width="42%"
    :before-close="handleClose"
    class="cancelDialog"
  >
    <ArtForm label-width="90px">
      <ArtFormItem :label="title + '原因：'">
        <ElSelect v-model="cancelReason" :placeholder="'请选择' + title + '原因'">
          <ElOption
            v-for="(item, index) in reasonList"
            :key="index"
            :label="item.label"
            :value="item.label"
          />
        </ElSelect>
      </ArtFormItem>
      <ArtFormItem v-if="cancelReason === '自定义原因'" label="原因：">
        <ElInput
          v-model.trim="remark"
          type="textarea"
          :placeholder="'请填写您' + title + '的原因（限20字内）'"
          maxlength="20"
        />
      </ArtFormItem>
    </ArtForm>
    <template #footer>
      <ElButton @click="handleClose">取 消</ElButton>
      <ElButton type="primary" @click="handleConfirm">确 定</ElButton>
    </template>
  </ElDialog>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { ElDialog, ElSelect, ElOption, ElInput, ElButton, ElMessage } from 'element-plus'

defineOptions({ name: 'CancelOrderDialog' })

interface Props {
  visible: boolean
  title?: string
  orderId?: string
}

const props = withDefaults(defineProps<Props>(), {
  visible: false,
  title: '取消',
  orderId: ''
})

const emit = defineEmits<{
  'update:visible': [value: boolean]
  confirm: [reason: string, isCancel: boolean]
}>()

const dialogVisible = computed({
  get: () => props.visible,
  set: (val) => emit('update:visible', val)
})

const cancelReason = ref('')
const remark = ref('')

const cancelOrderReasonList = [
  { value: 1, label: '订单量较多，暂时无法接单' },
  { value: 2, label: '菜品已销售完，暂时无法接单' },
  { value: 3, label: '骑手不足无法配送' },
  { value: 4, label: '客户电话取消' },
  { value: 0, label: '自定义原因' }
]

const rejectOrderReasonList = [
  { value: 1, label: '订单量较多，暂时无法接单' },
  { value: 2, label: '菜品已销售完，暂时无法接单' },
  { value: 3, label: '餐厅已打烊，暂时无法接单' },
  { value: 0, label: '自定义原因' }
]

const reasonList = computed(() => {
  return props.title === '取消' ? cancelOrderReasonList : rejectOrderReasonList
})

const handleClose = () => {
  dialogVisible.value = false
  cancelReason.value = ''
  remark.value = ''
}

const handleConfirm = () => {
  if (!cancelReason.value) {
    ElMessage.error(`请选择${props.title}原因`)
    return
  }
  if (cancelReason.value === '自定义原因' && !remark.value) {
    ElMessage.error(`请输入${props.title}原因`)
    return
  }

  const reason = cancelReason.value === '自定义原因' ? remark.value : cancelReason.value
  emit('confirm', reason, props.title === '取消')
  handleClose()
}
</script>

<style scoped lang="scss">
.cancelDialog {
  :deep(.el-select),
  :deep(.el-textarea) {
    width: 293px;
  }

  :deep(.el-textarea textarea) {
    height: 114px;
  }
}
</style>

