<script setup>

import {colorStore} from "@/view/color/base/color.js";
import ColorPicker from "@/view/color/base/color-picker.vue";
import ColorBase from "@/view/color/base/color-base.vue";
</script>

<template>
  <ColorBase  v-model="colorStore().colors.theme">主配色</ColorBase>
  <ColorBase  v-model="colorStore().colors.color1">配色1</ColorBase>
  <ColorBase  v-model="colorStore().colors.color2">配色2</ColorBase>
  <ColorBase  v-model="colorStore().colors.color3">配色3</ColorBase>
</template>

<style scoped lang="scss">

</style>