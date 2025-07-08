<template>
  <div style="overflow-y: auto;height:100%;">
    <h2>所有路由 {{ routes.length }}</h2>
    <ul>
      <li v-for="route in routes" :key="route.path">
        <router-link v-if="!route.path.startsWith('/src/')" :to="route.path">{{ route.path }} -> {{ route.redirect }}
        </router-link>
      </li>
      <br/>
      <br/>
      <br/>
      <li v-for="route in routes" :key="route.path">
        <router-link v-if="route.path.startsWith('/src/')" :to="route.path">{{ route.path }} -> {{ route.redirect }}
        </router-link>
      </li>
      <br/>
      <br/>
      <br/>
      <li v-for="route in routes" :key="route.path">
        <router-link v-if="route.path.startsWith('/dev/')" :to="route.path">{{ route.path }} -> {{ route.redirect }}
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script setup>

import {onBeforeMount, ref} from "vue";
import router from "@/config/router";

const routes = ref([]);
onBeforeMount(() => {
  let arr = []
  router.getRoutes().forEach(r => {
    arr.push({path: r.path, redirect: r.redirect});
  })

  arr.sort((a, b) => a.path.localeCompare(b.path));
  routes.value = arr;
});
</script>


