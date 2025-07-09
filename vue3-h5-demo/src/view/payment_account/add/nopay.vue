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
    <van-field v-model="form.cardNumber" label="NoPay地址" type="digit" required placeholder="NoPay地址"  autocomplete="one-time-code"/>
    <div style="margin-top: .2rem">
      <van-button block type="primary" size="small" round native-type="submit">绑定NoPay</van-button>
    </div>
  </van-form>
</template>

<style scoped lang="scss">

:deep(.van-field__label) {
  width: initial !important;
}
</style>