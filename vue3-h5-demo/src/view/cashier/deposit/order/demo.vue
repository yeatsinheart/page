<script setup>
import {showToast} from "vant";
import {openby} from "@/tool/pop.js";
import {userStore} from "@/config/store/user.js";
import {depositStore} from "@/config/store/deposit.js";

import {useI18n} from "vue-i18n";
import {appStore} from "@/config/store/app.js";
import { format_str} from "@/tool/string.js";
import {CurrencyUtil} from "@/tool/currency.js";
const {t} = useI18n();

// 汇率互换
const updating = ref(false);
// 监听法币金额，计算币数量
watch(()=>depositStore().amount_order, (newVal) => {
  if (updating.value) return;
  updating.value = true;
  if(!CurrencyUtil.isStrictNumber(depositStore().amount_order)) {depositStore().amount_coin =null;nextTick(() => {updating.value = false;});return;}
  const num = parseFloat(newVal)
  depositStore().amount_coin =  depositStore().currencyToCoin(num);
  // 延迟重置更新标志，确保不会触发循环调用
  nextTick(() => {updating.value = false;});
})
// 监听游戏币数量，计算法币金额
watch(()=>depositStore().amount_coin, (newVal) => {
  if (updating.value) return;
  updating.value = true;
  if(!CurrencyUtil.isStrictNumber(newVal)) {depositStore().amount_order = null;nextTick(() => {updating.value = false;});return;}
  const num = parseFloat(newVal)
  depositStore().amount_order = depositStore().coinToCurrency(num);
  // 延迟重置更新标志，确保不会触发循环调用
  nextTick(() => {updating.value = false;});
})

</script>

<template>
  <div class="deposit-new-order">
    <div style="padding-bottom: .1rem">{{$t("支付金额")}}</div>
    <div :class="'col-'+ (depositStore().channel.col || 5)">
      <div v-for="(choice) in depositStore().channel.choices?.split(',')"
           class="flex-center"
           style="height: .5rem;line-height: .5rem;border: thin solid var(--border);border-radius: .1rem;"
           :style="Number(depositStore().amount_order)===Number(choice)?'border: thin solid var(--main);':''"
           @click="depositStore().amount_order=choice">
        {{ choice }}
      </div>
    </div>
    <van-field v-model="depositStore().amount_order" :disabled="depositStore().channel.onlyChoice"
               type="number" style="background-color: initial;border:1px solid var(--border);border-radius: .1rem;"
               :placeholder="format_str('%s -  %s',depositStore().channel.min,depositStore().channel.max)"
    >
      <template #right-icon>
        <div class="flex-center" style="padding:0 .2rem;" @click="depositStore().amount_order=null">
          {{depositStore().channel.currency}}
          <i class="fa-solid fa-circle-xmark"></i>
        </div>
      </template>
    </van-field>


    <div v-if="depositStore().channel?.currency!==appStore().app.coin.code" style="">
      <div class="flex-center"> <i class="fa-solid fa-retweet"></i> </div>
      <van-field v-model="depositStore().amount_coin"  :disabled="depositStore().channel.onlyChoice"
                 type="number" style="background-color: initial;border:1px solid var(--border);border-radius: .1rem;"
                 :placeholder="format_str('%s -  %s',
                 depositStore().currencyToCoin(depositStore().channel.min),
                 depositStore().currencyToCoin(depositStore().channel.max)
                 )"
      >
        <template #right-icon>
          <div class="flex-center" style="padding:0 .2rem;" @click="depositStore().amount_coin=null">
            {{appStore().app.coin.code}}
            <i class="fa-solid fa-circle-xmark"></i>
          </div>
        </template>
      </van-field>

      <div>
        <div>1 {{depositStore().channel.currency}} = {{depositStore().currencyToCoin(1)}} {{appStore().app.coin.code}}
        </div>
        <div>1 {{appStore().app.coin.code}} = {{depositStore().coinToCurrency(1)}} {{depositStore().channel.currency}}
        </div>
      </div>
    </div>

    <div v-html="depositStore().channel.htmlContent" class="ck-content" style="margin: .2rem 0;">

    </div>


    <div class="flex-center" style="justify-content: space-between;padding:.1rem 0;">
      <div @click="openby('/ui/popup/close_right_top','/cashier/deposit/history/demo')">{{ $t('充值记录') }}</div>
      <div @click="view_route_by_key('customer')">{{ $t('联系客服') }}</div>
    </div>

    <div class="fixed" style="padding:.2rem .2rem;bottom: 0;">

      <div v-if="!userStore().isLoggedIn" class="flex-center order-btn"
           @click="userStore().toLogin()">{{ $t("未登录") }}
      </div>

      <div v-else v-loading="depositStore().creating"
           :style="depositStore().canCreateOrder?'':'background-color:gray;'"
           class="flex-center order-btn"
           @click="()=>{if(depositStore().canCreateOrder){depositStore().createOrder()}}">
        {{ $t('确认充值') }}
      </div>

    </div>
  </div>
</template>

<style lang="scss" scoped>
.order-btn {
  background-color: var(--main);
  color: var(--main_font);
  border-radius: .1rem;
  line-height: .5rem;
  height: .5rem;
  text-align: center;
}

.deposit-new-order{
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