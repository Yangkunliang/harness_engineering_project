import api from './index'

export interface User {
  id: number
  username: string
  realName: string
  phone: string
  email: string
  role: string
  enabled: boolean
  superAdmin: boolean
  lastLoginIp: string
  lastLoginTime: string
  createTime: string
}

export interface UserCreateRequest {
  username: string
  password: string
  realName: string
  phone: string
  email: string
  role: string
  enabled: boolean
}

export const userApi = {
  getAllUsers(): Promise<{ code: number; message: string; data: User[] }> {
    return api.get('/users')
  },

  getUserByUsername(username: string): Promise<{ code: number; message: string; data: User }> {
    return api.get(`/users/${username}`)
  },

  createUser(data: UserCreateRequest): Promise<{ code: number; message: string; data: User }> {
    return api.post('/users', data)
  }
}
