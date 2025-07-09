<script setup>
const emit = defineEmits(['update:modelValue'])
const params = defineProps({modelValue: null,limit:1,fileTypePrefix:"image/"})

const fileCount=ref(1)
const fileList = ref([])
const urls = ref([])
watch(urls.value, (newVal) => {
  emit('update:modelValue', newVal);
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (newVal !== urls.value) {
        urls.value = newVal;
        fileList.value = newVal.value.map(url => ({ url }))
      }
    }
);

onBeforeMount(()=>{
  urls.value=params.modelValue||[];
  fileList.value = urls.value.map(url => ({ url }))
  fileCount.value=params.limit||1;
})
import {ApiRequest} from "@/api/index.js";

// 自定义上传行为，完全取代默认的上传逻辑。接收一个包含文件和其他信息的对象，允许你自己定义上传过程。
const handleUpload = ( options) => {
  const {file} = options;
  ApiRequest._L6lduTB9(file).then(arr=>{
    urls.value.push(arr[0])
    file.url=arr[0]
  });
};
const handleBeforeDelete = ( file, detail) => {
  urls.value.splice(detail.index, 1);
  return true; // 允许删除
};
</script>

<template>
  <van-uploader v-model="fileList" :multiple="fileCount>1" :max-count="fileCount"
                :before-delete="handleBeforeDelete"
                :after-read="handleUpload" />

</template>

<style scoped lang="scss">

::v-deep(.van-cell){
  background: var(--bg)!important;
}
::v-deep(.van-cell-group){
  background: var(--bg)!important;
}
::v-deep(.van-uploader__upload){
  background-color: var(--bg)!important;
  border:1px dashed var(--main);
}
::v-deep(.van-uploader__upload-icon){
  color: var(--f3);
}
</style>