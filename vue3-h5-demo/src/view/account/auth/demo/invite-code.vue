<script setup>

import {userStore} from "@/config/store/user.js";
const userState = userStore()

const props = defineProps({modelValue: null})
const emit = defineEmits(["update:modelValue"]);

const inviteCode = ref("")
/*
// 监听 src 的变化
watch(inviteCode, (newVal) => {
  emit('update:modelValue', newVal);
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue, (newVal) => {
  if (newVal !== inviteCode.value) {
    inviteCode.value = newVal;
  }
});*/

onBeforeMount(() => {
  inviteCode.value = userStore().inviteCode || "";
})
function invite_code_check(val){
  /*if(!userState.loginConfig?.invite?.required){
    return ;
  }
  const trimmedVal = val.trim(); // 去除前后空格
  if (!trimmedVal) {
    return t("请输入邀请码");
  }*/
}
</script>

<template>
  <!-- 邀请码 v-show="userState.loginConfig?.invite?.show"-->
  <van-field
      v-model="inviteCode" :placeholder="$t('请输入邀请码')"
             :rules="[{validator: invite_code_check }]"
             name="邀请码" :required="userState.loginConfig?.invite?.required">
  </van-field>
</template>

<style lang="scss" scoped>

</style>