<!-- ArtForm 包装组件 - 支持两种使用方式：
  1. 配置式：使用 items 属性（原始 ArtForm）
  2. 直接式：直接使用 ArtFormItem 作为子元素（类似 ElForm）
-->
<template>
  <!-- 如果有 items 属性，使用原始的 ArtForm -->
  <ArtForm v-if="items && items.length > 0" v-bind="$attrs" :items="items" />
  <!-- 如果没有 items 属性，使用 ElForm 包装 -->
  <ElForm v-else ref="formRef" v-bind="$attrs">
    <slot />
  </ElForm>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { ElForm, type FormInstance } from 'element-plus'
import ArtForm from '../art-form/index.vue'
import type { FormItem } from '../art-form/index.vue'

defineOptions({
  name: 'ArtFormWrapper'
})

interface Props {
  items?: FormItem[]
  model?: any
  rules?: any
  [key: string]: any
}

const props = withDefaults(defineProps<Props>(), {
  items: undefined
})

const formRef = ref<FormInstance>()

// 暴露 ElForm 的方法
defineExpose({
  validate: () => formRef.value?.validate(),
  validateField: (props: string | string[]) => formRef.value?.validateField(props),
  resetFields: () => formRef.value?.resetFields(),
  clearValidate: (props?: string | string[]) => formRef.value?.clearValidate(props),
  scrollToField: (prop: string) => formRef.value?.scrollToField(prop)
})
</script>

