<!--根据实际地址引用页面-->
<template>
<!-- 需要监听 destroy
最大宽度6.5rem class="flex-center"
-->
<!-- 遮罩层 -->
  <div class="flex-center" style="height:100%;background: var(--mask);">
    <!--  窗体  -->
    <div class="flex-center" style="width:6.5rem;max-height: calc(100% - .5rem);flex-direction: column;">
      <div style="width:100%;background-color:var(--page);border:.01333rem solid var(--border);border-radius:.2rem;padding:.1rem;overflow-y: auto;">
<!-- 内部内容过高 可以滚动-->
        <component :is="props.async_component" :props="params" @destroy="notifyParent"/>
      </div>
      <div class="flex-center" style="height: 1rem;">
        <i @click="notifyParent" style="font-size: .5rem;color: #fff" class="fa-sharp fa-regular fa-circle-xmark"></i>
      </div>
    </div>
  </div>

</template>

<script setup>
const emit = defineEmits(["destroy"]);
const notifyParent = () => {emit('destroy');};
// 外部传入参数
const data = defineProps({props:null,});

// ✅ 让 props.params 变成响应式
const params = toRef(data.props, "params");
</script>
