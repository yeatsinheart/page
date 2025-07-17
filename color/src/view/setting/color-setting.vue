<script setup>

import {appStore} from "@/store/app.js";
import ColorPicker from "@/view/base/color-picker.vue";
import ColorBase from "@/view/base/color-base.vue";
</script>

<template>
  <ColorBase  v-model="appStore().colors.theme">主配色</ColorBase>
  <ColorBase  v-model="appStore().colors.color1">配色1</ColorBase>
  <ColorBase  v-model="appStore().colors.color2">配色2</ColorBase>
  <ColorBase  v-model="appStore().colors.color3">配色3</ColorBase>
</template>

<style scoped lang="scss">

</style>