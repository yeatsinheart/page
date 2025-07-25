<script setup>
// 外部传入参数
import NormalPageLayout from "@/view/layout/normal-page-layout.vue";
import ColorEditor from "@/view/color-editor.vue";
const params = defineProps({props: null,});
const action = ref()
</script>

<template>
  <NormalPageLayout>
    <template #header>Figma 插件</template>
    <template #action>

      <div class="mb-4">
        <el-button type="primary" round @click="action='color-edit'">上传颜色</el-button>
        <el-button type="warning" round>清空颜色</el-button>
        <el-button round>Round</el-button>
        <el-button type="success" round>Success</el-button>
        <el-button type="info" round>Info</el-button>
        <el-button type="danger" round>Danger</el-button>
      </div>
        </template>
    <template #main>
        多语言的时候，宽度肯定就有变化，所以设计图中也不能<br/>
      创建组件[页面，容器，按钮 输入框] 按照创建产品组件
      <color-editor v-if="action === 'color-edit'"/>
    </template>
    <template #footer></template>
  </NormalPageLayout>
</template>

<style lang="scss" scoped>

</style>