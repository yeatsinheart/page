<template>
  <div style="width: 100%;height: 100%;position: relative;" v-loading="loading">
    <div style="height: 70%;padding:.2rem;">
      <van-cell-group v-if="paymentAccountStore().accounts && paymentAccountStore().accounts.length>0" style="height:100%;overflow-y: auto;">
        <div v-for="account in paymentAccountStore().accounts" :key="account.linkedId">
          <van-cell >
            <template #title>
              <div class="flex-center">
                <img v-if="account.methodImg1x1!=null" :src="account.methodImg1x1" class="img1x1" style="width:.44rem;height:.44rem">
                <div style="padding-left: .1rem;flex:1;width: 100%;">
                  <div class="truncate">{{ account.maskName }}</div>
                  <div class="truncate">{{ account.maskNumber }}</div>
                  <div v-if="account.status==='maintain'">{{ $t('维护中') }}</div>
                </div>
              </div>
            </template>
          </van-cell>
        </div>
      </van-cell-group>
      <!-- 没有绑定信息 -->
      <van-empty v-else :description="$t('暂未绑定账号')" />
    </div>
    <div style="height: 30%;padding:.2rem;background: var(--bg1);">
      <ul style="height: 100%;overflow-y: auto;">
        <li v-for="(payment, index) in paymentAccountStore().methods" :key="index" class="flex-center"
            style="justify-content: space-between;border:1px solid var(--border);margin:.1rem;padding:.1rem;border-radius: .1rem;">
          <div class="flex-center">
            <img v-if="payment.img1x1" :src="payment.img1x1" alt="" class="img1x1"  style="width: .45rem;height: .45rem" />
            <span style="padding-left: .1rem;">{{ $t(payment.name) }}</span>
          </div>
          <div class="flex-center" @click="()=>{if(paymentAccountStore().can_add(payment)){paymentAccountStore().toAddAccountPage(payment)}}">
            <span>{{paymentAccountStore().accountsOfMethod(payment.paymentMethodKey)?.length}} / {{ payment.linkedAccountMax }}</span>
            <span v-if="paymentAccountStore().can_add(payment)">{{ $t("添加") }}</span>
            <i class="fa-solid fa-angle-right" v-if="paymentAccountStore().can_add(payment)"></i>
          </div>
        </li>
      </ul>
    </div>


    <!-- 弹窗 -->

  </div>
</template>

<script setup>
import { onBeforeMount, ref } from "vue";
import {paymentAccountStore} from "@/store/paymentAccount.js";
const  loading = ref(false);

const showDialog = ref(false);

function init(){
  loading.value = true;
  paymentAccountStore().init();
  loading.value = false;
}
onBeforeMount(() => {
  init();
});
</script>

<style lang="scss" scoped>

:deep(.van-cell-group){
  background-color: initial;
}
:deep(.van-cell){
  background-color: initial;
}
:deep(.van-hairline--top-bottom:after, .van-hairline-unset--top-bottom:after){
  border: 0;
}
</style>
