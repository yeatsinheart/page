<script setup>
import ColorPicker from "./base/color-picker.vue";

import {colorStore} from "@/view/color/base/color.js";
import ContainerBase from "./base/container-base.vue";
import FontSetting from "./setting/font-setting.vue";
import ColorSetting from "./setting/color-setting.vue";
import Show from "./template/show.vue";
import BarSetting from "./setting/bar-setting.vue";
import Colors from "./template/colors.vue";
import {ref} from "vue";

const activeName = ref('案例')
const handleClick = (tab, event) => {
  //console.log(tab, event)
}
</script>

<template>
  <div>
      <el-tabs v-model="activeName" class="demo-tabs" @tab-click="handleClick">
        <el-tab-pane label="案例" name="案例"><Show/></el-tab-pane>
        <el-tab-pane label="色阶" name="色阶">
          颜色过渡工具：两个颜色之间生成一系列中间色（色阶）
          <Colors/></el-tab-pane>
        <el-tab-pane label="调试" name="调试">


          <div class="flex">
            <ColorPicker v-model="colorStore().container.browser">浏览器</ColorPicker>
            <ColorPicker v-model="colorStore().container.page">页面</ColorPicker>
          </div>

          <div class="flex">
            <ColorPicker v-model="colorStore().container.border">通用边框</ColorPicker>
            <ColorPicker v-model="colorStore().container.shadow">通用阴影</ColorPicker>
            <ColorPicker v-model="colorStore().container.mask">通用mask</ColorPicker>
          </div>
          <br/>
          <FontSetting/>
          <br/>
          容器
          <br/>
          <ContainerBase v-model="colorStore().container.reverse">reverse</ContainerBase>
          <ContainerBase v-model="colorStore().container.gap">gap</ContainerBase>
          <br/>
          <ContainerBase v-model="colorStore().container.notify">notify</ContainerBase>
          <br/>
          <ContainerBase v-model="colorStore().container.card">card</ContainerBase>
          <ContainerBase v-model="colorStore().container.div1">div1</ContainerBase>
          <ContainerBase v-model="colorStore().container.div2">div2</ContainerBase>
          <br/>

          <br/>
          <BarSetting/>
          <br/>
          配色
          <br/>
          <ColorSetting/>
        </el-tab-pane>
      </el-tabs>

  </div>
</template>

<style scoped lang="scss">

</style>