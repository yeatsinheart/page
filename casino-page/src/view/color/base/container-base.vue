<script setup>
import ColorPicker from "./color-picker.vue";
import {fontColor, isWhite} from "@/view/color/base/color.js";

const container = ref({bg:null,font:null,border:null,shadow:null});

// 监听具体属性 config.x：
watch(() => container.value.bg, (newVal, oldVal) => {
  if(newVal!==oldVal){
    if(null!=container.value.font){container.value.font=isWhite(newVal)?'#000000':'#ffffff'}
    if(null!=container.value.border){container.value.border=isWhite(newVal)?'rgba(0, 0, 0, 0.1)':'rgba(255, 255, 255, 0.1)'}
    if(null!=container.value.shadow){container.value.shadow=isWhite(newVal)?'rgba(0, 0, 0, 0.15)':'rgba(255, 255, 255, 0.1)'}
  }
});

const params = defineProps({modelValue:null})
const emit = defineEmits(['update:modelValue'])
watch(container, (newVal) => {
  emit('update:modelValue',newVal)
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(container.value)) {
        container.value = newVal;
      }
    }
);
onBeforeMount(()=>{
  container.value = params.modelValue;
})

</script>

<template>
    <div style="width:200px;display: inline-block;box-shadow: 2px 0 10px 0 rgba(0, 0, 0, .1);">
      <div style="width: 70px;display: inline-block;">
        <slot></slot>:
      </div>
      <ColorPicker v-model="container.bg" >背景</ColorPicker>
      <ColorPicker v-model="container.font">字色</ColorPicker>
      <ColorPicker v-model="container.border">边框</ColorPicker>
      <ColorPicker v-model="container.shadow">阴影</ColorPicker>
    </div>
</template>

<style scoped lang="scss">

</style>