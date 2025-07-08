<!--根据实际地址引用页面-->

<template>
  <div class="new-page" style="background: rgba(0,0,0,.3)">
    <component :is="props.async_component" :props="params" @destroy="notifyParent"></component>
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
/*
// 实际界面
let loadfunction = computed(() => {
  console.log(this)
  return defineAsyncComponent({
    // 异步加载组件
    loader: () => import( /!* @vite-ignore *!/ `./${data.path}.vue`),
    // 设置加载状态的组件（可选）
    loadingComponent: {
      template: '<p>Loading...</p>'
    },
    // 设置错误状态的组件（可选）
    errorComponent: {
      template: '<p>Failed to load component.</p>'
    },
    // 自定义错误处理函数
    onError(error, retry, fail, attempts) {
      if (attempts <= 3) {
        // 在 3 次重试内，继续尝试加载
        retry();
      } else {
        // 超过 3 次重试，放弃加载，显示错误组件
        fail();
      }
    }
  })
});*/
</script>
