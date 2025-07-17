<script setup>

import {appStore} from "@/store/app.js";
import ColorPicker from "@/view/base/color-picker.vue";
</script>

<template>
  <div>
    字色
    <div class="flex">
      <ColorPicker v-model="appStore().container.font.title">标题</ColorPicker>
      <ColorPicker v-model="appStore().container.font.sub_title">子标题</ColorPicker>
      <ColorPicker v-model="appStore().container.font.normal">通用</ColorPicker>
      <ColorPicker v-model="appStore().container.font.placeholder">说明</ColorPicker>
      <ColorPicker v-model="appStore().container.font.disabled">备案</ColorPicker>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>