<script setup>

const predefineColors = ref([
    /*白色*/
  '#f8f9fa','#e9ecef','#dee2e6','#ced4da','#adb5bd','#6c757d','#495057','#343a40','#212529',
    /*黑色*/

    /*红色*/
    /*橙色*/
    /*黄色*/
    /*绿色*/
    /*蓝色*/
    /*青色*/
    /*紫色*/
    /*金色*/

  '#ff4500',
  '#ff8c00',
  '#ffd700',
  '#90ee90',
  '#00ced1',
  '#1e90ff',
  '#c71585',
  'rgba(255, 69, 0, 0.68)',
  'rgb(255, 120, 0)',
  'hsv(51, 100, 98)',
  'hsva(120, 40, 94, 0.5)',
  'hsl(181, 100%, 37%)',
  'hsla(209, 100%, 56%, 0.73)',
  '#c7158577',
])
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
      <el-color-picker v-model="color" show-alpha color-format="hex" size="small"
                       :predefine="predefineColors"
                       @active-change="changed" /><br>
    </div>
  </div>

</template>

<style scoped lang="scss">

</style>