<script setup>

import VariableTable from "@/view/variable-table.vue";

const params = defineProps({props: null,});
const input = ref('')
const error = ref('');
const prettyJson = ref('');

function validateJson() {
  try {
    const parsed = JSON.parse(input.value);
    prettyJson.value = JSON.stringify(parsed, null, 2); // 缩进2空格
    error.value = '';
  } catch (e) {
    prettyJson.value = '';
    error.value = e.message;
  }
}
</script>

<template>
  颜色上传后，会覆盖已有变量，同时覆盖颜色样式 <br/>
  清空颜色会导致已有绑定消失<br/>
  颜色：
  集合名 color <input type="text" placeholder="搜索内容" /> <br/>
  模块名 dark light 新增删除修改
  <br/>
  颜色值按照 Hex 模式：#ffffff<br/>

  <textarea
    v-model="input" style="width: 100%;"
    @input="validateJson"
    placeholder="请输入 JSON 数据"
    rows="10"
    cols="50"
  ></textarea>

  <div v-if="error" style="color: red;">{{ error }}</div>

    覆盖变量
  <VariableTable/>
  不受影响变量
  <VariableTable/>
</template>

<style scoped lang="scss">

</style>