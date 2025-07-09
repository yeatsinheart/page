<template>
  <div style="height: 100%;">
    <div style="height: calc(100% - 1.4rem);padding: .2rem;overflow-y: auto">
      <!-- 标题 -->
      <h2 class="flex-center" style="font-size: .3rem;font-weight: bold;text-align: center;margin-bottom: 15px;">充值到银行卡</h2>

      <!-- 收款银行信息 -->
      <div>
        <van-cell title="收款银行名称" :value="detail.receiver?.bank" />
        <van-cell title="收款账户名" :value="detail.receiver?.name" />
        <van-cell title="收款银行卡号" :value="detail.receiver?.number" />
        <van-cell title="收款金额" :value="detail.amountToPay"/>
      </div>

      <!-- 付款账号信息 -->
      <div v-if="detail.paymentAccountId" style="border: 1px dashed var(--main);">
        <van-cell title="付款账号户名" :value="paymentAccountStore().byId(detail.paymentAccountId)?.name" />
        <van-cell title="付款账号卡号" :value="paymentAccountStore().byId(detail.paymentAccountId)?.number" />
      </div>

      <!-- 上传支付凭证（可选） -->
      <div class="flex-center" style="margin-top: 20px">
        <ImgUpload v-model="order.imgs" :limit="3"/>

        <p class="limit-info" v-if="order.imgs.length<3">上传支付凭证</p>
      </div>
    </div>

    <!-- 待支付状态 -->
    <div class="max-width" style="position: absolute;bottom: 0;" v-if="detail.status==='toPay'">
    <p class="countdown">剩余付款时间：{{ countdown }} </p>
    <van-button type="primary" block @click="iHavePaid()" >我确认已付款</van-button>
    </div>
    <!-- 已支付状态 -->
    <div class="max-width" style="position: absolute;bottom: 0;" v-if="detail.status==='paid'">
      <van-button type="primary" block >已付款待确认</van-button>
    </div>
    <!-- 已超时状态 -->
    <div class="max-width" style="position: absolute;bottom: 0;" v-if="detail.status==='overtime'">
      <van-button type="primary" block >已超时</van-button>
    </div>
  </div>
</template>

<script setup>
import ImgUpload from "@/components/img-upload.vue";
const imgs = ref([]);

const amount = ref("");

import {useRoute} from "vue-router";
import {ApiRequest} from "@/api/index.js";
import {paymentAccountStore} from "@/config/store/paymentAccount.js";
const route = useRoute();

const countdown = ref(0);
const timeGap = ref(0);
function startCountdown(timestamp) {
  // 每秒更新一次倒计时
  const interval = setInterval(function () {
    const now = new Date().getTime(); // 当前时间戳（毫秒）
    const remainingTime = timestamp - now -timeGap.value; // 计算剩余时间
    // 如果时间已过或剩余时间为负值，停止倒计时
    if (remainingTime <= 0) {
      clearInterval(interval);
      detail.value.status = "overtime";
      return;
    }
    // 计算时、分、秒
    const hours = Math.floor(remainingTime / (1000 * 60 * 60)).toString().padStart(2, "0");
    const minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60)).toString().padStart(2, "0");
    const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000).toString().padStart(2, "0");
    // 显示剩余时间（00:00:00 格式）
    countdown.value = `${hours}:${minutes}:${seconds}`;
  }, 1000); // 每秒更新一次
}

const order = ref({orderId:route.query.orderId,imgs:[]})

function iHavePaid(){
  console.log(order.value)
  ApiRequest._rtEnDtpo(order.value).then((res)=>{
    console.log(res)
    detail.value.status="paid";
  })
}
const detail = ref({payment:"Banker",amountToPay:999.99,})
onBeforeMount(()=>{
  paymentAccountStore().init();
  ApiRequest._L2rMPX8W({payment:route.query.type,orderId:route.query.orderId}).then(res=>{
    detail.value.amountToPay=res.amountToPay;
    detail.value.status=res.status;
    detail.value.createAt=res.createAt;
    detail.value.paymentAccountId=res.paymentAccountId;
    detail.value.receiver=res.paymentAccountId;
    const now = new Date().getTime(); // 当前时间戳（毫秒）
    timeGap.value=res.serverTime-now;
    if("toPay"===res.status)startCountdown(res.expiredAt);
  })
})

</script>

<style scoped>

.countdown {
  text-align: center;
  font-size: .2rem;
  color: var(--f3);
  padding: .1rem;
}

::v-deep(.van-cell,.van-field__label,.van-cell__value){
  background: var(--bg);
  color: var(--f3);
}
/*
::v-deep(.van-cell-group){
  background: var(--bg)!important;
}*/
::v-deep(.van-uploader__upload){
  background-color: var(--bg)!important;
  border:1px dashed var(--main);
}
::v-deep(.van-uploader__upload-icon){
  color: var(--f3);
}
</style>
