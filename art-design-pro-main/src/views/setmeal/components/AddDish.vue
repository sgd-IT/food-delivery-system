<template>
  <div class="add-dish">
    <div class="left-cont">
      <div v-show="!seachKey.trim()" class="tab-but">
        <span
          v-for="(item, index) in dishType"
          :key="index"
          :class="{ act: index == keyInd }"
          @click="checkTypeHandle(index, item.id)"
        >
          {{ item.name }}
        </span>
      </div>
      <div class="tab-list">
        <div class="table" :class="{ borderNone: !dishList.length }">
          <div v-if="dishList.length == 0" style="padding-left: 10px">
            <ElEmpty description="暂无数据" />
          </div>
          <ElCheckboxGroup v-if="dishList.length > 0" v-model="checkedList" @change="checkedListHandle">
            <div v-for="(item, index) in dishList" :key="item.name + item.id" class="items">
              <ElCheckbox :key="index" :label="item.name">
                <div class="item">
                  <span style="flex: 3; text-align: left">{{ item.dishName }}</span>
                  <span>{{ item.status == 0 ? '停售' : '在售' }}</span>
                  <span>{{ (Number(item.price) * 100) / 100 }}</span>
                </div>
              </ElCheckbox>
            </div>
          </ElCheckboxGroup>
        </div>
      </div>
    </div>
    <div class="rit-cont">
      <div class="tit">已选菜品({{ checkedListAll.length }})</div>
      <div class="items">
        <div v-for="(item, ind) in checkedListAll" :key="ind" class="item">
          <span>{{ item.dishName || item.name }}</span>
          <span class="price">￥ {{ ((Number(item.price) * 100) / 100).toFixed(2) }} </span>
          <span class="del" @click="delCheck(item.name)">
            <ElIcon><Close /></ElIcon>
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { Close } from '@element-plus/icons-vue'
import { getCategoryList, queryDishList } from '@/api/dish'

defineOptions({ name: 'AddDish' })

interface Props {
  checkList?: any[]
  seachKey?: string
}

const props = withDefaults(defineProps<Props>(), {
  checkList: () => [],
  seachKey: ''
})

const emit = defineEmits<{
  checkList: [value: any[]]
}>()

const dishType = ref<any[]>([])
const dishList = ref<any[]>([])
const allDishList = ref<any[]>([])
const keyInd = ref(0)
const checkedList = ref<string[]>([])
const checkedListAll = ref<any[]>([])
const ids = new Set()

// 监听搜索关键词变化
watch(
  () => props.seachKey,
  (value) => {
    if (value.trim()) {
      getDishForName(props.seachKey)
    }
  }
)

/**
 * 初始化
 */
const init = () => {
  getDishType()
  checkedList.value = props.checkList.map((it: any) => it.name)
  checkedListAll.value = [...props.checkList].reverse()
}

/**
 * 获取套餐分类
 */
const getDishType = async () => {
  try {
    const res = await getCategoryList({ type: 1 })
    if (Array.isArray(res) && res.length > 0) {
      dishType.value = res
      getDishList(res[0].id)
    }
  } catch (err: any) {
    ElMessage.error(err.message || '获取分类列表失败')
  }
}

/**
 * 通过分类ID获取菜品列表
 */
const getDishList = async (id: number) => {
  try {
    const res = await queryDishList({ categoryId: id })
    if (Array.isArray(res)) {
      if (res.length === 0) {
        dishList.value = []
        return
      }
      const newArr = res.map((n: any) => ({
        ...n,
        dishId: n.id,
        copies: 1,
        dishName: n.name
      }))
      dishList.value = newArr
      if (!ids.has(id)) {
        allDishList.value = [...allDishList.value, ...newArr]
        ids.add(id)
      }
    }
  } catch (err: any) {
    ElMessage.error(err.message || '获取菜品列表失败')
  }
}

/**
 * 关键词搜索菜品列表
 */
const getDishForName = async (name: string) => {
  try {
    const res = await queryDishList({ name })
    if (Array.isArray(res)) {
      const newArr = res.map((n: any) => ({
        ...n,
        dishId: n.id,
        dishName: n.name
      }))
      dishList.value = newArr
    }
  } catch (err: any) {
    ElMessage.error(err.message || '搜索菜品失败')
  }
}

/**
 * 点击分类
 */
const checkTypeHandle = (ind: number, id: any) => {
  keyInd.value = ind
  getDishList(id)
}

/**
 * 添加菜品
 */
const checkedListHandle = (value: string[]) => {
  checkedListAll.value.reverse()
  const list = allDishList.value.filter((item: any) => {
    return value.some((it: any) => item.name === it)
  })

  const dishListCat = [...checkedListAll.value, ...list]
  const arrData: string[] = []
  checkedListAll.value = dishListCat.filter((item: any) => {
    let allArrDate
    if (arrData.length == 0) {
      arrData.push(item.name)
      allArrDate = item
    } else {
      const st = arrData.some((it) => item.name === it)
      if (!st) {
        arrData.push(item.name)
        allArrDate = item
      }
    }
    return allArrDate
  })

  if (value.length < arrData.length) {
    checkedListAll.value = checkedListAll.value.filter((item: any) => {
      if (value.some((it) => it == item.name)) {
        return item
      }
    })
  }
  emit('checkList', checkedListAll.value)
  checkedListAll.value.reverse()
}

/**
 * 删除已选菜品
 */
const delCheck = (name: string) => {
  const index = checkedList.value.findIndex((it) => it === name)
  const indexAll = checkedListAll.value.findIndex((it: any) => it.name === name)

  if (index !== -1) {
    checkedList.value.splice(index, 1)
  }
  if (indexAll !== -1) {
    checkedListAll.value.splice(indexAll, 1)
  }
  emit('checkList', checkedListAll.value)
}

onMounted(() => {
  init()
})
</script>

<style scoped lang="scss">
.add-dish {
  padding: 0 20px;
  display: flex;
  line-height: 40px;

  .borderNone {
    border: none !important;
  }

  span,
  .tit {
    color: #333;
  }

  .left-cont {
    display: flex;
    border-right: solid 1px #efefef;
    width: 60%;
    padding: 15px;

    .tab-but {
      width: 110px;
      font-weight: bold;
      border-right: solid 2px #f4f4f4;

      span {
        display: block;
        text-align: center;
        cursor: pointer;
        position: relative;
      }

      .act {
        border-color: #ffc200 !important;
        color: #ffc200 !important;
      }

      .act::after {
        content: ' ';
        display: inline-block;
        background-color: #ffc200;
        width: 2px;
        height: 40px;
        position: absolute;
        right: -2px;
      }
    }

    .tab-list {
      flex: 1;
      padding: 15px;
      height: 400px;
      overflow-y: scroll;

      .table {
        border: solid 1px #f4f4f4;
        border-bottom: solid 1px #f4f4f4;

        .items {
          border-bottom: solid 1px #f4f4f4;
          padding: 0 10px;
          display: flex;

          .el-checkbox,
          .el-checkbox__label {
            width: 100%;
          }

          .item {
            display: flex;
            padding-right: 20px;

            span {
              display: inline-block;
              text-align: center;
              flex: 1;
              font-weight: normal;
            }
          }
        }
      }
    }
  }

  .rit-cont {
    width: 40%;

    .tit {
      margin: 0 15px;
      font-weight: bold;
    }

    .items {
      height: 338px;
      padding: 4px 15px;
      overflow-y: scroll;

      .item {
        box-shadow: 0px 1px 4px 3px rgba(0, 0, 0, 0.03);
        display: flex;
        align-items: center;
        text-align: center;
        padding: 0 10px;
        margin-bottom: 20px;
        border-radius: 6px;
        color: #818693;

        span:first-child {
          text-align: left;
          color: #20232a;
          flex: 70%;
        }

        .price {
          display: inline-block;
          flex: 70%;
          text-align: left;
        }

        .del {
          cursor: pointer;
          color: #f56c6c;
        }
      }
    }
  }
}
</style>

