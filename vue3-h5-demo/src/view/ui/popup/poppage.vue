<!--根据实际地址引用页面-->
<template>
  <!-- 需要监听 destroy -->
<!--  closeable  -->
  <van-popup
    v-model:show="showBottom"
    :close-on-click-overlay="false"
    @click-close-icon="close"
    round
    position="bottom"
    :style="{ height: '90%',backgroundColor:'var(--bg)'}"
  >
    <div class="flex-center" style="position: fixed;right:.01rem;width: 1rem;height: 1rem;z-index:3000;" @click="close()">
      <van-icon name="close" class="custom-close" style="font-size: .45rem;"/>
    </div>

    <component
      :is="props.async_component"
      :props="params"
    ></component>
  </van-popup>
</template>

<script setup>
const showBottom = ref(false);
const emit = defineEmits();

const close = () => {
  showBottom.value = false;
  emit('destroy', 'Hello from child!');
  // setTimeout(() => {
  //   mitt.emit("closehandleClick");
  // }, 300);
};
const data = defineProps({
  props: null,
});

// ✅ 让 props.params 变成响应式
const params = toRef(data.props, "params");
onMounted(() => {
  setTimeout(() => {
    showBottom.value = true;
  }, 100);
});
</script>
<style lang="scss" scoped>
:deep(.van-popup__close-icon){
  position: absolute!important;
  //top:1.45rem!important;
  right:.45rem!important;
}
</style>
