<!--根据实际地址引用页面-->
<template>
  <div class="color-choose">
    <div @click="changeView('wg')"
         class="flex-center"  style="height:.7rem;padding:.1rem 0;color: var(--f4);">
        WG版本
    </div>
  </div>

</template>

<script setup>

const changeView= async (version) => {
  localStorage.setItem("view_version",version)
  window.location.reload();
}
</script>
<style scoped>

.color-choose>div:not(:last-child){
  border-bottom:.01rem solid var(--f4);
}
</style>
