<script setup>
// 根据路由参数 获取活动详情，打开具体界面

import {useRoute} from "vue-router";
import {ApiRequest} from "@/api/index.js";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
const route = useRoute();
const bonus = ref({})
const loading = ref(false);
onBeforeMount(() => {
  // 获取指定活动
  if(route.query.bonusId){
    Promise.all([ApiRequest._qD0l54JX({bonusId: route.query.bonusId})
      ,ApiRequest._qIn5tguk({bonusId: route.query.bonusId})])
        .then(([status_response,bonus_res])=>{
          bonus.value = bonus_res;
        }).finally(()=>{loading.value = false;})
  }
})
</script>

<template>
  <div v-loading="loading" style="width:100%;height:100%;">
  <ViewImportByPath v-if=bonus.view :path="bonus.view"/>
  <!-- 甚至可以用iframe - html 来实现动态页面  -->
  </div>
</template>

<style scoped lang="scss">

</style>