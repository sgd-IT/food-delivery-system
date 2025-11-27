<template>
  <div class="dish-page art-full-height">
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
          <ElButton type="danger" :disabled="selectedRows.length === 0" @click="deleteHandle('批量', null)" v-ripple>
            批量删除
          </ElButton>
          <ElButton type="primary" @click="addDishtype('add')" v-ripple>
            + 新建菜品
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

    <!-- 菜品弹窗 -->
    <ElDialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="800px"
      :before-close="handleClose"
      destroy-on-close
    >
      <ArtForm ref="formRef" :model="formData" :rules="rules" label-width="120px">
        <ArtFormItem label="菜品名称" prop="name">
          <ElInput v-model="formData.name" placeholder="请填写菜品名称" maxlength="20" />
        </ArtFormItem>

        <ArtFormItem label="菜品分类" prop="categoryId">
          <ElSelect v-model="formData.categoryId" placeholder="请选择菜品分类" style="width: 100%">
            <ElOption v-for="item in dishCategoryListForForm" :key="item.id" :label="item.name" :value="item.id" />
          </ElSelect>
        </ArtFormItem>

        <ArtFormItem label="菜品价格" prop="price">
          <ElInput v-model="formData.price" placeholder="请设置菜品价格" />
        </ArtFormItem>

        <ArtFormItem label="商品码" prop="code">
          <ElInput v-model="formData.code" placeholder="请填写商品码" />
        </ArtFormItem>

        <ArtFormItem label="口味做法配置">
          <div class="flavor-box">
            <span v-if="dishFlavors.length === 0" class="add-but" @click="addFlavor"> + 添加口味</span>
            <div v-if="dishFlavors.length !== 0" class="flavor">
              <div class="title">
                <span>口味名（3个字内）</span>
              </div>
              <div class="cont">
                <div v-for="(item, index) in dishFlavors" :key="index" class="items">
                  <div class="it-tit">
                    <SelectInput
                      :dish-flavors-data="leftDishFlavors"
                      :index="index"
                      :model-value="item.name"
                      @select="selectHandle"
                    />
                  </div>
                  <div class="lab-items">
                    <span v-for="(it, ind) in item.value" :key="ind">
                      {{ it }}
                      <i @click="delFlavorLabel(index, ind)">X</i>
                    </span>
                  </div>
                  <span class="del-flavor del-but" @click="delFlavor(item.name)">删除</span>
                </div>
              </div>
              <div
                v-if="leftDishFlavors.length > 0 && dishFlavors.length < dishFlavorsData.length"
                class="add-but"
                @click="addFlavor"
              >
                添加口味
              </div>
            </div>
          </div>
        </ArtFormItem>

        <ArtFormItem label="菜品图片" prop="image">
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

        <ArtFormItem label="菜品描述">
          <ElInput
            v-model="formData.description"
            type="textarea"
            :rows="3"
            maxlength="200"
            placeholder="菜品描述，最长200字"
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
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, h, onMounted, computed, watch, nextTick } from 'vue'
import { useTable } from '@/hooks/core/useTable'
import { getDishPage, deleteDish, dishStatusByStatus, dishCategoryList, queryDishById, addDish, editDish } from '@/api/dish'
import { ElMessageBox, ElMessage, ElTag, ElButton as ElBtn, ElImage, ElDialog, ElIcon } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { useUserStore } from '@/store/modules/user'
import ArtButtonTable from '@/components/core/forms/art-button-table/index.vue'
import SelectInput from './components/SelectInput.vue'

defineOptions({ name: 'Dish' })

const userStore = useUserStore()

// 售卖状态选项
const saleStatusOptions = [
  { value: 0, label: '停售' },
  { value: 1, label: '启售' }
]

// 菜品分类列表（用于搜索）
const dishCategoryListOptions = ref<Array<{ value: string; label: string }>>([])

// 菜品分类列表（用于表单）
const dishCategoryListForForm = ref<Array<{ id: string; name: string }>>([])

// 弹窗相关
const dialogType = ref<'add' | 'edit'>('add')
const dialogVisible = ref(false)
const dialogTitle = ref('添加菜品')
const formRef = ref()

// 上传配置
const uploadImageUrl = `${import.meta.env.VITE_API_URL}/admin/common/upload`
const uploadHeaders = computed(() => ({
  token: userStore.accessToken
}))

// 图片URL
const imageUrl = ref('')

// 口味数据
const dishFlavorsData = ref([
  { name: '甜味', value: ['无糖', '少糖', '半糖', '多糖', '全糖'] },
  { name: '温度', value: ['热饮', '常温', '去冰', '少冰', '多冰'] },
  { name: '忌口', value: ['不要葱', '不要蒜', '不要香菜', '不要辣'] },
  { name: '辣度', value: ['不辣', '微辣', '中辣', '重辣'] }
])

const dishFlavors = ref<Array<{ name: string; value: string[] }>>([])
const leftDishFlavors = ref<Array<{ name: string; value: string[] }>>([])

// 表单数据
const formData = reactive({
  name: '',
  id: '',
  price: '',
  code: '',
  image: '',
  description: '',
  categoryId: '',
  status: true
})

// 表单验证规则
const rules = {
  name: [
    {
      required: true,
      validator: (rule: any, value: string, callback: Function) => {
        if (!value) {
          callback(new Error('请输入菜品名称'))
        } else {
          const reg = /^([A-Za-z0-9\u4e00-\u9fa5]){2,20}$/
          if (!reg.test(value)) {
            callback(new Error('菜品名称输入不符，请输入2-20个字符'))
          } else {
            callback()
          }
        }
      },
      trigger: 'blur'
    }
  ],
  categoryId: [{ required: true, message: '请选择菜品分类', trigger: 'change' }],
  image: { required: true, message: '菜品图片不能为空' },
  price: [
    {
      required: true,
      validator: (rule: any, value: string, callback: Function) => {
        const reg = /^([1-9]\d{0,5}|0)(\.\d{1,2})?$/
        if (!reg.test(value) || Number(value) <= 0) {
          callback(new Error('菜品价格格式有误，请输入大于零且最多保留两位小数的金额'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ],
  code: [{ required: true, message: '请填写商品码', trigger: 'blur' }]
}

// 监听口味变化，更新可选口味列表
watch(
  () => dishFlavors.value,
  () => {
    getLeftDishFlavors()
  },
  { deep: true }
)

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
    label: '菜品名称',
    component: 'ElInput',
    componentProps: {
      placeholder: '请填写菜品名称',
      clearable: true
    }
  },
  {
    prop: 'categoryId',
    label: '菜品分类',
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
    apiFn: getDishPage,
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
      { prop: 'name', label: '菜品名称' },
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
      { prop: 'categoryName', label: '菜品分类' },
      {
        prop: 'price',
        label: '售价',
        formatter: (row: any) => {
          return `￥${(row.price * 100 / 100).toFixed(2)}`
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
              onClick: () => addDishtype(row.id)
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
 * 获取菜品分类列表
 */
const getDishCategoryList = async () => {
  try {
    const res = await dishCategoryList({ type: 1 })
    if (Array.isArray(res)) {
      dishCategoryListOptions.value = res.map((item: any) => ({
        value: item.id,
        label: item.name
      }))
      dishCategoryListForForm.value = res.map((item: any) => ({
        id: item.id,
        name: item.name
      }))
    }
  } catch (err) {
    console.error('获取菜品分类列表失败:', err)
  }
}

/**
 * 获取可选口味列表（排除已选择的）
 */
const getLeftDishFlavors = () => {
  const arr: Array<{ name: string; value: string[] }> = []
  dishFlavorsData.value.forEach((item) => {
    if (dishFlavors.value.findIndex((item1) => item.name === item1.name) === -1) {
      arr.push(item)
    }
  })
  leftDishFlavors.value = arr
}

/**
 * 选择口味处理
 */
const selectHandle = (val: string, key: number) => {
  const arrDate = [...dishFlavors.value]
  const index = dishFlavorsData.value.findIndex((item) => item.name === val)
  if (index !== -1) {
    arrDate[key] = JSON.parse(JSON.stringify(dishFlavorsData.value[index]))
    dishFlavors.value = arrDate
  }
}

/**
 * 添加口味
 */
const addFlavor = () => {
  dishFlavors.value.push({ name: '', value: [] })
}

/**
 * 删除口味
 */
const delFlavor = (name: string) => {
  const ind = dishFlavors.value.findIndex((item) => item.name === name)
  if (ind !== -1) {
    dishFlavors.value.splice(ind, 1)
  }
}

/**
 * 删除口味标签
 */
const delFlavorLabel = (index: number, ind: number) => {
  dishFlavors.value[index].value.splice(ind, 1)
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
 * 显示弹窗
 */
const showDialog = async (type: 'add' | 'edit', id?: string) => {
  dialogType.value = type
  if (type === 'add') {
    dialogTitle.value = '添加菜品'
    // 重置表单
    Object.assign(formData, {
      name: '',
      id: '',
      price: '',
      code: '',
      image: '',
      description: '',
      categoryId: '',
      status: true
    })
    dishFlavors.value = []
    imageUrl.value = ''
    getLeftDishFlavors()
  } else {
    dialogTitle.value = '修改菜品'
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
    const res = await queryDishById(id)
    if (res) {
      Object.assign(formData, {
        name: res.name || '',
        id: res.id || '',
        price: String(res.price || ''),
        code: res.code || '',
        image: res.image || '',
        description: res.description || '',
        categoryId: res.categoryId || '',
        status: res.status == '1'
      })

      // 处理口味数据
      if (res.flavors && Array.isArray(res.flavors)) {
        dishFlavors.value = res.flavors.map((obj: any) => ({
          ...obj,
          value: typeof obj.value === 'string' ? JSON.parse(obj.value) : obj.value
        }))
      }

      imageUrl.value = res.image || ''
      getLeftDishFlavors()
    }
  } catch (err: any) {
    ElMessage.error(err.message || '获取菜品详情失败')
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
 * 提交表单
 */
const submitForm = async (mode?: string) => {
  if (!formRef.value) return

  try {
    await formRef.value.validate()
    if (!formData.image) {
      ElMessage.error('菜品图片不能为空')
      return
    }

    const params: any = {
      ...formData,
      status: dialogType.value === 'add' ? 0 : formData.status ? 1 : 0,
      categoryId: formData.categoryId,
      flavors: dishFlavors.value.map((obj) => ({
        ...obj,
        value: JSON.stringify(obj.value)
      }))
    }

    if (dialogType.value === 'add') {
      delete params.id
      await addDish(params)
      ElMessage.success('菜品添加成功！')
      if (mode === 'continue') {
        // 重置表单
        Object.assign(formData, {
          name: '',
          id: '',
          price: '',
          code: '',
          image: '',
          description: '',
          categoryId: '',
          status: true
        })
        dishFlavors.value = []
        imageUrl.value = ''
        formRef.value?.resetFields()
        getLeftDishFlavors()
      } else {
        dialogVisible.value = false
        refreshData()
      }
    } else {
      delete params.createTime
      delete params.updateTime
      await editDish(params)
      ElMessage.success('菜品修改成功！')
      dialogVisible.value = false
      refreshData()
    }
  } catch (err: any) {
    console.error('提交失败:', err)
  }
}

/**
 * 添加/编辑菜品
 */
const addDishtype = (id: string | 'add') => {
  if (id === 'add') {
    showDialog('add')
  } else {
    showDialog('edit', id)
  }
}

/**
 * 删除处理
 */
const deleteHandle = (type: string, id: any) => {
  if (type === '批量' && id === null) {
    if (selectedRows.value.length === 0) {
      ElMessage.error('请选择删除对象')
      return
    }
  }

  ElMessageBox.confirm('确认删除该菜品, 是否继续?', '确定删除', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      const ids = type === '批量' ? selectedRows.value.map((row) => row.id).join(',') : id
      deleteDish(ids)
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
    id: row.id,
    status: row.status ? '0' : '1'
  }

  ElMessageBox.confirm('确认更改该菜品状态?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      dishStatusByStatus(params)
        .then(() => {
          ElMessage.success('菜品状态已经更改成功！')
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
.dish-page {
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

.flavor-box {
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

  .flavor {
    border: solid 1px #dfe2e8;
    border-radius: 3px;
    padding: 15px;
    background: #fafafb;

    .title {
      color: #606168;
      margin-bottom: 10px;
    }

    .cont {
      .items {
        display: flex;
        align-items: center;
        margin: 10px 0;
        gap: 15px;

        .it-tit {
          width: 150px;
        }

        .lab-items {
          flex: 1;
          display: flex;
          flex-wrap: wrap;
          gap: 5px;
          border-radius: 3px;
          min-height: 39px;
          border: solid 1px #d8dde3;
          background: #fff;
          padding: 5px;

          span {
            display: inline-block;
            color: #ffc200;
            margin: 5px;
            line-height: 26px;
            padding: 0 10px;
            background: #fffbf0;
            border: 1px solid #fbe396;
            border-radius: 4px;
            font-size: 12px;

            i {
              cursor: pointer;
              font-style: normal;
              margin-left: 5px;
            }
          }
        }

        .del-flavor {
          display: inline-block;
          padding: 0 10px;
          color: #f19c59;
          cursor: pointer;
        }
      }
    }
  }
}
</style>

