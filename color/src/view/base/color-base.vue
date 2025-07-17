<script setup>
import ColorPicker from "./color-picker.vue";
import {fontColor} from "@/view/base/color.js";

const container = ref({color:null,font:null})

// 监听具体属性 config.x：
watch(() => container.value.color, (newVal, oldVal) => {
  if(newVal!==oldVal){
    container.value.font=fontColor(newVal)
  }
});

const params = defineProps({modelValue: null})
const emit = defineEmits(['update:modelValue'])
watch(container, (newVal) => {
  emit('update:modelValue', newVal)
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(container.value)) {
        container.value = newVal;
      }
    }
);
onBeforeMount(() => {
  container.value = params.modelValue;
})

</script>

<template>
  <div style="width:200px;display: inline-block;box-shadow: 2px 0 10px 0 rgba(0, 0, 0, .1);">
    <div style="width: 70px">
      <slot></slot>
      :
    </div>
    <ColorPicker v-model="container.color">颜色</ColorPicker>
    <ColorPicker v-model="container.font">字色</ColorPicker>
    <ColorPicker v-model="container.border">边框</ColorPicker>
    <ColorPicker v-model="container.shadow">阴影</ColorPicker>
  </div>
</template>

<style lang="scss" scoped>

</style>