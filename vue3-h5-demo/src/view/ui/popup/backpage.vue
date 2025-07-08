<!--根据实际地址引用页面-->
<template>
<!-- 需要监听 destroy
最大宽度6.5rem class="flex-center"
-->
<!-- 遮罩层 -->
  <div class="flex-center" style="width:100%;height:100%;background: rgba(0,0,0,.5);">
    <!--  窗体  -->
    <div  style="width:100%;height: 100%;flex-direction: column;position: relative">
      <div class="flex-center" style="position: absolute;left: .1rem;top:.1rem;">
        <i @click="notifyParent" style="font-size: .3rem;color: var(--main)" class="fa-solid fa-angle-left"></i>
      </div>
      <div style="width:100%;height:100%;background-color:var(--bg);overflow-y: auto;">
<!-- 内部内容过高 可以滚动-->
        <component :is="props.async_component" :props="params" @destroy="notifyParent" style="width: 100%;height:100%;overflow:auto;"></component>
      </div>

    </div>

  </div>

</template>

<script setup>
const emit = defineEmits();
const notifyParent = () => {
  emit('destroy', 'Hello from child!');};
// 外部传入参数
const data = defineProps({
  props:null,
});

// ✅ 让 props.params 变成响应式
const params = toRef(data.props, "params");
</script>
