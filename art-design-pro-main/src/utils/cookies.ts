/**
 * Cookie工具函数
 * 用于存储和读取Cookie，保持与旧前端的兼容性
 */

/**
 * 获取Cookie值
 */
function getCookie(name: string): string | undefined {
  const value = `; ${document.cookie}`
  const parts = value.split(`; ${name}=`)
  if (parts.length === 2) {
    return parts.pop()?.split(';').shift()
  }
  return undefined
}

/**
 * 设置Cookie值
 */
function setCookie(name: string, value: string, days: number = 7): void {
  const expires = new Date()
  expires.setTime(expires.getTime() + days * 24 * 60 * 60 * 1000)
  document.cookie = `${name}=${value};expires=${expires.toUTCString()};path=/`
}

/**
 * 删除Cookie
 */
function removeCookie(name: string): void {
  document.cookie = `${name}=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;`
}

// Token相关
const tokenKey = 'token'
export const getToken = () => getCookie(tokenKey)
export const setToken = (token: string) => setCookie(tokenKey, token)
export const removeToken = () => removeCookie(tokenKey)

// StoreId相关
const storeIdKey = 'storeId'
export const getStoreId = () => getCookie(storeIdKey)
export const setStoreId = (id: string) => setCookie(storeIdKey, id)
export const removeStoreId = () => removeCookie(storeIdKey)

// UserInfo相关
const userInfoKey = 'userInfo'
export const getUserInfo = () => {
  const value = getCookie(userInfoKey)
  return value ? JSON.parse(value) : null
}
export const setUserInfo = (userInfo: any) => {
  setCookie(userInfoKey, JSON.stringify(userInfo))
}
export const removeUserInfo = () => removeCookie(userInfoKey)

// Username相关
const usernameKey = 'username'
export const getUsername = () => getCookie(usernameKey)
export const setUsername = (username: string) => setCookie(usernameKey, username)
export const removeUsername = () => removeCookie(usernameKey)

