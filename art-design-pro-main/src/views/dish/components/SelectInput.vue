<template>
  <div class="select-input">
    <ElInput
      v-model="inputValue"
      type="text"
      style="width: 100%"
      placeholder="请选择口味"
      clearable
      readonly
      @focus="selectFlavor(true)"
      @blur="outSelect(false)"
    />
    <div v-if="showDropdown && dishFlavorsData.length" class="flavor-select">
      <span
        v-for="(it, ind) in dishFlavorsData"
        :key="ind"
        class="items"
        @click="checkOption(it, ind)"
      >
        {{ it.name }}
      </span>
      <span v-if="dishFlavorsData.length === 0" class="none">无数据</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

defineOptions({ name: 'SelectInput' })

interface Props {
  dishFlavorsData?: Array<{ name: string; value: string[] }>
  modelValue?: string
  index?: number
}

const props = withDefaults(defineProps<Props>(), {
  dishFlavorsData: () => [],
  modelValue: '',
  index: 0
})

const emit = defineEmits<{
  'update:modelValue': [value: string]
  select: [name: string, index: number, ind: number]
}>()

const showDropdown = ref(false)

const inputValue = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
})

const selectFlavor = (st: boolean) => {
  showDropdown.value = st
}

const outSelect = (st: boolean) => {
  setTimeout(() => {
    showDropdown.value = st
  }, 200)
}

const checkOption = (val: any, ind: number) => {
  emit('select', val.name, props.index, ind)
  inputValue.value = val.name
  showDropdown.value = false
}
</script>

<style scoped lang="scss">
.select-input {
  position: relative;
  width: 100%;
  min-width: 100px;

  .flavor-select {
    position: absolute;
    width: 100%;
    border-radius: 3px;
    border: solid 1px #e4e7ed;
    line-height: 30px;
    text-align: center;
    background: #fff;
    top: 50px;
    z-index: 99;

    .items {
      cursor: pointer;
      display: inline-block;
      width: 100%;
      line-height: 35px;
      border-bottom: solid 1px #f4f4f4;
      color: #666;
      margin: 0 !important;

      &:hover {
        background-color: #fffbf0;
      }

      &:active {
        background-color: #fffbf0;
        color: #ffc200;
      }
    }

    .none {
      font-size: 14px;
    }
  }
}
</style>

