<script setup>

import ViewImportByPath from "@/tool/ViewImportByPath.vue";
import {useRoute} from "vue-router";
const route = useRoute();

onBeforeMount(()=>{
})
import router from "@/config/router";
const emit = defineEmits();
const close = () => {
  emit('destroy');
  router.back();
};
</script>

<template>
  <div style="width: 100%;height: 100%;">
<!--    <div class="flex-center" style="position: absolute;right:0;width: 1rem;height: 1rem;z-index: 3000;" @click="close" >
      <i style="font-size: .45rem;" class="fa-sharp fa-regular fa-circle-xmark"></i>
    </div>-->
  <ViewImportByPath :path="'/cashier/deposit/topay/'+route.query.type" />
  </div>
</template>

<style scoped lang="scss">

</style>