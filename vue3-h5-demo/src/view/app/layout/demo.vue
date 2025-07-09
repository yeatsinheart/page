<script setup>
import {open_by_key, ViewKeyPathMap} from "@/view.js";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
import {appStore} from "@/config/store/app.js";
import PopPage from "@/tool/pop.js";

import { useRoute } from "vue-router";
const route = useRoute();

const show_download_tip =ref(true)

const show_bottom_bar =computed(()=>{
    /*return appStore().app.layoutItem.bar_bottom.some((item) => {
      return route?.path === "/" || "/" + item.openViewKey === route?.path;
    });*/
    return true;
})

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
      <ViewImportByPath :path="ViewKeyPathMap.download_tip" v-model="show_download_tip"></ViewImportByPath>
      <router-view :style="'height: calc(100% '+(show_download_tip?'- 0.7rem':'')+' '+(show_bottom_bar?'- 1.44rem':'')+')'"/>
      <ViewImportByPath :path="ViewKeyPathMap.bottom_bar" v-model="show_bottom_bar"></ViewImportByPath>

      <div style="z-index:5;position:fixed;bottom: 1.6rem;left:.2rem;" v-if="appStore().app?.layoutItem?.global_left_bottom">
        <div @click="open_by_key(item.openViewKey)" class="flex-column global_helper" style="padding: 0.1rem"
             v-for="(item, index) in appStore().app?.layoutItem?.global_left_bottom" :key="index">
          <img class="img1x1" style="width: 0.5rem" :src="item.iconI18nKey"/>
          <span>{{ $t(item.titleI18nKey) }}</span>
        </div>
      </div>

      <div style="z-index:5;position:fixed;bottom: 1.6rem;right:.2rem;" v-if="appStore().app?.layoutItem?.global_right_bottom">
        <div @click="open_by_key(item.openViewKey)" class="flex-column global_helper" style="padding: 0.1rem"
             v-for="(item, index) in appStore().app?.layoutItem?.global_right_bottom" :key="index">
          <img class="img1x1" style="width: 0.5rem" :src="item.iconI18nKey"/>
          <span>{{ $t(item.titleI18nKey) }}</span>
        </div>
      </div>
      <PopPage/>
    </div>

</template>

<style scoped lang="scss">
</style>
