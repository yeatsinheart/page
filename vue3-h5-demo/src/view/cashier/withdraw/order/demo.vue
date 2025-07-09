<script setup>
import {openby} from "@/tool/pop.js";
import {userStore} from "@/config/store/user.js";
import {withdrawStore} from "@/config/store/withdraw.js";
import {appStore} from "@/config/store/app.js";
import { format_str} from "@/tool/string.js";
import {useI18n} from "vue-i18n";
import {CurrencyUtil} from "@/tool/currency.js";
import {useRouter} from "vue-router";
const router = useRouter();
const {t} = useI18n();

// 汇率互换
const updating = ref(false);
// 监听法币金额，计算币数量
watch(()=>withdrawStore().amount_order, (newVal) => {
  if (updating.value) return;
  updating.value = true; 
  if(!CurrencyUtil.isStrictNumber(newVal)) {withdrawStore().amount_coin =null;nextTick(() => {updating.value = false;});return;}
  const num = parseFloat(newVal)
  withdrawStore().amount_coin = withdrawStore().currencyToCoin(num);
  // 延迟重置更新标志，确保不会触发循环调用
  nextTick(() => {updating.value = false;});
})
// 监听游戏币数量，计算法币金额
watch(()=>withdrawStore().amount_coin, (newVal) => {
  if (updating.value) return;
  updating.value = true;
  if(!CurrencyUtil.isStrictNumber(newVal)) {withdrawStore().amount_order = null;nextTick(() => {updating.value = false;});return;}
  const num = parseFloat(newVal)
  withdrawStore().amount_order = withdrawStore().coinToCurrency(num);
  // 延迟重置更新标志，确保不会触发循环调用
  nextTick(() => {updating.value = false;});
})
watch(() => withdrawStore().paymentMethod, (newVal) => {withdrawStore().amount_order=null;})

</script>

<template>
  <div class="withdraw-new-order">

<!--    <div style="padding-bottom: 0.1rem">
      {{ $t("当前可提现")+" "+CurrencyUtil.formatBy1000(withdrawStore().canWithdrawAmount) }} {{appStore().app.coin.code}}
      <span style="color:var(&#45;&#45;main);cursor: pointer;"
            @click="withdrawStore().amount_coin=withdrawStore().canWithdrawAmount;">{{$t('全部')}}</span>
    </div>-->

    <van-field v-model="withdrawStore().amount_order" type="number" autocomplete="one-time-code" style="background-color: initial;border:1px solid var(--border);border-radius: .1rem;"
               :placeholder="format_str('%s -  %s',
               withdrawStore().paymentMethod.withdrawMin,
               withdrawStore().paymentMethod.withdrawMax)"
    >
      <template #right-icon>
        <div class="flex-center" style="padding:0 .2rem;" @click="withdrawStore().amount_order=null">
          <div style="padding-right: .1rem;">{{ withdrawStore().paymentMethod.currency }}</div>
          <i class="fa-solid fa-circle-xmark"></i>
        </div>
      </template>
    </van-field>

    <div v-if="withdrawStore().paymentMethod.currency!==appStore().app.coin.code" >
      <div class="flex-center"> <i class="fa-solid fa-retweet"></i> </div>

      <van-field v-model="withdrawStore().amount_coin" type="number" autocomplete="one-time-code" style="background-color: initial;border:1px solid var(--border);border-radius: .1rem;"
                 :placeholder="format_str('%s -  %s',
               withdrawStore().currencyToCoin(withdrawStore().paymentMethod.withdrawMin),
               withdrawStore().currencyToCoin(withdrawStore().paymentMethod.withdrawMax)
               )"
      >
        <template #right-icon>
          <div class="flex-center" style="padding:0 .2rem;" @click="withdrawStore().amount_coin=null">
            <div style="padding-right: .1rem;">{{appStore().app.coin.code}}</div>
            <i class="fa-solid fa-circle-xmark"></i>
          </div>
        </template>
      </van-field>

      <div>
        <div>1 {{ withdrawStore().paymentMethod.currency }} = {{ withdrawStore().currencyToCoin(1) }} {{ appStore().app.coin.code }}
        </div>
        <div>1 {{ appStore().app.coin.code }} = {{ withdrawStore().coinToCurrency(1) }} {{ withdrawStore().paymentMethod.currency }}
        </div>
      </div>

    </div>

    <div style="height: .2rem;"></div>

    <div class="flex-center" style="justify-content: space-between;padding:.1rem 0;">
      <div @click="openby('/ui/popup/close_right_top','/cashier/withdraw/history/demo')">{{ $t('提现记录') }}</div>
      <div @click="open_by_key('customer')">{{ $t('联系客服') }}</div>
    </div>



    <div class="fixed flex-center" style="padding: 0.2rem; bottom: 0;justify-content: space-between">
      <div @click="router.back()" style="width:20%;border: thin solid var(--main);color: var(--main);border-radius: .1rem;line-height: .5rem;height: .5rem;text-align: center;">
        {{ $t("退出") }}
      </div>
      <div style="width: 75%;">
        <div v-if="!userStore().isLoggedIn"
             style=" background-color: var(--main);color: var(--main_font); border-radius: .1rem;line-height: .6rem;text-align: center;"
             @click="userStore().toLogin()"
        >
          {{ $t("未登录") }}
        </div>
        <div v-else v-loading="withdrawStore().creating"
             :style="withdrawStore().canCreateOrder?'':'background-color:gray;'"
             class="flex-center order-btn"
             @click="()=>{if(withdrawStore().canCreateOrder){withdrawStore().createOrder()}}">
          {{ $t('确认提现') }}
        </div>
      </div>

    </div>
  </div>
</template>

<style lang="scss" scoped>
.withdraw-new-order{
  :deep(.van-field__control){color: var(--f3);}
  :deep(.van-cell:after){border: 0;}
  :deep(.van-cell){
    padding: .1rem 0 !important;
  }
  :deep(.van-field__right-icon){padding: 0 !important;}

  :deep(.van-field__control:disabled) {
    -webkit-text-fill-color: var(--f3);
  }
  /* 确保 placeholder 样式不受影响 */
  :deep(.van-field__control:disabled::placeholder) {
    -webkit-text-fill-color: var(--f1);
  }
  .order-btn {
    background-color: var(--main);
    color: var(--main_font);
    border-radius: .1rem;
    line-height: .5rem;
    height: .5rem;
    text-align: center;
  }
}
</style>