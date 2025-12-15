<!-- ArtFormItem 组件 - ElFormItem 的别名 -->
<template>
  <ElFormItem v-bind="$attrs">
    <template v-for="(_, name) in $slots" #[name]="slotData">
      <slot :name="name" v-bind="slotData" />
    </template>
  </ElFormItem>
</template>

<script setup lang="ts">
import { ElFormItem } from 'element-plus'

defineOptions({
  name: 'ArtFormItem'
})
</script>

