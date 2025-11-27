<template>
  <div class="category-page art-full-height">
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
          <ElButton type="primary" @click="showDialog('add', 'class')" v-ripple>
            + 新增菜品分类
          </ElButton>
          <ElButton type="primary" @click="showDialog('add', 'meal')" v-ripple>
            + 新增套餐分类
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
        @pagination:size-change="handleSizeChange"
        @pagination:current-change="handleCurrentChange"
      />

      <!-- 空状态 -->
      <ElEmpty v-if="!loading && data.length === 0" :description="isSearch ? 'Sorry，木有找到您搜索的内容哦~' : '这里空空如也~'" />
    </ElCard>

    <!-- 分类弹窗 -->
    <ElDialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="500px"
      :before-close="handleClose"
    >
      <ArtForm
        ref="formRef"
        :model="formData"
        :rules="rules"
        label-width="100px"
      >
        <ArtFormItem label="分类名称：" prop="name">
          <ElInput v-model="formData.name" placeholder="请输入分类名称" maxlength="20" />
        </ArtFormItem>
        <ArtFormItem label="排序：" prop="sort">
          <ElInput v-model="formData.sort" placeholder="请输入排序" />
        </ArtFormItem>
      </ArtForm>
      <template #footer>
        <ElButton @click="handleClose">取 消</ElButton>
        <ElButton type="primary" @click="submitForm">确 定</ElButton>
        <ElButton v-if="dialogType !== 'edit'" type="primary" @click="submitForm('go')">
          保存并继续添加
        </ElButton>
      </template>
    </ElDialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, h, nextTick } from 'vue'
import { useTable } from '@/hooks/core/useTable'
import {
  getCategoryPage,
  deleCategory,
  editCategory,
  addCategory,
  enableOrDisableCategory
} from '@/api/category'
import { ElMessageBox, ElMessage, ElTag, ElButton as ElBtn } from 'element-plus'
import ArtButtonTable from '@/components/core/forms/art-button-table/index.vue'

defineOptions({ name: 'Category' })

// 分类类型选项
const categoryTypeOptions = [
  { value: 1, label: '菜品分类' },
  { value: 2, label: '套餐分类' }
]

// 弹窗相关
const dialogType = ref<'add' | 'edit'>('add')
const dialogVisible = ref(false)
const dialogTitle = ref('添加菜品分类')
const formRef = ref()
const formData = reactive({
  id: '',
  name: '',
  sort: '',
  type: '1'
})

// 搜索状态
const isSearch = ref(false)

// 搜索表单
const searchForm = ref({
  name: undefined,
  type: undefined
})

// 搜索项配置
const searchItems = [
  {
    prop: 'name',
    label: '分类名称',
    component: 'ElInput',
    componentProps: {
      placeholder: '请填写分类名称',
      clearable: true
    }
  },
  {
    prop: 'type',
    label: '分类类型',
    component: 'ElSelect',
    componentProps: {
      placeholder: '请选择',
      clearable: true,
      options: categoryTypeOptions
    }
  }
]

// 表单验证规则
const rules = {
  name: [
    {
      required: true,
      trigger: 'blur',
      validator: (rule: any, value: string, callback: Function) => {
        const reg = /^[A-Za-z\u4e00-\u9fa5]+$/
        if (!value) {
          callback(new Error(dialogTitle.value + '不能为空'))
        } else if (value.length < 2) {
          callback(new Error('分类名称输入不符，请输入2-20个字符'))
        } else if (!reg.test(value)) {
          callback(new Error('分类名称包含特殊字符'))
        } else {
          callback()
        }
      }
    }
  ],
  sort: [
    {
      required: true,
      trigger: 'blur',
      validator: (rule: any, value: string, callback: Function) => {
        if (value || String(value) === '0') {
          const reg = /^\d+$/
          if (!reg.test(value)) {
            callback(new Error('排序只能输入数字类型'))
          } else if (Number(value) > 99) {
            callback(new Error('排序只能输入0-99数字'))
          } else {
            callback()
          }
        } else {
          callback(new Error('排序不能为空'))
        }
      }
    }
  ]
}

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
    apiFn: getCategoryPage,
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
      { type: 'index', width: 60, label: '序号' },
      { prop: 'name', label: '分类名称' },
      {
        prop: 'type',
        label: '分类类型',
        formatter: (row: any) => {
          return row.type == '1' ? '菜品分类' : '套餐分类'
        }
      },
      { prop: 'sort', label: '排序' },
      {
        prop: 'status',
        label: '状态',
        formatter: (row: any) => {
          const status = String(row.status) === '0' ? '禁用' : '启用'
          const type = String(row.status) === '0' ? 'danger' : 'success'
          return h(ElTag, { type }, () => status)
        }
      },
      { prop: 'updateTime', label: '操作时间' },
      {
        prop: 'operation',
        label: '操作',
        width: 200,
        fixed: 'right',
        formatter: (row: any) =>
          h('div', { class: 'flex gap-2' }, [
            h(ArtButtonTable, {
              type: 'edit',
              onClick: () => showDialog('edit', row)
            }),
            h(ArtButtonTable, {
              type: 'delete',
              onClick: () => deleteHandle(row.id)
            }),
            h(
              ElBtn,
              {
                type: 'primary',
                link: true,
                onClick: () => statusHandle(row)
              },
              () => (row.status == '1' ? '禁用' : '启用')
            )
          ])
      }
    ]
  }
})

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
const showDialog = (type: 'add' | 'edit', categoryType?: 'class' | 'meal', row?: any) => {
  dialogType.value = type
  if (type === 'add') {
    if (categoryType === 'class') {
      dialogTitle.value = '新增菜品分类'
      formData.type = '1'
    } else {
      dialogTitle.value = '新增套餐分类'
      formData.type = '2'
    }
    formData.id = ''
    formData.name = ''
    formData.sort = ''
  } else {
    dialogTitle.value = '修改分类'
    formData.id = row.id
    formData.name = row.name
    formData.sort = row.sort
  }
  nextTick(() => {
    dialogVisible.value = true
  })
}

/**
 * 关闭弹窗
 */
const handleClose = () => {
  dialogVisible.value = false
  formRef.value?.resetFields()
}

/**
 * 状态修改
 */
const statusHandle = (row: any) => {
  const newStatus = !row.status ? 1 : 0
  ElMessageBox.confirm('确认调整该分类的状态?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      enableOrDisableCategory({ id: row.id, status: newStatus })
        .then(() => {
          ElMessage.success('分类状态更改成功！')
          refreshData()
        })
        .catch((err: any) => {
          ElMessage.error('请求出错了：' + err.message)
        })
    })
    .catch(() => {})
}

/**
 * 删除
 */
const deleteHandle = (id: any) => {
  ElMessageBox.confirm('此操作将永久删除该分类，是否继续？', '确定删除', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      deleCategory(id)
        .then(() => {
          ElMessage.success('删除成功！')
          refreshData()
        })
        .catch((err: any) => {
          ElMessage.error('请求出错了：' + err.message)
        })
    })
    .catch(() => {})
}

/**
 * 提交表单
 */
const submitForm = async (action?: string) => {
  if (!formRef.value) return

  await formRef.value.validate().catch(() => {
    return false
  })

  try {
    if (dialogType.value === 'add') {
      await addCategory({
        name: formData.name,
        type: formData.type,
        sort: formData.sort
      })
      ElMessage.success('分类添加成功！')
      formRef.value.resetFields()
      if (!action) {
        dialogVisible.value = false
      }
    } else {
      await editCategory({
        id: formData.id,
        name: formData.name,
        sort: formData.sort
      })
      ElMessage.success('分类修改成功！')
      dialogVisible.value = false
      formRef.value.resetFields()
    }
    refreshData()
  } catch (err: any) {
    ElMessage.error('请求出错了：' + err.message)
  }
}
</script>

<style scoped lang="scss">
.category-page {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>

