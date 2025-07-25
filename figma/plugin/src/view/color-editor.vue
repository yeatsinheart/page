<script setup>

import VariableTable from "@/view/variable-table.vue";
import JsonUpload from "@/view/json-upload.vue";
import {hexToRgba, parseRgbaLike, parseRgbLike} from '@/view/color-util.js'

const params = defineProps({props: null,});
const data = ref({collectionName: 'colors', modes: ['demo-light', 'demo-dark']});
const input = ref('')
const error = ref('');
const prettyJson = ref('');


watch(input, (newVal) => {
  try {
    const json = JSON.parse(newVal);
    for (let key in json) {
      let value = json[key];
      if (!value) continue;

      if (typeof value === 'string') {
        let hex = value.trim();
        if (!value) continue;
        let config = {};
        for (const mode of data.value.modes) {
          config[mode] = getRgbaFromStr(hex);
        }
        json[key] = config; // 👈 替换成新对象
      } else if (typeof value === 'object' && !Array.isArray(value)) {
        let config = {};
        for (const mode of data.value.modes) {
          config[mode] = getRgbaFromStr(value[mode]);
        }
        json[key] = config;
      } else {
        console.log(`${key} 是其他类型:`, value);
      }
    }
    console.log(json);
    window.parent.postMessage({pluginMessage: {type: 'import-json', json}}, '*');
  } catch (err) {
    console.log(err);
  }
});

function getRgbaFromStr(hex) {
  let rgba = null;
  if (hex.startsWith('#')) {
    rgba = hexToRgba(hex);
  } else if (hex.startsWith('rgb')) {
    rgba = parseRgbLike(hex);
  } else if (hex.startsWith('rgba')) {
    rgba = parseRgbaLike(hex);
  }
  return rgba;
}

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

function downloadJSONExample(data, filename = 'data.json') {
  // 所有mode模式
  // 指定mode模式
  data = {
    "color1": "#fff", "color2:": "#af3333", "color3": "rgb(234,234,234)", "color4": "rgba(0,0,0,.5)",
    "color5": {"demo-light": "#fff", "demo-dark": "#000"}
  };
  const blob = new Blob([JSON.stringify(data, null, 2)], {type: 'application/json'});
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}
</script>

<template>
  颜色上传后，会覆盖已有变量，同时覆盖颜色样式 <br/>
  清空颜色会导致已有绑定消失<br/>
  颜色：
  <el-input
    v-model="data.collectionName"
    placeholder="Please input"
    style="max-width: 600px"
  >
    <template #prepend>集合名</template>
  </el-input>
  <!-- :trigger="trigger" 'Enter' \| 'Space' -->
  <el-input-tag v-model="data.modes" draggable placeholder="Please input" tag-effect="dark" tag-type="primary">
    <template #prefix>
      <el-icon>
        <ElementPlus/>
      </el-icon>
      模块
    </template>
  </el-input-tag>
  <el-button round type="success" @click="downloadJSONExample">模版下载</el-button>
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
    v-model="input" :rows="10"
    placeholder="Please input"
    style="width: 100%;"
    type="textarea"
    @input="validateJson"
  />
  <div v-if="error" style="color: red;">{{ error }}</div>
  覆盖变量
  <el-button v-if="!error" round type="danger">上传</el-button>
  <VariableTable/>
  不受影响变量
  <VariableTable/>
</template>

<style lang="scss" scoped>

</style>