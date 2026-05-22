import axios from 'axios'
import { useUserStore } from '@/store/user'

const api = axios.create({
  baseURL: '/api',
  timeout: 10000
})

const publicPaths = ['/auth/public-key', '/auth/login']

api.interceptors.request.use(
  (config) => {
    const userStore = useUserStore()
    const isPublicPath = publicPaths.some(path => config.url?.includes(path))
    
    if (userStore.token && !isPublicPath) {
      config.headers.Authorization = `Bearer ${userStore.token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

api.interceptors.response.use(
  (response) => {
    return response.data
  },
  (error) => {
    if (error.response?.status === 401) {
      const userStore = useUserStore()
      userStore.logout()
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export default api
