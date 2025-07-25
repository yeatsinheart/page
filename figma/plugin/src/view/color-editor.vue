<script setup>

import VariableTable from "@/view/variable-table.vue";
import JsonUpload from "@/view/json-upload.vue";

const params = defineProps({props: null,});
const data = ref({collectionName:'colors',modes:['light','dark']});
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
  <el-input
    v-model="data.collectionName"
    style="max-width: 600px"
    placeholder="Please input"
  >
    <template #prepend>集合名</template>
  </el-input>
<!-- :trigger="trigger" 'Enter' \| 'Space' -->
  <el-input-tag v-model="data.modes"  draggable placeholder="Please input" tag-type="primary" tag-effect="dark">
    <template #prefix>
      <el-icon><ElementPlus /></el-icon>模块
    </template>
  </el-input-tag>

  颜色值按照 Hex 模式：#ffffff<br/>

  <el-form-item label="上传Json文件">
    <JsonUpload v-model="input">
      <div class="flex-center" style="flex-direction: column">
        <div class="flex-center"
             style="border: 1px dashed var(--main);width: 128px;height:50px;color: var(--main);">
          +
        </div>
      </div>
    </JsonUpload>
  </el-form-item>

上传json文件，或直接粘贴Json到输入框中
  <el-input
    v-model="input" @input="validateJson"
    style="width: 100%;"
    :rows="10"
    type="textarea"
    placeholder="Please input"
  />
  <div v-if="error" style="color: red;">{{ error }}</div>

    覆盖变量
  <VariableTable/>
  不受影响变量
  <VariableTable/>
</template>

<style scoped lang="scss">

</style>