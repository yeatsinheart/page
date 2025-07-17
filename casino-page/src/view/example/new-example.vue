<script setup>
// 外部传入参数
const data = defineProps({props:null,});
const form=ref({dir:'/'});
</script>

<template>
  <el-form :model="form" label-width="auto" style="max-width: 600px">
    <el-form-item label="页面key" >
      <el-input v-model="form.key" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="文件夹路径" >
      <el-input v-model="form.dir" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="标题" >
      <el-input v-model="form.title" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="描述" >
      <el-input v-model="form.txt" type="textarea"
                :rows="3" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="参数" >
      <el-input v-model="form.params" autocomplete="off"></el-input>
    </el-form-item>
  </el-form>

  <div style="text-align:center">
    <el-button type="primary">确 定</el-button>
  </div>
</template>

<style scoped lang="scss">

</style>