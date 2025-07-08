
<template>
  <component v-model="data" :is="child" :props="params.props" ></component>
</template>

<script setup>

// 外部传入参数
import {view_get_by_path} from "@/view.js";

const params = defineProps({modelValue: null,path:null,props:null,});

const data=ref()
const emit = defineEmits(['update:modelValue', 'destroy'])
// 监听对话框隐藏时的逻辑 因为时通过pop弹出需要发起注销事件
watch(data, (newVal) => {
  emit('update:modelValue',newVal)
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(data.value)) {
        data.value = newVal;
      }
    }
);
onBeforeMount(()=>{
  data.value = params.modelValue;
})

const child = ref();
/**
 最终解析为
 /src/view + 传入地址 + .vue
 /src/view + 传入地址 + /index.vue
 */
onBeforeMount(async () => {
  let proxy = view_get_by_path(params.path)
  if(proxy){
    proxy().then(view=>{
      child.value = markRaw(view.default);
    })
  }else {
    child.value = markRaw(defineComponent(
        {
          template:`<div class="path_not_found"></div>`
        }
    ));
  }
});
</script>
