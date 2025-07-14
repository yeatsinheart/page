<script setup>

const color = ref()
function changed(value){
  color.value = value
}
const params = defineProps({modelValue:null})
const emit = defineEmits(['update:modelValue'])
watch(color, (newVal) => {
  emit('update:modelValue',newVal)
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(color.value)) {
        color.value = newVal;
      }
    }
);
onBeforeMount(()=>{
  color.value = params.modelValue;
})

</script>

<template>
  <div class="flex">
    <div style="min-width: 60px;text-align: right;">
      <slot></slot>:
    </div>
    <div class="flex" >
      <input style="width:80px!important;" v-model="color">
      <el-color-picker v-model="color" show-alpha color-format="hex" size="small" @active-change="changed" ></el-color-picker><br>
    </div>
  </div>

</template>

<style scoped lang="scss">

</style>