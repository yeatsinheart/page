<script setup>
import {blendColors} from "@/view/base/color.js";
import {ElNotification} from "element-plus";
import ColorPicker from "@/view/base/color-picker.vue";

const from = ref('#000000');
const to = ref('#ffffff');

const step = ref(80);
const colors = computed(() => {
  return blendColors(from.value, to.value,step.value);
})

function copySuccess(msg){
  ElNotification({
    //title: 'Title',
    message: h('i', { style: 'color: teal' }, msg),position: 'bottom-right',duration: 500,
  })
}

function copyText(value) {
  if (navigator.clipboard) {
    navigator.clipboard.writeText(value)
        .then(() => copySuccess('复制成功'));
  } else {
    // fallback for older browsers
    const textarea = document.createElement('textarea');
    textarea.value = value;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    copySuccess('复制成功');
  }
}
</script>

<template>
  <div class="flex">
    <ColorPicker v-model="from">开始颜色</ColorPicker>
    <ColorPicker v-model="to">结束颜色</ColorPicker>
    <el-input-number v-model="step" :min="1"  />
  </div>
  <div >
    <template v-for="color in colors" >
      <div style="display: inline-block;cursor: pointer" @click="copyText(color)">
        <div style="width: 70px;height: 100px;" :style="{backgroundColor:color}"></div>
        <div>{{color}}</div>
      </div>
    </template>
  </div>
</template>

<style scoped lang="scss">

</style>