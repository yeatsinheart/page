<!--根据实际地址引用页面-->
<template>
<!-- 需要监听 destroy
最大宽度6.5rem class="flex-center"
-->
<!-- 遮罩层 -->
  <div class="flex-center" style="height:100%;background: var(--mask);">
    <!--  窗体  -->
    <div  style="height: 100%;flex-direction: column;position: relative">
      <div class="flex-center" style="position: absolute;right:0;width: 1rem;height: 1rem;z-index: 3000;" @click="notifyParent" >
        <i style="font-size: .45rem;" class="fa-sharp fa-regular fa-circle-xmark"></i>
      </div>
      <div style="height:100%;background-color:var(--page);overflow-y: auto;">
<!-- 内部内容过高 可以滚动 @destroy="notifyParent"-->
        <component :is="props.async_component" :props="params" ></component>
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
//const params = toRef(data.props?? {}, "params");
const params = computed(() => data.props?.params ?? {});
</script>
