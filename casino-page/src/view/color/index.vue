<script setup>
import Setting from './setting.vue'
import Demo from './demo.vue'

// 外部传入参数
const data = defineProps({props:null,});
</script>

<template>
  <!-- [horizontal-offset] [vertical-offset] [blur-radius] [spread-radius] [color] [inset];
  box-shadow: [水平偏移] [垂直偏移] [模糊距离] [扩展距离] [颜色] [inset]; -->
    <Demo style="width: 475px;height:100%;float: left;box-shadow: 1px 0 10px 10px rgba(65,69,73,0.25);"/>
    <Setting style="height:100%;width:calc(100% - 475px);padding-left: 10px;float: right;overflow-x: auto;overflow-y: auto;"/>
</template>

<style scoped lang="scss">

</style>
