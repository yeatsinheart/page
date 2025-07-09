<template>
  <div class="transfer-container">
    <!-- 标题 -->
    <h2 class="title">充值到银行卡</h2>

    <!-- 收款银行信息 -->
    <div class="bank-info">
        <van-cell title="银行名称" value="中国银行" />
        <van-cell title="账户名" value="张三" />
        <van-cell title="银行卡号" value="6225 **** **** 1234" />
        <van-cell title="充值金额" value="9999.99"/>
    </div>


    <!-- 充值限额 -->
    <p class="limit-info">单笔充值限额：¥100 - ¥50,000</p>


    <!-- 上传支付凭证（可选） -->
    <div class="flex-center" style="margin-top: 20px">
    <ImgUpload v-model="img"/>
    <p class="limit-info">上传支付凭证</p>
    </div>
    <!-- 倒计时 -->


    <!-- 提交按钮 -->
    <div style="position: fixed;bottom: 0;left:0;width:100%;">
    <p class="countdown">订单有效时间：{{ countdown }} 分钟</p>
    <van-button type="primary" block @click="submitTransfer" >提交付款信息</van-button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { showToast } from "vant";
import ImgUpload from "@/components/img-upload.vue";

const amount = ref("");
const img = ref("");
const fileList = ref([]);
const countdown = ref(15); // 15分钟倒计时

const submitTransfer = () => {
  showToast("提交成功，等待处理...");
  // 这里可以调用 API 提交数据
};

// 模拟倒计时
onMounted(() => {
  const timer = setInterval(() => {
    if (countdown.value > 0) countdown.value--;
    else clearInterval(timer);
  }, 60000);
});
</script>

<style scoped>
.transfer-container {
  padding: .2rem;
  height: 100%;
}
.title {
  font-size: 20px;
  font-weight: bold;
  text-align: center;
  margin-bottom: 15px;
}
.limit-info, .countdown {
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
