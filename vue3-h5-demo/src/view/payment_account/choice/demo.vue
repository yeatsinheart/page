<script setup>

import {withdrawStore} from "@/store/withdraw.js";
import {paymentAccountStore} from "@/store/paymentAccount.js";
import {open_by_key} from "@/tool/View.js";
</script>

<template>
  <div style="padding:.2rem 0;">
    <div style="padding-bottom: .1rem;">{{ $t('选择收款账号') }}</div>
    <!--  当前支付方式已绑定账号 -->
    <van-radio-group v-model="withdrawStore().withdrawOrder.paymentAccountId">
      <div v-for="(account) in paymentAccountStore().listOfPaymentKey(withdrawStore().withdrawPayment.paymentKey)"
           :key="'link-'+account.paymentAccountId">
        <van-cell
            :style="withdrawStore().withdrawOrder.paymentAccountId===account.paymentAccountId?'border:1px solid var(--c2)!important;border-radius:.1rem!important;':''"
            @click="withdrawStore().withdrawOrder.paymentAccountId=account.paymentAccountId">
          <template #title>
            <div class="flex-center">
              <img v-if="account.paymentImg1x1!=null" :src="account.paymentImg1x1"
                   style="width:.44rem;height:.44rem">
              <div style="padding-left: .1rem;flex:1;width: 100%;">
                <div v-if="account.maskName" class="truncate">{{ account.maskName }}</div>
                <div v-if="account.maskNumber" class="truncate">{{ account.maskNumber }}</div>
                <div v-if="account.status==='maintain'">{{ $t('维护中') }}</div>
              </div>
            </div>
          </template>
          <template #right-icon>
            <van-radio :name="account.paymentAccountId"/>
          </template>
        </van-cell>
      </div>
    </van-radio-group>

    <van-cell style="margin: .1rem 0;border: thin solid var(--border);border-radius: .1rem;"
              @click="open_by_key('payment_account')">
      <template #icon>
        <div class="flex-center">
          <img v-if="withdrawStore().withdrawPayment?.img1x1" :src="withdrawStore().withdrawPayment.img1x1"
               style="width:.44rem;height:.44rem">
          <i v-else class="fa-solid fa-credit-card"></i>
        </div>
      </template>
      <template #title>
        <div class="flex-center">
          <div style="padding-left: .1rem;flex:1;width: 100%;">
            <div class="truncate">{{ $t("绑定收款账号") }}</div>
          </div>
        </div>
      </template>
      <template #right-icon>
        <div class="flex-center"><i class="fa-solid fa-angle-right"></i></div>
      </template>
    </van-cell>
  </div>
</template>

<style scoped lang="scss">

</style>