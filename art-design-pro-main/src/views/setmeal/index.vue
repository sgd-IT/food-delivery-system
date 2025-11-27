<template>
  <div class="setmeal-page art-full-height">
    <!-- 搜索栏 -->
    <ArtSearchBar
      v-model="searchForm"
      :items="searchItems"
      :is-expand="false"
      :show-expand="false"
      :show-reset-button="true"
      :show-search-button="true"
      @search="handleSearch"
      @reset="handleReset"
    >
      <template #right>
        <ElSpace wrap>
          <ElButton type="danger" :disabled="selectedRows.length === 0" @click="deleteHandle('批量')" v-ripple>
            批量删除
          </ElButton>
          <ElButton type="primary" @click="addSetMeal('add')" v-ripple>
            + 新建套餐
          </ElButton>
        </ElSpace>
      </template>
    </ArtSearchBar>

    <ElCard class="art-table-card" shadow="never">
      <!-- 表格头部 -->
      <ArtTableHeader v-model:columns="columnChecks" :loading="loading" @refresh="refreshData" />

      <!-- 表格 -->
      <ArtTable
        :loading="loading"
        :data="data"
        :columns="columns"
        :pagination="pagination"
        @selection-change="handleSelectionChange"
        @pagination:size-change="handleSizeChange"
        @pagination:current-change="handleCurrentChange"
      />

      <!-- 空状态 -->
      <ElEmpty v-if="!loading && data.length === 0" :description="isSearch ? 'Sorry，木有找到您搜索的内容哦~' : '这里空空如也~'" />
    </ElCard>

    <!-- 套餐弹窗 -->
    <ElDialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="800px"
      :before-close="handleClose"
      destroy-on-close
    >
      <ArtForm ref="formRef" :model="formData" :rules="rules" label-width="120px">
        <ArtFormItem label="套餐名称" prop="name">
          <ElInput v-model="formData.name" placeholder="请填写套餐名称" maxlength="14" />
        </ArtFormItem>

        <ArtFormItem label="套餐分类" prop="categoryId">
          <ElSelect v-model="formData.categoryId" placeholder="请选择套餐分类" style="width: 100%">
            <ElOption v-for="item in setMealList" :key="item.id" :label="item.name" :value="item.id" />
          </ElSelect>
        </ArtFormItem>

        <ArtFormItem label="套餐价格" prop="price">
          <ElInput v-model="formData.price" placeholder="请设置套餐价格" />
        </ArtFormItem>

        <ArtFormItem label="套餐菜品" required>
          <div class="add-dish-wrapper">
            <span v-if="dishTable.length == 0" class="add-but" @click="openAddDish('new')"> + 添加菜品</span>
            <div v-if="dishTable.length != 0" class="content">
              <div class="add-but" style="margin-bottom: 20px" @click="openAddDish('change')">+ 添加菜品</div>
              <div class="table">
                <ElTable :data="dishTable" style="width: 100%">
                  <ElTableColumn prop="name" label="名称" width="180" align="center" />
                  <ElTableColumn prop="price" label="原价" width="180" align="center">
                    <template #default="{ row }">
                      {{ ((Number(row.price) * 100) / 100).toFixed(2) }}
                    </template>
                  </ElTableColumn>
                  <ElTableColumn prop="copies" label="份数" align="center">
                    <template #default="{ row, $index }">
                      <ElInputNumber
                        v-model="row.copies"
                        size="small"
                        :min="1"
                        :max="99"
                        @change="() => updateDishTable($index)"
                      />
                    </template>
                  </ElTableColumn>
                  <ElTableColumn prop="operation" label="操作" width="180px" align="center">
                    <template #default="{ $index }">
                      <ElButton type="text" size="small" class="del-but" @click="delDishHandle($index)">删除</ElButton>
                    </template>
                  </ElTableColumn>
                </ElTable>
              </div>
            </div>
          </div>
        </ArtFormItem>

        <ArtFormItem label="套餐图片" required prop="image">
          <div class="upload-wrapper">
            <ElUpload
              :action="uploadImageUrl"
              :headers="uploadHeaders"
              :show-file-list="false"
              :on-success="onImageSuccess"
              :on-error="onImageError"
              :before-upload="beforeUpload"
            >
              <div v-if="!imageUrl" class="upload-placeholder">
                <ElIcon class="upload-icon"><Plus /></ElIcon>
                <div class="upload-text">点击上传图片</div>
              </div>
              <img v-else :src="imageUrl" class="upload-image" />
            </ElUpload>
            <div class="upload-tips">
              图片大小不超过2M<br />仅能上传 PNG JPEG JPG类型图片<br />建议上传200*200或300*300尺寸的图片
            </div>
          </div>
        </ArtFormItem>

        <ArtFormItem label="套餐描述">
          <ElInput
            v-model="formData.description"
            type="textarea"
            :rows="3"
            maxlength="200"
            placeholder="套餐描述，最长200字"
          />
        </ArtFormItem>
      </ArtForm>
      <template #footer>
        <ElButton @click="handleClose">取 消</ElButton>
        <ElButton type="primary" @click="submitForm">确 定</ElButton>
        <ElButton v-if="dialogType === 'add'" type="primary" @click="submitForm('continue')">
          保存并继续添加
        </ElButton>
      </template>
    </ElDialog>

    <!-- 添加菜品弹窗 -->
    <ElDialog v-model="addDishDialogVisible" title="添加菜品" width="60%" :before-close="handleAddDishClose">
      <div class="search-wrapper">
        <ElInput
          v-model="searchValue"
          class="search-dish"
          placeholder="请输入菜品名称进行搜索"
          clearable
          @keyup.enter="seachHandle"
        >
          <template #prefix>
            <ElIcon class="cursor-pointer" @click="seachHandle"><Search /></ElIcon>
          </template>
        </ElInput>
      </div>
      <AddDish
        v-if="addDishDialogVisible"
        ref="adddishRef"
        :check-list="checkList"
        :seach-key="seachKey"
        @check-list="getCheckList"
      />
      <template #footer>
        <ElButton @click="handleAddDishClose">取 消</ElButton>
        <ElButton type="primary" @click="addTableList">添 加</ElButton>
      </template>
    </ElDialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, h, onMounted, computed, nextTick } from 'vue'
import { useTable } from '@/hooks/core/useTable'
import {
  getSetmealPage,
  deleteSetmeal,
  setmealStatusByStatus,
  dishCategoryList,
  querySetmealById,
  addSetmeal,
  editSetmeal
} from '@/api/setMeal'
import { getCategoryList } from '@/api/dish'
import { ElMessageBox, ElMessage, ElTag, ElButton as ElBtn, ElImage, ElDialog, ElIcon, ElTable, ElTableColumn, ElInputNumber } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { useUserStore } from '@/store/modules/user'
import ArtButtonTable from '@/components/core/forms/art-button-table/index.vue'
import AddDish from './components/AddDish.vue'

defineOptions({ name: 'Setmeal' })

const userStore = useUserStore()

// 售卖状态选项
const saleStatusOptions = [
  { value: 0, label: '停售' },
  { value: 1, label: '启售' }
]

// 套餐分类列表（用于搜索）
const dishCategoryListOptions = ref<Array<{ value: string; label: string }>>([])

// 套餐分类列表（用于表单）
const setMealList = ref<Array<{ id: string; name: string }>>([])

// 弹窗相关
const dialogType = ref<'add' | 'edit'>('add')
const dialogVisible = ref(false)
const dialogTitle = ref('添加套餐')
const formRef = ref()

// 上传配置
const uploadImageUrl = `${import.meta.env.VITE_API_URL}/admin/common/upload`
const uploadHeaders = computed(() => ({
  token: userStore.accessToken
}))

// 图片URL
const imageUrl = ref('')

// 添加菜品弹窗
const addDishDialogVisible = ref(false)
const adddishRef = ref()
const searchValue = ref('')
const seachKey = ref('')

// 菜品表格数据
const dishTable = ref<any[]>([])
const checkList = ref<any[]>([])

// 表单数据
const formData = reactive({
  name: '',
  id: '',
  categoryId: '',
  price: '',
  code: '',
  image: '',
  description: '',
  status: true
})

// 表单验证规则
const rules = {
  name: {
    required: true,
    validator: (rule: any, value: string, callback: Function) => {
      if (!value) {
        callback(new Error('请输入套餐名称'))
      } else {
        const reg = /^([A-Za-z0-9\u4e00-\u9fa5]){2,20}$/
        if (!reg.test(value)) {
          callback(new Error('套餐名称输入不符，请输入2-20个字符'))
        } else {
          callback()
        }
      }
    },
    trigger: 'blur'
  },
  categoryId: {
    required: true,
    message: '请选择套餐分类',
    trigger: 'change'
  },
  image: {
    required: true,
    message: '套餐图片不能为空'
  },
  price: {
    required: true,
    validator: (rule: any, value: string, callback: Function) => {
      const reg = /^([1-9]\d{0,5}|0)(\.\d{1,2})?$/
      if (!reg.test(value) || Number(value) <= 0) {
        callback(new Error('套餐价格格式有误，请输入大于零且最多保留两位小数的金额'))
      } else {
        callback()
      }
    },
    trigger: 'blur'
  }
}

// 搜索状态
const isSearch = ref(false)

// 选中的行
const selectedRows = ref<any[]>([])

// 搜索表单
const searchForm = ref({
  name: undefined,
  categoryId: undefined,
  status: undefined
})

// 搜索项配置
const searchItems = computed(() => [
  {
    prop: 'name',
    label: '套餐名称',
    component: 'ElInput',
    componentProps: {
      placeholder: '请填写套餐名称',
      clearable: true
    }
  },
  {
    prop: 'categoryId',
    label: '套餐分类',
    component: 'ElSelect',
    componentProps: {
      placeholder: '请选择',
      clearable: true,
      options: dishCategoryListOptions.value
    }
  },
  {
    prop: 'status',
    label: '售卖状态',
    component: 'ElSelect',
    componentProps: {
      placeholder: '请选择',
      clearable: true,
      options: saleStatusOptions
    }
  }
])

// 表格配置
const {
  columns,
  columnChecks,
  data,
  loading,
  pagination,
  getData,
  searchParams,
  resetSearchParams,
  handleSizeChange,
  handleCurrentChange,
  refreshData
} = useTable({
  core: {
    apiFn: getSetmealPage,
    apiParams: {
      page: 1,
      pageSize: 10,
      ...searchForm.value
    },
    paginationKey: {
      current: 'page',
      size: 'pageSize'
    },
    columnsFactory: () => [
      { type: 'selection', width: 55 },
      { type: 'index', width: 60, label: '序号' },
      { prop: 'name', label: '套餐名称' },
      {
        prop: 'image',
        label: '图片',
        width: 120,
        formatter: (row: any) => {
          return h(ElImage, {
            style: 'width: 80px; height: 40px; border: none; cursor: pointer',
            src: row.image,
            previewSrcList: [row.image],
            previewTeleported: true,
            fit: 'cover'
          })
        }
      },
      { prop: 'categoryName', label: '套餐分类' },
      {
        prop: 'price',
        label: '套餐价',
        formatter: (row: any) => {
          return `￥${((row.price * 100) / 100).toFixed(2)}`
        }
      },
      {
        prop: 'status',
        label: '售卖状态',
        formatter: (row: any) => {
          const status = String(row.status) === '0' ? '停售' : '启售'
          const type = String(row.status) === '0' ? 'danger' : 'success'
          return h(ElTag, { type }, () => status)
        }
      },
      { prop: 'updateTime', label: '最后操作时间' },
      {
        prop: 'operation',
        label: '操作',
        width: 250,
        fixed: 'right',
        formatter: (row: any) =>
          h('div', { class: 'flex gap-2' }, [
            h(ArtButtonTable, {
              type: 'edit',
              onClick: () => addSetMeal(row)
            }),
            h(ArtButtonTable, {
              type: 'delete',
              onClick: () => deleteHandle('单删', row.id)
            }),
            h(
              ElBtn,
              {
                type: 'primary',
                link: true,
                onClick: () => statusHandle(row)
              },
              () => (row.status == '0' ? '启售' : '停售')
            )
          ])
      }
    ]
  }
})

/**
 * 获取套餐分类列表
 */
const getDishCategoryList = async () => {
  try {
    const res = await dishCategoryList({ type: 2 })
    if (Array.isArray(res)) {
      dishCategoryListOptions.value = res.map((item: any) => ({
        value: item.id,
        label: item.name
      }))
      setMealList.value = res.map((item: any) => ({
        id: item.id,
        name: item.name
      }))
    }
  } catch (err) {
    console.error('获取套餐分类列表失败:', err)
  }
}

/**
 * 显示弹窗
 */
const showDialog = async (type: 'add' | 'edit', id?: string) => {
  dialogType.value = type
  if (type === 'add') {
    dialogTitle.value = '添加套餐'
    // 重置表单
    Object.assign(formData, {
      name: '',
      id: '',
      categoryId: '',
      price: '',
      code: '',
      image: '',
      description: '',
      status: true
    })
    dishTable.value = []
    imageUrl.value = ''
  } else {
    dialogTitle.value = '修改套餐'
    if (id) {
      await initEditData(id)
    }
  }
  nextTick(() => {
    dialogVisible.value = true
  })
}

/**
 * 初始化编辑数据
 */
const initEditData = async (id: string) => {
  try {
    const res = await querySetmealById(id)
    if (res) {
      Object.assign(formData, {
        name: res.name || '',
        id: res.id || '',
        categoryId: res.categoryId || '',
        price: String(res.price || ''),
        code: res.code || '',
        image: res.image || '',
        description: res.description || '',
        status: res.status == '1'
      })

      imageUrl.value = res.image || ''
      checkList.value = res.setmealDishes || []
      dishTable.value = [...(res.setmealDishes || [])].reverse()
    }
  } catch (err: any) {
    ElMessage.error(err.message || '获取套餐详情失败')
  }
}

/**
 * 关闭弹窗
 */
const handleClose = () => {
  dialogVisible.value = false
  formRef.value?.resetFields()
}

/**
 * 搜索处理
 */
const seachHandle = () => {
  seachKey.value = searchValue.value
}

/**
 * 打开添加菜品弹窗
 */
const openAddDish = (st: string) => {
  seachKey.value = ''
  searchValue.value = ''
  addDishDialogVisible.value = true
}

/**
 * 关闭添加菜品弹窗
 */
const handleAddDishClose = () => {
  addDishDialogVisible.value = false
  checkList.value = JSON.parse(JSON.stringify(dishTable.value))
}

/**
 * 获取选中的菜品列表
 */
const getCheckList = (value: any[]) => {
  checkList.value = [...value].reverse()
}

/**
 * 保存添加的菜品列表
 */
const addTableList = () => {
  dishTable.value = JSON.parse(JSON.stringify(checkList.value))
  dishTable.value.forEach((n: any) => {
    if (!n.copies) {
      n.copies = 1
    }
  })
  addDishDialogVisible.value = false
}

/**
 * 更新菜品表格
 */
const updateDishTable = (index: number) => {
  if (dishTable.value[index].copies < 1) {
    dishTable.value[index].copies = 1
  } else if (dishTable.value[index].copies > 99) {
    dishTable.value[index].copies = 99
  }
}

/**
 * 删除套餐菜品
 */
const delDishHandle = (index: number) => {
  dishTable.value.splice(index, 1)
  checkList.value = dishTable.value
}

/**
 * 图片上传成功
 */
const onImageSuccess = (response: any) => {
  if (response && response.code === 1 && response.data) {
    imageUrl.value = response.data
    formData.image = response.data
    ElMessage.success('图片上传成功')
  } else {
    ElMessage.error(response?.msg || '图片上传失败：响应格式错误')
  }
}

/**
 * 图片上传失败
 */
const onImageError = () => {
  ElMessage.error('图片上传失败')
}

/**
 * 上传前校验
 */
const beforeUpload = (file: File): boolean => {
  const isImage = file.type.startsWith('image/')
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isImage) {
    ElMessage.error('只能上传图片文件!')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过 2MB!')
    return false
  }
  return true
}

/**
 * 提交表单
 */
const submitForm = async (mode?: string) => {
  if (!formRef.value) return

  try {
    await formRef.value.validate()
    if (dishTable.value.length === 0) {
      ElMessage.error('套餐下菜品不能为空')
      return
    }
    if (!formData.image) {
      ElMessage.error('套餐图片不能为空')
      return
    }

    const params: any = {
      ...formData,
      status: dialogType.value === 'add' ? 0 : formData.status ? 1 : 0,
      categoryId: formData.categoryId,
      setmealDishes: dishTable.value.map((obj: any) => ({
        copies: obj.copies,
        dishId: obj.dishId,
        name: obj.name,
        price: obj.price
      }))
    }

    if (dialogType.value === 'add') {
      delete params.id
      await addSetmeal(params)
      ElMessage.success('套餐添加成功！')
      if (mode === 'continue') {
        // 重置表单
        Object.assign(formData, {
          name: '',
          categoryId: '',
          price: '',
          code: '',
          image: '',
          description: '',
          status: true
        })
        dishTable.value = []
        imageUrl.value = ''
        formRef.value?.resetFields()
      } else {
        dialogVisible.value = false
        refreshData()
      }
    } else {
      delete params.updateTime
      await editSetmeal(params)
      ElMessage.success('套餐修改成功！')
      dialogVisible.value = false
      refreshData()
    }
  } catch (err: any) {
    console.error('提交失败:', err)
  }
}

/**
 * 搜索处理
 */
const handleSearch = (params: Record<string, any>) => {
  isSearch.value = true
  Object.assign(searchParams, params)
  getData()
}

/**
 * 重置搜索
 */
const handleReset = () => {
  isSearch.value = false
  resetSearchParams()
}

/**
 * 添加/编辑套餐
 */
const addSetMeal = (row: any) => {
  if (row === 'add') {
    showDialog('add')
  } else {
    showDialog('edit', row.id)
  }
}

/**
 * 删除处理
 */
const deleteHandle = (type: string, id?: any) => {
  if (type === '批量' && !id) {
    if (selectedRows.value.length === 0) {
      ElMessage.error('请选择删除对象')
      return
    }
  }

  ElMessageBox.confirm('确认删除该套餐, 是否继续?', '确定删除', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      const ids = type === '批量' ? selectedRows.value.map((row) => row.id).join(',') : id
      deleteSetmeal(ids)
        .then(() => {
          ElMessage.success('删除成功！')
          refreshData()
          selectedRows.value = []
        })
        .catch((err: any) => {
          ElMessage.error('请求出错了：' + err.message)
        })
    })
    .catch(() => {})
}

/**
 * 状态更改
 */
const statusHandle = (row: any) => {
  const params: any = {
    ids: row.id,
    status: row.status ? '0' : '1'
  }

  ElMessageBox.confirm('确认更改该套餐状态?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      setmealStatusByStatus(params)
        .then(() => {
          ElMessage.success('套餐状态已经更改成功！')
          refreshData()
        })
        .catch((err: any) => {
          ElMessage.error('请求出错了：' + err.message)
        })
    })
    .catch(() => {})
}

/**
 * 处理表格行选择变化
 */
const handleSelectionChange = (selection: any[]): void => {
  selectedRows.value = selection
}

// 初始化
onMounted(() => {
  getDishCategoryList()
})
</script>

<style scoped lang="scss">
.setmeal-page {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.upload-wrapper {
  .upload-placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 200px;
    height: 160px;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    transition: border-color 0.3s;

    &:hover {
      border-color: #409eff;
    }

    .upload-icon {
      font-size: 28px;
      color: #8c939d;
    }

    .upload-text {
      margin-top: 8px;
      font-size: 14px;
      color: #8c939d;
    }
  }

  .upload-image {
    width: 200px;
    height: 160px;
    object-fit: cover;
    border-radius: 6px;
  }

  .upload-tips {
    margin-top: 8px;
    font-size: 12px;
    color: #909399;
    line-height: 1.5;
  }
}

.add-dish-wrapper {
  width: 100%;

  .add-but {
    background: #ffc200;
    display: inline-block;
    padding: 0 20px;
    border-radius: 4px;
    line-height: 40px;
    cursor: pointer;
    color: #333333;
    font-weight: 500;
  }

  .content {
    background: #fafafb;
    padding: 20px;
    border: solid 1px #d8dde3;
    border-radius: 3px;

    .table {
      border: solid 1px #ebeef5;
      border-radius: 3px;
    }
  }
}

.search-wrapper {
  margin-bottom: 20px;

  .search-dish {
    width: 293px;
  }
}

.del-but {
  color: #f19c59;
}
</style>

