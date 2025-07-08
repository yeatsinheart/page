<!--根据实际地址引用页面-->
<template>
  <div class="color-choose">
    <div @click="choose('blue_black')"
         class="flex-center"  style="height:.7rem;padding:.1rem 0;color: var(--f4);">
        蓝黑
    </div>

    <div @click="choose('red_white')"
        class="flex-center"  style="height:.7rem;padding:.1rem 0;color: var(--f4);">
      粉白
    </div>
  </div>

</template>

<script setup>
import {appStore} from "@/config/store/app.js";

const appState = appStore();
const choose = (color_version) => {
  localStorage.setItem("color_version", color_version);
  document.getElementById('color-version').setAttribute('href', '/api/style.css?'+color_version)
}
</script>
<style scoped>

.color-choose>div:not(:last-child){
  border-bottom:.01rem solid var(--f4);
}
</style>
