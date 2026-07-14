<script setup>
import { ref, onMounted } from 'vue'

const users = ref([])

onMounted(async () => {
  const response = await fetch(
    "https://treehousechallenge.contractornation.com/newsletter",
    {
      headers: {
        Authorization: "3b7d7b60-7ed1-11f1-8328-0963ebbe9e26",
      },
    }
  )

  users.value = await response.json()
})
</script>

<template>
  <main>
    <nav>
      <RouterLink to="/">Users</RouterLink>
      <RouterLink to="/add">Change User</RouterLink>
    </nav>

    <RouterView :users="users" />
  </main>
</template>