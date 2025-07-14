<script setup>
import ColorPicker from "@/view/base/color-picker.vue";
import {appStore} from "@/store/app.js";
import ContainerBase from "@/view/base/container-base.vue";
import FontSetting from "@/view/setting/font-setting.vue";
import ColorSetting from "@/view/setting/color-setting.vue";
import Show from "@/view/template/show.vue";
import BarSetting from "@/view/setting/bar-setting.vue";
</script>

<template>
  <div >
    <div class="flex">
      <ColorPicker v-model="appStore().container.browser">浏览器</ColorPicker>
      <ColorPicker v-model="appStore().container.page">页面</ColorPicker>
    </div>

    <div class="flex">
    <ColorPicker v-model="appStore().container.border">通用边框</ColorPicker>
    <ColorPicker v-model="appStore().container.shadow">通用阴影</ColorPicker>
    <ColorPicker v-model="appStore().container.mask">通用mask</ColorPicker>
    </div>
    <br/>
    <FontSetting/>
    <br/>
    容器
    <br/>
      <ContainerBase v-model="appStore().container.reverse">reverse</ContainerBase>
      <ContainerBase v-model="appStore().container.gap">gap</ContainerBase>
    <br/>
      <ContainerBase v-model="appStore().container.notify">notify</ContainerBase>
    <br/>
      <ContainerBase v-model="appStore().container.card">card</ContainerBase>
      <ContainerBase v-model="appStore().container.div1">div1</ContainerBase>
      <ContainerBase v-model="appStore().container.div2">div2</ContainerBase>
    <br/>

    <br/>
    <BarSetting/>
    <br/>
    配色
    <br/>
    <ColorSetting/>
    <br/>
    <Show/>
  </div>
</template>

<style scoped lang="scss">

</style>