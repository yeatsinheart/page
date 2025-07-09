<script setup>
import {onBeforeMount, ref} from "vue";
import {ApiRequest} from "@/api/index.js";
import {openby} from "@/tool/pop.js";

import {useI18n} from "vue-i18n";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
import {userStore} from "@/config/store/user.js";
import {withdrawStore} from "@/config/store/withdraw.js";
import {paymentAccountStore} from "@/config/store/paymentAccount.js";
import {CurrencyUtil} from "@/tool/currency.js";

const {t} = useI18n();

// 是否绑定提现密码
const bindingPassword = ref(true);


onBeforeMount(() => {
  paymentAccountStore().init()
  withdrawStore().withdrawInit()
});
function cycle(type) {
  let v = "";
  switch (type) {
    case "daily":v= t("每日");break;
    case "weekly":v= t("每周");break;
    case "monthly":v= t("每月");break;
  }
  if(v){
    return "("+v+")";
  }
  return v;
}
</script>

<template>
  <div style="height: 100%;width: 100%; overflow-y: auto;padding:.2rem;">
    <div v-if="withdrawStore().limit?.balance">
      {{ $t("可用余额") }}
      <span style="color: var(--main);">{{ CurrencyUtil.formatBy1000(withdrawStore().limit?.balance) }}</span>
      <i class="fa-solid fa-arrows-rotate" style="padding: 0 0.13rem" @click="withdrawStore().refreshLimit()"/>
    </div>

    <div class="flex-center"  style="justify-content: space-between;padding: .1rem 0;">
      <div v-if="withdrawStore().limit?.betLimit?.enable">
        <div>{{$t('提现所需有效投注')}}：
        <span style="color: var(--main);">{{ CurrencyUtil.formatBy1000(withdrawStore().limit?.betLimit?.taskAmount) }}</span></div>
        <span v-if="'deny'===withdrawStore().limit?.betLimit?.feeType"> {{$t('未完成无法提现')}}</span>
        <span v-if="'percent'===withdrawStore().limit?.betLimit?.feeType"> {{$t('未完成需支付手续费')}}{{withdrawStore().limit?.timesLimit?.fee}}%</span>
        <span v-if="'number'===withdrawStore().limit?.betLimit?.feeType"> {{$t('未完成需支付手续费')}}{{withdrawStore().limit?.timesLimit?.fee}}</span>
      </div>
      <div  @click="openby('/ui/popup/close_right_top','/cashier/withdraw/task/demo')">{{ $t('提现任务') }}</div>
    </div>
    <div  class="flex-center" style="justify-content: space-between;padding: .1rem 0;">
      <div>
        <div v-if="withdrawStore().limit?.timesLimit?.enable">
          <div>{{$t('免费提现次数')}}:
          <span style="color: var(--main);">{{withdrawStore().limit?.timesLimit?.used}}</span>/
          {{withdrawStore().limit?.timesLimit?.total}}
          {{cycle(withdrawStore().limit?.timesLimit?.cycle)}}</div>
          <span v-if="'deny'===withdrawStore().limit?.timesLimit?.feeType"> {{$t('超过无法提现')}}</span>
          <span v-if="'percent'===withdrawStore().limit?.timesLimit?.feeType"> {{$t('超过需支付手续费')}}{{withdrawStore().limit?.timesLimit?.fee}}%</span>
          <span v-if="'number'===withdrawStore().limit?.timesLimit?.feeType"> {{$t('超过需支付手续费')}}{{withdrawStore().limit?.timesLimit?.fee}}</span>
        </div>
        <div v-if="withdrawStore().limit?.amountLimit?.enable">
          <div>{{$t('免费提现额度')}}:
          <span style="color: var(--main);">{{withdrawStore().limit?.amountLimit?.used}}</span>
          /
          {{CurrencyUtil.formatBy1000(withdrawStore().limit?.amountLimit?.total)}}
          {{cycle(withdrawStore().limit?.amountLimit?.cycle)}}</div>
          <span v-if="'deny'===withdrawStore().limit?.amountLimit?.feeType"> {{$t('超过无法提现')}}</span>
          <span v-if="'percent'===withdrawStore().limit?.amountLimit?.feeType"> {{$t('超过需支付手续费')}}{{withdrawStore().limit?.timesLimit?.fee}}%</span>
          <span v-if="'number'===withdrawStore().limit?.amountLimit?.feeType"> {{$t('超过需支付手续费')}}{{withdrawStore().limit?.timesLimit?.fee}}</span>
        </div>
      </div>
    </div>

    <!-- 支付方式 -->
    <div :class="'col-' + 2">
      <div v-for="payment in withdrawStore().methods" :key="'payment-method-' + payment.paymentMethodKey"
           @click="()=>{if(payment.status==='on'){withdrawStore().paymentMethod=payment}}">
        <div v-if="payment.bonus > 0" class="bonus">
          <div>+{{ payment.bonus }}%</div>
          <div></div>
        </div>
        <div :style="withdrawStore().paymentMethod.paymentMethodKey===payment.paymentMethodKey?'border-color:var(--main)':''"
             class="flex-center payment">
          <img v-if="payment.img1x1!=null" :src="payment.img1x1"
               :style="payment.status==='maintain'?'mix-blend-mode:luminosity;':''"
               class="img1x1" style="width:.44rem;flex-shrink: 0;">
          <!--        flex 子元素碰到 nowrap 需要min-width:0;      -->
          <div style="padding-left: .1rem;width: 100%;min-width: 0;">
            <div class="truncate">{{ $t(payment.name) }}</div>
            <div v-if="payment.status==='maintain'" class="truncate">{{ $t('维护中') }}
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--  选择绑定账号 -->
    <div style="padding:.2rem 0;">
      <div style="padding-bottom: .1rem;">{{ $t('选择收款账号') }}</div>
      <!--  当前支付方式已绑定账号 -->
      <van-radio-group v-model="paymentAccountStore().chosenId">
        <div v-for="(account) in paymentAccountStore().accountsOfMethod(withdrawStore().paymentMethod.methodKey)"
             :key="'payment-account-'+account.paymentAccountId">
          <van-cell
              :style="paymentAccountStore().chosenId===account.paymentAccountId?'border:1px solid var(--main)!important;border-radius:.1rem!important;':''"
              @click="paymentAccountStore().chosenId=account.paymentAccountId">
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

      <van-cell v-if="paymentAccountStore().accountsOfMethod(withdrawStore().paymentMethod.methodKey).length<withdrawStore().paymentMethod.linkedAccountMax"
          style="margin: .1rem 0;border: thin solid var(--border);border-radius: .1rem;"
                @click="open_by_key('payment_account')">
        <template #icon>
          <div class="flex-center">
            <img v-if="withdrawStore().paymentMethod?.img1x1" :src="withdrawStore().paymentMethod.img1x1" class="img1x1" style="width:.44rem;height:.44rem">
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

    <!-- 绑定账户 -->

    <!-- 订单 -->
    <ViewImportByPath v-if="withdrawStore().paymentMethod?.uiWithdrawNewOrder"
                      :path="withdrawStore().paymentMethod?.uiWithdrawNewOrder"/>

    <!--
    <button @click="bindingPassword = !bindingPassword" style="position: absolute; color: black; left: 50%">
      切换
    </button>
-->

    <div class="withdrawal">
      <!--      <div v-if="!bindingPassword">
              <p class="withdrawal_title">
                {{ $t("为了您的资金安全, 您需要先设置提现密码") }}
              </p>
              <div class="setPassword">
                <p class="setPassword_title">
                  {{ $t("设置您的提款密码") }}
                </p>
                <passwordInput title="新提款密码"/>
                <passwordInput title="确认提款密码提款密码"/>
                <p class="bottom-title">
                  {{
                    $t(
                        "注意：提现密码注意保护您的资金, 极其重要. 保守秘密以避免任何经济损失."
                    )
                  }}
                </p>
              </div>
              <div class="foot-title">
                <button>
                  {{ $t("确认") }}
                </button>
              </div>
            </div>-->

      <div style="width: 100%;">


      </div>
    </div>


  </div>
</template>

<style lang="scss" scoped>
.withdrawal {
  .withdrawal_title {
    font-size: 14px;
    color: var(--c1);
    text-align: center;
    margin-top: 20px;
  }
}

.setPassword {
  margin-top: 20px;
  padding: 12px;
  color: var(--f4);

  .setPassword_title {
    font-size: 14px;
    font-weight: bold;
  }

  .setPassword_main {
    margin-top: 20px;
  }

  .bottom-title {
    color: var(--main);
    margin-top: 30px;
    font-size: 13px;
  }
}

.foot-title {
  width: 100%;
  height: 100px;
  background-color: var(--bg1);
  margin-top: 200px;
  padding: 0 12px;
  box-sizing: border-box;
  display: flex;
  align-items: center;

  button {
    width: 100%;
    height: 50px;
    border: none;
    border-radius: 10px;
    background-color: var(--main);
  }
}

.withdrawal-container {
  width: 100%;
  height: 100%;
  padding: 12px;
  background-color: var(--bg1);
  border-radius: 8px;
  color: var(--f2);
  box-sizing: border-box;
  font-size: 14px;
}

.withdraw-options {
  display: flex;
  justify-content: space-between;
  padding: 15px 0;
  border-bottom: 1px solid var(--border);

  button {
    width: 200px;
    height: 40px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 12px;
    color: white;
    border: 1px solid var(--border);
    background: none;
  }

  .convert-btn {
    color: var(--main);
    border: 1px solid var(--main);
    position: relative;
    overflow: hidden;

    .convert-active {
      position: absolute;
      width: 20px;
      height: 20px;
      background: linear-gradient(135deg, transparent 50%, var(--main) 50%);
      left: 91%;
      top: 20px;
    }

    .i-icon {
      position: absolute;
      left: 7px;
      top: 7px;
    }
  }
}

.account {
  padding: 15px 0;
}

.add-account {
  padding: 0 5px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 40px;
  border: 1px solid var(--border);
  border-radius: 7px;

  .i-icon {
    padding-top: 8px;
    font-size: 25px;
  }

  .account-left {
    display: flex;
    align-items: center;
    width: 200px;
    padding: 0 5px;

    .account-label {
      margin-left: 15px;
    }
  }
}

.footer-btn {
  width: 100%;
  height: 40px;
  background-color: var(--main);
  border: none;
  border-radius: 10px;
  margin-top: 20px;
  font-size: 15px;
  color: var(--f1);
}

.payment {
  width: 100%;
  height: .7rem;
  padding: 0 .1rem;
  border: thin solid var(--border);
  border-radius: .1rem;
  justify-content: flex-start;
}

.bonus {
  position: absolute;
  right: 0;

  :nth-child(1) {
    color: var(--main);
    background: var(--main);
    border-radius: 0.125rem 0.125rem 0.125rem 0px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 0.18rem;
    padding: 0 0.08rem;
    line-height: 1;
  }

  :nth-child(2) {
    border-bottom: 0.07rem solid transparent;
    border-left: .07rem solid var(--main);
    border-right: 0.07rem solid transparent;
    height: 0px;
    width: 0px;
  }
}

</style>
