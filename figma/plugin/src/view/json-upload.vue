<script setup>
import {ElMessage} from "element-plus";

const uploadRef = ref(null);

const emit = defineEmits(['update:modelValue'])
const params = defineProps({modelValue: null,limit:1,fileTypePrefix:"image/"})

const src=ref()
// 监听 src 的变化
watch(src, (newVal) => {
  emit('update:modelValue', newVal);
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
  (newVal) => {
    if (newVal !== src.value) {
      src.value = newVal;
    }
  }
);
onBeforeMount(()=>{
  src.value=params.modelValue||"";
})

// 上传前的验证（可选）
const beforeUpload = (file) => {
  return new Promise((resolve, reject) => {
  // const isJson = file.type.endWith(".json");
  //
  // if (!isJson) {
  //   this.$message.error('只能上传Json文件');
  // }

  const isSmallEnough = file.size / 1024 / 1024 < 1; // 最大 1MB
  if (!isSmallEnough) {
    ElMessage.error('大小不能超过 5MB');
    src.value = '❌ 大小不能超过 1MB';
    reject();
  }
    // 读取文件内容
    const reader = new FileReader();
    reader.onload = () => {
      try {
        const json = JSON.parse(reader.result);
        console.log('✅ 解析成功:', json);
        src.value = reader.result;
        resolve(file); // ✅ 允许上传
      } catch (e) {
        console.error('❌ 解析失败:', e);
        src.value = '❌ 解析失败:'+e.message;
        ElMessage.error('不是有效的 JSON 格式');
        reject();
      }
    };
    reader.onerror = () => {
      ElMessage.error('读取文件失败');
      reject();
    };
    reader.readAsText(file);

  });
};

// 自定义上传行为，完全取代默认的上传逻辑。接收一个包含文件和其他信息的对象，允许你自己定义上传过程。
const handleUpload = ( options) => {
  //console.log(options)
  //const {file, onProgress, onSuccess, onError} = options;

  //onSuccess({data: {url: arr[0]}}, file);
  //onSuccess(response, file); // 通知上传成功
  //throw new Error('Upload failed');
  //onError(err); // 通知上传失败
};

// 文件上传成功后的回调
const handleSuccess = (response, uploadFile, uploadFiles) => {
  // 假设服务器返回图片 URL
  console.log(response)
  if (response && response.data) {
    // 将返回的 URL 保存到对应项目的结果中
    src.value = response.data.url;
  }
};

// 文件上传状态变化时的回调（可选）
const handleChange = (file, fileList) => {
  // ${key}
};
// 处理文件超出限制的情况
const handleExceed = (files) => {
  // 清空文件列表
  uploadRef.value.fileList = [];//// 强制清空 fileList
  uploadRef.value.clearFiles();//// 清空文件
  // 获取要上传的第一个文件，并手动设置它的 uid 和上传
  const file = files[0]; // 获取第一个超出的文件
  file.uid = genFileId(); // 生成唯一的文件 ID
  uploadRef.value.handleStart(file); // 手动启动上传
  uploadRef.value.submit(); // 手动启动上传
};
function genFileId() {
  return 'file_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
}

</script>

<template>

  <el-form-item label=" " >
    <!--:auto-upload="false" -->
      <el-upload style="padding: 4px;" ref="uploadRef" :show-file-list="false" :limit="params.limit"
                 :on-exceed="(files)=>handleExceed(files)"
                 :on-change="(file, fileList)=>handleChange(file, fileList)"
                 :before-upload="(file)=>beforeUpload(file)"
                 :http-request="(options)=>handleUpload(options)"
                 :on-success="(response, uploadFile, uploadFiles)=>handleSuccess(response, uploadFile, uploadFiles)">
      <div class="flex-center" style="flex-direction: column">
        <div class="flex-center"
             style="border: 1px dashed var(--main);width: 128px;height:50px;color: var(--main);">
          +
        </div>
      </div>
    </el-upload>
  </el-form-item>
</template>

<style scoped lang="scss">

</style>