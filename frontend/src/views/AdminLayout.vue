<template>
  <div class="admin-layout">
    <aside class="sidebar">
      <div class="logo">
        <h2>Harness</h2>
      </div>
      <nav class="nav-menu">
        <router-link to="/admin/users" class="nav-item">
          <span class="icon">👥</span>
          <span>用户管理</span>
        </router-link>
      </nav>
      <div class="user-info">
        <div class="user-details">
          <span class="username">{{ userStore.userInfo?.realName || userStore.userInfo?.username }}</span>
          <span class="role">{{ userStore.userInfo?.role }}</span>
        </div>
        <button @click="handleLogout" class="logout-btn">退出</button>
      </div>
    </aside>
    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/user'

const router = useRouter()
const userStore = useUserStore()

function handleLogout() {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.admin-layout {
  display: flex;
  min-height: 100vh;
}

.sidebar {
  width: 240px;
  background: #2c3e50;
  color: white;
  display: flex;
  flex-direction: column;
}

.logo {
  padding: 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo h2 {
  font-size: 20px;
  font-weight: 600;
}

.nav-menu {
  flex: 1;
  padding: 16px 0;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 24px;
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  transition: all 0.3s;
}

.nav-item:hover,
.nav-item.router-link-active {
  background: rgba(255, 255, 255, 0.1);
  color: white;
}

.icon {
  font-size: 18px;
}

.user-info {
  padding: 16px 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.user-details {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.username {
  font-size: 14px;
  font-weight: 500;
}

.role {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
}

.logout-btn {
  padding: 6px 12px;
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: background 0.3s;
}

.logout-btn:hover {
  background: rgba(255, 255, 255, 0.2);
}

.main-content {
  flex: 1;
  background: #f5f5f5;
  padding: 24px;
  overflow-y: auto;
}
</style>
