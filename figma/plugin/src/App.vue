<script setup>
import PopRoot from "@/init/pop.js";
onMounted(()=>{
  const content = document.getElementById('app');
  const height = content.offsetHeight + 40; // +padding
  const width = content.offsetWidth + 40; // 可根据需要调整
  parent.postMessage({ pluginMessage: { type: 'resize', width, height } }, '*');
})
</script>

<template>
  <router-view/>
  <PopRoot/><!--全局弹出⏏️-->
</template>

<style scoped lang="scss">

</style>