import api from './index'

export interface LoginRequest {
  username: string
  encryptedPassword: string
  signature?: string
}

export interface LoginResponse {
  token: string
  tokenType: string
  expiresIn: number
  user: {
    id: number
    username: string
    realName: string
    role: string
    superAdmin: boolean
  }
}

export interface ApiResponse<T> {
  code: number
  message: string
  data: T
}

export const authApi = {
  getPublicKey(): Promise<ApiResponse<{ publicKey: string }>> {
    return api.get('/auth/public-key')
  },

  login(data: LoginRequest): Promise<ApiResponse<LoginResponse>> {
    return api.post('/auth/login', data)
  }
}
