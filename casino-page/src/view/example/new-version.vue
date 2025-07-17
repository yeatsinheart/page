<script setup>
// 外部传入参数
const data = defineProps({props:null,});
const form=ref({dir:'/'});

onMounted(() => {
  document.addEventListener('paste', handlectrlvEvent)
})
onBeforeUnmount(() => {
  document.removeEventListener('paste', handlectrlvEvent)
})

function handlectrlvEvent (e) {/* 处理粘贴事件 */
  console.log(e.clipboardData.getData("text/plain"))
  let file = e.clipboardData.files[0];
  console.log(file)
  /*let clipboardData = e.clipboardData
  let items = clipboardData.items
  let item = null
  if (items && items.length) {
      for (let i = 0; i < clipboardData.types.length; i++) {
          console.log(clipboardData)
          if (clipboardData.types[i] === 'Files') {
              item = items[i]
              break
          }
      }
  }
  this.$refs.upload.clearFiles();
  this.fileList=[item];
  console.log(this.fileList)*/
  let that = this;
  if (file && file.type.match(/^image\//i)) {
    // 430 932 iphone 14 pro max
    fileResizetoFile(file,  1080, 800,  0.99, function (blob) {
      filetoDataURL(blob,function (data){
        file.url=data;
        that.fileList=[file];
        that.form.example=data;
        that.form.key=that.choosed.key;
      });

    })
  }
}
const fileList=ref([])

function handleRemove(file,fileList){
  this.$refs.upload.clearFiles();
  this.form.example=null;
}
function handleSuccess(response, file, fileList){
  let that = this;
    // 430 932 iphone 14 pro max
    fileResizetoFile(response.file, 1080, 800, 0.99, function (blob) {
      filetoDataURL(blob,function (data){
        /* console.log(data);*/
        that.form.example=data;
        that.form.key=that.choosed.key;
      });

    })
}

</script>

<template>
  
  <el-form :model="form" label-width="auto" style="max-width: 600px">
    <el-form-item label="版本路径" >
      <el-input v-model="form.dir" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="描述" >
      <el-input v-model="form.txt" type="textarea"
                :rows="3" autocomplete="off"></el-input>
    </el-form-item>

    <el-form-item label="缩略图" >
      <!--:auto-upload="false" -->
      <el-upload action="#" ref="upload" :show-file-list="false"
                 :http-request="handleSuccess" 	:multiple="false" :file-list="fileList" :limit="1">
        <div class="flex-center" style="flex-direction: column">
          <img v-if="form.example" :src="form.example" class="avatar" style="height: 50px;"/>
          <div v-else class="flex-center"
               style="border: 1px dashed var(--main);width: 128px;height:50px;color: var(--main);">
            +
          </div>
        </div>
<!--        <i slot="default" class="el-icon-plus"></i>
        <div slot="file" slot-scope="{file}">
          <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
          <span class="el-upload-list__item-actions">
                            &lt;!&ndash;<span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                              <i class="el-icon-zoom-in"></i>
                            </span>
                            <span v-if="!disabled" class="el-upload-list__item-delete" @click="handleDownload(file)">
                              <i class="el-icon-download"></i>
                            </span>&ndash;&gt;
                            <span  class="el-upload-list__item-delete" @click="handleRemove(file,fileList)">
                              <i class="el-icon-delete"></i>
                            </span>
                        </span>
        </div>-->
      </el-upload>
    </el-form-item>
  </el-form>

  <div style="text-align:center">
    <el-button type="primary">确 定</el-button>
  </div>
</template>

<style scoped lang="scss">

</style>