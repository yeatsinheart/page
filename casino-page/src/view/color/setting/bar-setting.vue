<script setup>

import {colorStore} from "@/view/color/base/color.js";
import ColorPicker from "@/view/color/base/color-picker.vue";
import ContainerBase from "@/view/color/base/container-base.vue";
</script>

<template>
  <div>
    bar:
    <div class="flex">
      <ContainerBase v-model="colorStore().container.bar">通用bar</ContainerBase>
      <ContainerBase v-model="colorStore().container.bar_top">头部</ContainerBase>
      <ContainerBase v-model="colorStore().container.bar_bottom">底部</ContainerBase>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>