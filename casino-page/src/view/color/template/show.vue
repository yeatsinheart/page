<script setup>

let back_option=['黑','白'];
let main_option=['蓝','珊瑚红'];
let bar_option=['黑','白'];

const bg = ref()
const theme = ref()
const bar = ref()

watch(bg, (newVal) => {
});

watch(theme, (newVal) => {
});

watch(bar, (newVal) => {
});
</script>

<template>
  <div style="margin-right: 15px;">
    底色
    <el-radio-group v-model="bg" size="small" >
      <el-radio-button v-for="choice in back_option" :value="choice" :key="choice">{{choice}}</el-radio-button>
    </el-radio-group>
  </div>

  <div>
    主色
    <el-radio-group v-model="theme" size="small" >
      <el-radio-button v-for="choice in main_option" :value="choice" :key="choice">{{choice}}</el-radio-button>
    </el-radio-group>
  </div>

  <div>
    导航
    <el-radio-group v-model="bar" size="small" >
      <el-radio-button v-for="choice in bar_option" :value="choice" :key="choice">{{choice}}</el-radio-button>
    </el-radio-group>
  </div>
</template>

<style scoped lang="scss">

</style>