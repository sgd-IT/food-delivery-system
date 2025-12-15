<template>
  <div class="employee-page art-full-height">
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
    />

    <ElCard class="art-table-card" shadow="never">
      <!-- 表格头部 -->
      <ArtTableHeader v-model:columns="columnChecks" :loading="loading" @refresh="refreshData">
        <template #left>
          <ElButton type="primary" size="small" @click="addEmployeeHandle('add')" v-ripple>
            + 添加员工
          </ElButton>
        </template>
      </ArtTableHeader>

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

    <!-- 员工弹窗 -->
    <ElDialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="600px"
      :before-close="handleClose"
      destroy-on-close
    >
      <ElForm ref="formRef" :model="formData" :rules="rules" label-width="120px">
        <ElFormItem label="账号" prop="username">
          <ElInput v-model="formData.username" placeholder="请输入账号" maxlength="20" />
        </ElFormItem>

        <ElFormItem label="员工姓名" prop="name">
          <ElInput v-model="formData.name" placeholder="请输入员工姓名" maxlength="12" />
        </ElFormItem>

        <ElFormItem label="手机号" prop="phone">
          <ElInput v-model="formData.phone" placeholder="请输入手机号" maxlength="11" />
        </ElFormItem>

        <ElFormItem label="性别" prop="sex">
          <ElRadioGroup v-model="formData.sex">
            <ElRadio label="男" />
            <ElRadio label="女" />
          </ElRadioGroup>
        </ElFormItem>

        <ElFormItem label="身份证号" prop="idNumber">
          <ElInput v-model="formData.idNumber" placeholder="请输入身份证号" maxlength="20" />
        </ElFormItem>
      </ElForm>
      <template #footer>
        <ElButton @click="handleClose">取 消</ElButton>
        <ElButton type="primary" @click="() => submitForm()">确 定</ElButton>
        <ElButton v-if="dialogType === 'add'" type="primary" @click="() => submitForm('continue')">
          保存并继续添加
        </ElButton>
      </template>
    </ElDialog>
  </div>
</template>

<script setup lang="ts">
import { ref, h, reactive, nextTick } from 'vue'
import { useTable } from '@/hooks/core/useTable'
import {
  getEmployeeList,
  enableOrDisableEmployee,
  queryEmployeeById,
  addEmployee,
  editEmployee,
  deleteEmployee
} from '@/api/employee'
import { ElMessageBox, ElMessage, ElTag, ElButton as ElBtn, ElDialog } from 'element-plus'
import ArtButtonTable from '@/components/core/forms/art-button-table/index.vue'

defineOptions({ name: 'Employee' })

// 搜索状态
const isSearch = ref(false)

// 弹窗相关
const dialogType = ref<'add' | 'edit'>('add')
const dialogVisible = ref(false)
const dialogTitle = ref('添加员工')
const formRef = ref()

// 表单数据
const formData = reactive<Record<'name' | 'phone' | 'sex' | 'idNumber' | 'username', string>>({
  name: '',
  phone: '',
  sex: '男',
  idNumber: '',
  username: ''
})

// 手机号验证
const isCellPhone = (val: string): boolean => {
  return /^1(3|4|5|6|7|8|9)\d{9}$/.test(val)
}

// 手机号验证器
const checkPhone = (rule: any, value: string, callback: Function) => {
  if (value === '') {
    callback(new Error('请输入手机号'))
  } else if (!isCellPhone(value)) {
    callback(new Error('请输入正确的手机号!'))
  } else {
    callback()
  }
}

// 身份证验证器
const validID = (rule: any, value: string, callback: Function) => {
  const reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/
  if (value === '') {
    callback(new Error('请输入身份证号码'))
  } else if (reg.test(value)) {
    callback()
  } else {
    callback(new Error('身份证号码不正确'))
  }
}

// 表单验证规则
const rules = {
  name: [
    {
      required: true,
      validator: (rule: any, value: string, callback: Function) => {
        if (!value) {
          callback(new Error('请输入员工姓名'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ],
  username: [
    {
      required: true,
      validator: (rule: any, value: string, callback: Function) => {
        if (!value) {
          callback(new Error('请输入账号'))
        } else {
          const reg = /^([a-z]|[0-9]){3,20}$/
          if (!reg.test(value)) {
            callback(new Error('账号输入不符，请输入3-20个字符'))
          } else {
            callback()
          }
        }
      },
      trigger: 'blur'
    }
  ],
  phone: [{ required: true, validator: checkPhone, trigger: 'blur' }],
  idNumber: [{ required: true, validator: validID, trigger: 'blur' }]
}

// 搜索表单
const searchForm = ref({
  name: undefined
})

// 搜索项配置
const searchItems = [
  {
    key: 'name',
    prop: 'name',
    label: '员工姓名',
    component: 'ElInput',
    componentProps: {
      placeholder: '请输入员工姓名',
      clearable: true
    }
  }
]

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
    apiFn: getEmployeeList,
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
      { prop: 'name', label: '员工姓名' },
      { prop: 'username', label: '账号' },
      { prop: 'phone', label: '手机号' },
      {
        prop: 'status',
        label: '账号状态',
        formatter: (row: any) => {
          const status = String(row.status) === '0' ? '禁用' : '启用'
          const type = String(row.status) === '0' ? 'danger' : 'success'
          return h(ElTag, { type }, () => status)
        }
      },
      { prop: 'updateTime', label: '最后操作时间' },
      {
        prop: 'operation',
        label: '操作',
        width: 200,
        fixed: 'right',
        formatter: (row: any) => {
          const isAdmin = row.username === 'admin'
          return h('div', { class: 'flex gap-2' }, [
            h(ArtButtonTable, {
              type: 'edit',
              onClick: () => addEmployeeHandle(row.id, row.username)
            }),
            h(ArtButtonTable, {
              type: 'delete',
              onClick: () => deleteHandle(row)
            }),
            h(
              ElBtn,
              {
                type: 'primary',
                link: true,
                disabled: isAdmin,
                onClick: () => statusHandle(row)
              },
              () => (row.status == '1' ? '禁用' : '启用')
            )
          ])
        }
      }
    ]
  }
})

/**
 * 搜索处理
 */
const handleSearch = (params: Record<string, any> = {}) => {
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
    dialogTitle.value = '添加员工'
    // 重置表单
    Object.assign(formData, {
      name: '',
      phone: '',
      sex: '男',
      idNumber: '',
      username: ''
    })
  } else {
    dialogTitle.value = '修改员工信息'
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
    const res: any = await queryEmployeeById(id)
    if (res) {
      Object.assign(formData, {
        name: res.name || '',
        phone: res.phone || '',
        sex: res.sex === '0' ? '女' : '男',
        idNumber: res.idNumber || '',
        username: res.username || ''
      })
    }
  } catch (err: any) {
    ElMessage.error(err.message || '获取员工详情失败')
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

    const params: any = {
      ...formData,
      sex: formData.sex === '女' ? '0' : '1'
    }

    if (dialogType.value === 'add') {
      await addEmployee(params)
      ElMessage.success('员工添加成功！')
      if (mode === 'continue') {
        // 重置表单
        Object.assign(formData, {
          name: '',
          phone: '',
          sex: '男',
          idNumber: '',
          username: ''
        })
        formRef.value?.resetFields()
      } else {
        dialogVisible.value = false
        refreshData()
      }
    } else {
      await editEmployee(params)
      ElMessage.success('员工信息修改成功！')
      dialogVisible.value = false
      refreshData()
    }
  } catch (err: any) {
    console.error('提交失败:', err)
  }
}

/**
 * 添加/编辑员工
 */
const addEmployeeHandle = (id: string | 'add', username?: string) => {
  if (username === 'admin') {
    return
  }
  if (id === 'add') {
    showDialog('add')
  } else {
    showDialog('edit', id)
  }
}

/**
 * 状态修改
 */
const statusHandle = (row: any) => {
  const newStatus = !row.status ? 1 : 0
  ElMessageBox.confirm('确认调整该员工的状态?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      enableOrDisableEmployee({ id: row.id, status: newStatus })
        .then(() => {
          ElMessage.success('员工状态更改成功！')
          refreshData()
        })
        .catch((err: any) => {
          ElMessage.error('请求出错了：' + err.message)
        })
    })
    .catch(() => {})
}

/**
 * 删除员工
 */
const deleteHandle = (row: any) => {
  if (row.username === 'admin') {
    ElMessage.warning('admin 账号不允许删除')
    return
  }
  ElMessageBox.confirm('确认删除该员工吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(async () => {
      await deleteEmployee(row.id)
      ElMessage.success('删除成功！')
      refreshData()
    })
    .catch(() => {})
}
</script>

<style scoped lang="scss">
.employee-page {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>

