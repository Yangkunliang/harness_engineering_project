<template>
  <div class="user-management">
    <div class="page-header">
      <h1>用户管理</h1>
      <button @click="showCreateModal = true" class="create-btn">创建用户</button>
    </div>

    <div class="table-container">
      <table class="user-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>用户名</th>
            <th>真实姓名</th>
            <th>角色</th>
            <th>邮箱</th>
            <th>手机号</th>
            <th>状态</th>
            <th>最后登录</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td>{{ user.id }}</td>
            <td>{{ user.username }}</td>
            <td>{{ user.realName || '-' }}</td>
            <td>
              <span class="role-badge" :class="user.role.toLowerCase()">
                {{ user.role }}
              </span>
            </td>
            <td>{{ user.email || '-' }}</td>
            <td>{{ user.phone || '-' }}</td>
            <td>
              <span :class="user.enabled ? 'status-active' : 'status-disabled'">
                {{ user.enabled ? '启用' : '禁用' }}
              </span>
            </td>
            <td>{{ user.lastLoginTime || '-' }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div v-if="showCreateModal" class="modal-overlay" @click.self="showCreateModal = false">
      <div class="modal">
        <h2>创建用户</h2>
        <form @submit.prevent="handleCreateUser">
          <div class="form-item">
            <label>用户名</label>
            <input v-model="createForm.username" type="text" required />
          </div>
          <div class="form-item">
            <label>密码</label>
            <input v-model="createForm.password" type="password" required />
          </div>
          <div class="form-item">
            <label>真实姓名</label>
            <input v-model="createForm.realName" type="text" />
          </div>
          <div class="form-item">
            <label>邮箱</label>
            <input v-model="createForm.email" type="email" />
          </div>
          <div class="form-item">
            <label>手机号</label>
            <input v-model="createForm.phone" type="tel" />
          </div>
          <div class="form-item">
            <label>角色</label>
            <select v-model="createForm.role" required>
              <option value="ADMIN">管理员</option>
              <option value="USER">普通用户</option>
            </select>
          </div>
          <div class="form-actions">
            <button type="button" @click="showCreateModal = false" class="cancel-btn">取消</button>
            <button type="submit" class="submit-btn">创建</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { userApi, User } from '@/api/user'

const users = ref<User[]>([])
const showCreateModal = ref(false)

const createForm = ref({
  username: '',
  password: '',
  realName: '',
  email: '',
  phone: '',
  role: 'USER',
  enabled: true
})

onMounted(async () => {
  await loadUsers()
})

async function loadUsers() {
  try {
    const response = await userApi.getAllUsers()
    if (response.code === 200) {
      users.value = response.data
    }
  } catch (error) {
    console.error('Failed to load users:', error)
  }
}

async function handleCreateUser() {
  try {
    const response = await userApi.createUser(createForm.value)
    if (response.code === 200) {
      showCreateModal.value = false
      createForm.value = {
        username: '',
        password: '',
        realName: '',
        email: '',
        phone: '',
        role: 'USER',
        enabled: true
      }
      await loadUsers()
    }
  } catch (error) {
    console.error('Failed to create user:', error)
    alert('创建用户失败')
  }
}
</script>

<style scoped>
.user-management {
  background: white;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.page-header h1 {
  font-size: 20px;
  font-weight: 600;
  color: #333;
}

.create-btn {
  padding: 10px 20px;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.3s;
}

.create-btn:hover {
  background: #5a6fd6;
}

.table-container {
  overflow-x: auto;
}

.user-table {
  width: 100%;
  border-collapse: collapse;
}

.user-table th,
.user-table td {
  padding: 12px 16px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.user-table th {
  background: #f8f9fa;
  font-weight: 600;
  color: #333;
  font-size: 14px;
}

.user-table td {
  color: #666;
  font-size: 14px;
}

.role-badge {
  display: inline-block;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

.role-badge.super_admin {
  background: #ffe6e6;
  color: #c00;
}

.role-badge.admin {
  background: #e6f3ff;
  color: #06c;
}

.role-badge.user {
  background: #e6ffe6;
  color: #0a0;
}

.status-active {
  color: #0a0;
}

.status-disabled {
  color: #c00;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal {
  width: 480px;
  background: white;
  border-radius: 8px;
  padding: 24px;
}

.modal h2 {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 24px;
}

.form-item {
  margin-bottom: 16px;
}

.form-item label {
  display: block;
  margin-bottom: 8px;
  font-size: 14px;
  color: #333;
}

.form-item input,
.form-item select {
  width: 100%;
  height: 40px;
  padding: 0 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.form-item input:focus,
.form-item select:focus {
  outline: none;
  border-color: #667eea;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 24px;
}

.cancel-btn,
.submit-btn {
  padding: 10px 20px;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
}

.cancel-btn {
  background: #f5f5f5;
  color: #666;
  border: 1px solid #ddd;
}

.submit-btn {
  background: #667eea;
  color: white;
  border: none;
}
</style>
