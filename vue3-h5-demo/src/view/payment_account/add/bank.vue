<script setup>
import {ApiRequest} from "@/api/index.js";
import {paymentAccountStore} from "@/store/paymentAccount.js";

const form = ref({})
const params = defineProps({props: null})
const emit = defineEmits(["destroy"])

function onSubmit() {
  ApiRequest._pK9ZjX3Y({paymentMethodKey: params.props.paymentMethodKey, detail: form.value}).then(response => {
    if (response) {
      emit("destroy");
      paymentAccountStore().init();//重新获取新的
    }
  })
}

onBeforeMount(() => {
})
</script>
<template>
  <!-- 添加银行卡表单 -->
  <van-form @submit="onSubmit">
    <van-field v-model="form.name" label="持卡人姓名" required placeholder="请输入持卡人姓名"
               autocomplete="one-time-code"/>
    <van-field v-model="form.cardNumber" label="银行卡号" type="digit" required placeholder="请输入银行卡号"
               autocomplete="one-time-code"/>
    <van-field v-model="form.bankName" label="银行名称" required placeholder="请输入银行名称"
               autocomplete="one-time-code"/>
    <van-field v-model="form.branch" label="开户支行" placeholder="请输入开户支行（选填）" autocomplete="one-time-code"/>
    <div style="margin-top: .2rem">
      <van-button block type="primary" size="small" round native-type="submit">绑定银行卡</van-button>
    </div>
  </van-form>
</template>

<style scoped lang="scss">

:deep(.van-field__label) {
  width: initial !important;
}
</style>