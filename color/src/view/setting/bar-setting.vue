<script setup>

import {appStore} from "@/store/app.js";
import ColorPicker from "@/view/base/color-picker.vue";
import ContainerBase from "@/view/base/container-base.vue";
</script>

<template>
  <div>
    bar:
    <div class="flex">
      <ContainerBase v-model="appStore().container.bar">通用bar</ContainerBase>
      <ContainerBase v-model="appStore().container.bar_top">头部</ContainerBase>
      <ContainerBase v-model="appStore().container.bar_bottom">底部</ContainerBase>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>