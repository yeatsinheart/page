<!--根据实际地址引用页面-->

<template>
  <div class="new-page" style="background: var(--mask)">
    <!-- 需要监听 destroy  @destroy="notifyParent"-->
    <component :is="props.async_component" :props="params"></component>
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
