<script setup>
import {ViewKeyPathMap} from "@/view.js";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
onBeforeMount(() => {
  let color = localStorage.getItem('color_version');
  if(null!=color&&color.length>0){
    //document.getElementById('color-version').setAttribute('href', '/api/style.css?'+color)
  }
  localStorage.getItem('view_version');
});
</script>

<template>
    <div style="height: 100%;width: 100%;">
      <ViewImportByPath :path="ViewKeyPathMap.download_tip"></ViewImportByPath>
      <router-view />
      <ViewImportByPath :path="ViewKeyPathMap.bottom_bar"></ViewImportByPath>
<!--
      <div style="z-index:5;position:fixed;bottom: 1.6rem;left:.2rem;" v-if="appStore().app?.layout?.global_left_bottom">
        <div @click="view_route_by_key(item.callViewKey)" class="flex-column global_helper" style="padding: 0.1rem"
             v-for="(item, index) in appStore().app?.layout?.global_left_bottom" :key="index">
          <img class="img1x1" style="width: 0.5rem" :src="item.icon"/>
          <span>{{ $t(item.title) }}</span>
        </div>
      </div>

      <div style="z-index:5;position:fixed;bottom: 1.6rem;right:.2rem;" v-if="appStore().app?.layout?.global_right_bottom">
        <div @click="view_route_by_key(item.callViewKey)" class="flex-column global_helper" style="padding: 0.1rem"
             v-for="(item, index) in appStore().app?.layout?.global_right_bottom" :key="index">
          <img class="img1x1" style="width: 0.5rem" :src="item.icon"/>
          <span>{{ $t(item.title) }}</span>
        </div>
      </div>
      <PopPage/>-->
    </div>

</template>

<style scoped lang="scss">
</style>
