<template>
  展示页面
</template>

<script setup>
// 解析 URL 并存储邀请码
const urlParams = new URLSearchParams(window.location.search);
const key = urlParams.get("key");
if (key) {
  console.log("页面key:", key);
}
</script>

<style scoped lang="scss">
</style>
