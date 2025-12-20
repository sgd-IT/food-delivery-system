<!-- 登录页面 -->
<template>
  <div class="flex w-full h-screen login-container-bg">
    <LoginLeftView />

    <div class="relative flex-1 flex items-center justify-center right-section">
      <AuthTopBar />

      <div class="auth-right-wrap glass-form-container">
        <div class="form">
          <h3 class="title">{{ $t('login.title') }}</h3>
          <p class="sub-title">{{ $t('login.subTitle') }}</p>
          <ElForm
            ref="formRef"
            :model="formData"
            :rules="rules"
            :key="formKey"
            @keyup.enter="handleSubmit"
            style="margin-top: 35px"
          >
            <!-- 移除账号选择，直接使用用户名密码登录 -->
            <ElFormItem prop="username">
              <ElInput
                class="custom-height"
                :placeholder="$t('login.placeholder.username')"
                v-model.trim="formData.username"
              >
                <template #prefix>
                   <i class="ri-user-line" style="margin-right: 5px;"></i>
                </template>
              </ElInput>
            </ElFormItem>
            <ElFormItem prop="password">
              <ElInput
                class="custom-height"
                :placeholder="$t('login.placeholder.password')"
                v-model.trim="formData.password"
                type="password"
                autocomplete="off"
                show-password
              >
                <template #prefix>
                   <i class="ri-lock-line" style="margin-right: 5px;"></i>
                </template>
              </ElInput>
            </ElFormItem>

            <div style="margin-top: 30px">
              <ElButton
                class="w-full custom-height submit-btn"
                type="primary"
                @click="handleSubmit"
                :loading="loading"
                v-ripple
              >
                {{ $t('login.btnText') }}
              </ElButton>
            </div>

            <div class="mt-6 text-sm text-center">
              <span class="text-gray-500">{{ $t('login.noAccount') }}</span>
              <RouterLink class="register-link" :to="{ name: 'Register' }">{{
                $t('login.register')
              }}</RouterLink>
            </div>
          </ElForm>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useUserStore } from '@/store/modules/user'
  import { getCssVar } from '@/utils/ui'
  import { useI18n } from 'vue-i18n'
  import { HttpError } from '@/utils/http/error'
  import { ElNotification, type FormInstance, type FormRules } from 'element-plus'
  import { useSettingStore } from '@/store/modules/setting'

  defineOptions({ name: 'Login' })

  const settingStore = useSettingStore()
  const { isDark } = storeToRefs(settingStore)
  const { t, locale } = useI18n()
  const formKey = ref(0)

  // 监听语言切换，重置表单
  watch(locale, () => {
    formKey.value++
  })

  type AccountKey = 'super' | 'admin' | 'user'

  export interface Account {
    key: AccountKey
    label: string
    userName: string
    password: string
    roles: string[]
  }

  const accounts = computed<Account[]>(() => [
    {
      key: 'super',
      label: t('login.roles.super'),
      userName: 'Super',
      password: '123456',
      roles: ['R_SUPER']
    },
    {
      key: 'admin',
      label: t('login.roles.admin'),
      userName: 'Admin',
      password: '123456',
      roles: ['R_ADMIN']
    },
    {
      key: 'user',
      label: t('login.roles.user'),
      userName: 'User',
      password: '123456',
      roles: ['R_USER']
    }
  ])

  const userStore = useUserStore()
  const router = useRouter()
  const route = useRoute()

  const formRef = ref<FormInstance>()

  const formData = reactive({
    account: '',
    username: 'admin',
    password: '123456',
    rememberPassword: false
  })

  const rules = computed<FormRules>(() => ({
    username: [{ required: true, message: t('login.placeholder.username'), trigger: 'blur' }],
    password: [{ required: true, message: t('login.placeholder.password'), trigger: 'blur' }]
  }))

  const loading = ref(false)

  onMounted(() => {
    // 默认使用admin账号
    formData.username = 'admin'
    formData.password = '123456'
  })

  // 设置账号
  const setupAccount = (key: AccountKey) => {
    const selectedAccount = accounts.value.find((account: Account) => account.key === key)
    formData.account = key
    formData.username = selectedAccount?.userName ?? ''
    formData.password = selectedAccount?.password ?? ''
  }

  // 登录
  const handleSubmit = async () => {
    if (!formRef.value) return

    try {
      // 表单验证
      const valid = await formRef.value.validate()
      if (!valid) return

      loading.value = true

      // 登录请求（使用适配后的loginUser方法）
      const { username, password } = formData

      await userStore.loginUser({
        username,
        password
      })

      // 登录成功处理
      showLoginSuccessNotice()

      // 获取 redirect 参数，如果存在则跳转到指定页面，否则跳转到首页
      const redirect = route.query.redirect as string
      router.push(redirect || '/dashboard')
    } catch (error) {
      // 处理 HttpError
      if (error instanceof HttpError) {
        // console.log(error.code)
      } else {
        // 处理非 HttpError
        // ElMessage.error('登录失败，请稍后重试')
        console.error('[Login] Unexpected error:', error)
      }
    } finally {
      loading.value = false
    }
  }

  // 登录成功提示
  const showLoginSuccessNotice = () => {
    setTimeout(() => {
      // 获取用户信息
      const userInfo = userStore.getUserInfo.value
      const userName = userInfo?.userName || formData.username || '用户'
      
      ElNotification({
        title: t('login.success.title'),
        type: 'success',
        duration: 2500,
        zIndex: 10000,
        message: `${t('login.success.message')}, ${userName}!`
      })
    }, 1000)
  }
</script>

<style scoped>
  @import './style.css';
</style>

<style lang="scss" scoped>
  // 右侧整体背景微调 (与左侧冷蓝衔接)
  .right-section {
     background: linear-gradient(to right, #e6f7ff 0%, #ffffff 20%);
  }

  .glass-form-container {
     position: relative;
     margin: auto; 
     padding: 40px 50px;
     background: rgba(255, 255, 255, 0.6);
     backdrop-filter: blur(20px);
     border-radius: 24px;
     border: 1px solid rgba(255, 255, 255, 0.8);
     box-shadow: 0 10px 40px rgba(0, 0, 0, 0.05);
     transition: all 0.3s ease;
     
     &:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 50px rgba(24, 144, 255, 0.15); // 科技蓝阴影
     }

     .title {
        color: #003a8c; // 深蓝文字
        font-weight: 800;
        margin-bottom: 5px;
     }
     
     .sub-title {
        color: #597ef7; // 浅蓝文字
        margin-bottom: 20px;
     }
  }

  // 覆盖 Element Plus 样式
  :deep(.el-input__wrapper) {
    background-color: rgba(255, 255, 255, 0.8);
    box-shadow: none !important;
    border: 1px solid #d9d9d9;
    border-radius: 12px;
    padding: 5px 15px;
    transition: all 0.3s;
    
    &:hover, &.is-focus {
       background-color: #fff;
       border-color: #1890ff; // 聚焦时变科技蓝
       box-shadow: 0 0 0 3px rgba(24, 144, 255, 0.1) !important;
    }
  }

  // 登录按钮样式升级
  .submit-btn {
     height: 48px !important;
     font-size: 16px;
     font-weight: 600;
     border: none;
     border-radius: 12px;
     background: linear-gradient(135deg, #1890ff 0%, #096dd9 100%); // 蓝深蓝渐变
     transition: all 0.3s;
     
     &:hover {
        transform: scale(1.02);
        box-shadow: 0 10px 20px rgba(24, 144, 255, 0.3);
        opacity: 0.95;
     }
     
     &:active {
        transform: scale(0.98);
     }
  }

  // 注册链接
  .register-link {
     color: #1890ff;
     font-weight: 600;
     margin-left: 5px;
     transition: all 0.2s;
     
     &:hover {
        color: #096dd9;
        text-decoration: underline;
     }
  }

  :deep(.el-select__wrapper) {
    height: 40px !important;
  }
  
  // 暗黑模式适配
  .dark {
     .right-section {
        background: #001529;
     }
     .glass-form-container {
        background: rgba(0, 21, 41, 0.6);
        border-color: rgba(255, 255, 255, 0.05);
        
        .title { color: #d6e4ff; }
        .sub-title { color: #85a5ff; }
     }
     :deep(.el-input__wrapper) {
        background-color: rgba(0,0,0,0.3);
        border-color: #1d39c4;
        &:hover { border-color: #1890ff; }
     }
  }
</style>
