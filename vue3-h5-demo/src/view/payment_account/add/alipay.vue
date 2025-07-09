<script setup>
import {ApiRequest} from "@/api/index.js";
const form = ref({})
const params = defineProps({props:null})
const emit = defineEmits(["destroy"])
function onSubmit() {
  ApiRequest._pK9ZjX3Y({paymentMethodKey:params.props.paymentMethodKey,detail:form.value}).then(response => {
    if(response){
      emit("destroy");
      params.props.success=true
    }
  })
}
onBeforeMount(()=>{
})
</script>
<template>
  <!-- 添加银行卡表单 -->
  <van-form @submit="onSubmit">
    <van-field v-model="form.name" label="支付宝账号姓名" required placeholder="请输入支付宝账号姓名" autocomplete="one-time-code"/>
    <van-field v-model="form.cardNumber" label="支付宝账号" type="digit" required placeholder="支付宝账号"  autocomplete="one-time-code"/>
    <div style="margin-top: .2rem">
      <van-button block type="primary" size="small" round native-type="submit">绑定支付宝</van-button>
    </div>
  </van-form>
</template>

<style scoped lang="scss">

:deep(.van-field__label) {
  width: initial !important;
}
</style>