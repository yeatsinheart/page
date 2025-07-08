<!--根据实际地址引用页面-->
<template>
<!-- 需要监听 destroy -->
    <component :is="props.async_component" :props="params" @destroy="notifyParent"></component>
</template>

<script setup>
const emit = defineEmits();
const notifyParent = () => {
   emit('destroy', 'Hello from child!');
};
// 外部传入参数
const data = defineProps({
  props:null,
});

// ✅ 让 props.params 变成响应式
const params = toRef(data.props, "params");
</script>
