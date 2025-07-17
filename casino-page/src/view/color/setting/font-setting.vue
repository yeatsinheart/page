<script setup>

import {colorStore} from "@/view/color/base/color.js";
import {appStore} from "@/store/app.js";
import ColorPicker from "@/view/color/base/color-picker.vue";
</script>

<template>
  <div>
    字色
    <div class="flex">
      <ColorPicker v-model="colorStore().container.font.title">标题</ColorPicker>
      <ColorPicker v-model="colorStore().container.font.sub_title">子标题</ColorPicker>
      <ColorPicker v-model="colorStore().container.font.normal">通用</ColorPicker>
      <ColorPicker v-model="colorStore().container.font.placeholder">说明</ColorPicker>
      <ColorPicker v-model="colorStore().container.font.disabled">备案</ColorPicker>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>