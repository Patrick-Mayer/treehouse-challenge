import { createRouter, createWebHistory } from 'vue-router'

import ListView from '../List.vue'
import AddUserView from '../ChangeUser.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: ListView
    },
    {
      path: '/add',
      component: AddUserView
    }
  ]
})

export default router