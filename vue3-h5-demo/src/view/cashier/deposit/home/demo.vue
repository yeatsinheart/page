<template>
  <div>
    <!-- 两个才显示通道分类  -->
    <van-tabs v-if="depositStore().categories.length>1" animated>
      <van-tab v-for="(category) in depositStore().categories" :key="'category'+category.categoryId">
        <template #title>
          <div class="flex-center" style="height: 100%;" @click="depositStore().chooseCategory(category)">
            <div v-if="category.bonus>0" class="bonus">
              <div style="">+{{ category.bonus }}%</div>
              <div></div>
            </div>
            <img v-if="category.img1x1!=null" :src="category.img1x1" style="width:.33rem;height:.33rem">
            <div style="padding-left: .1rem">{{ $t(category.name) }}</div>
          </div>
        </template>
      </van-tab>
    </van-tabs>
    <div style="padding:0 .2rem;">
      <!-- 支付方式 选择 -->
      <div v-if="depositStore().category.children.length > 0">
        <div style="padding-top: .2rem ;">{{ $t('选择支付方式') }}</div>
        <div :class="'col-'+ (depositStore().category.col || 2)">
          <div v-for="(paymentMethod) in depositStore().category.children"
               :key="'payment-'+paymentMethod.paymentMethodKey"
               @click="()=>{if(paymentMethod.status==='on'){depositStore().choosePaymentMethod(paymentMethod)}}">
            <div v-if="paymentMethod.bonus>0" style="position: relative;width: 100%;height: 0.18rem;">
              <div class="bonus">
                <div>+{{ paymentMethod.bonus }}%
                </div>
                <div></div>
              </div>
            </div>
            <div :style="depositStore().paymentMethod.paymentMethodKey===paymentMethod.paymentMethodKey?'border-color:var(--main)':''"
                class="flex-center payment">
              <img v-if="paymentMethod.img1x1!=null" :src="paymentMethod.img1x1"
                   :style="paymentMethod.status==='maintain'?'mix-blend-mode:luminosity;':''"
                   class="img1x1" style="width:.44rem;height:.44rem">
              <div style="padding-left: .1rem;flex:1;width: 100%;min-width: 0;">
                <div class="truncate">{{ $t(paymentMethod.name) }}</div>
                <div v-if="paymentMethod.status==='maintain'">{{ $t('维护中') }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- 充值通道 选择 -->
      <div  v-if="depositStore().paymentMethod.children.length>1">
        <div>{{ $t('选择支付通道') }}</div>
        <div :class="'col-'+ (depositStore().paymentMethod.col || 3)">
          <div v-for="(channel) in depositStore().paymentMethod.children" :key="'channel-'+channel.channelId" style=""
               @click="()=>{if(channel.status==='on'){depositStore().chooseChannel(channel)}}">
            <div v-if="channel.bonus>0" style="position: relative;width: 100%;height: 0.18rem;">
              <div class="bonus">
                <div>+{{ channel.bonus }}%
                </div>
                <div></div>
              </div>
            </div>
            <div :style="depositStore().channel.channelId===channel.channelId?'border-color:var(--main)':''"
                 class="flex-center channel">
              <img v-if="channel.img1x1!=null" :src="channel.img1x1" style="width:.44rem;height:.44rem">
              <div style="padding-left: .1rem;flex:1;width: 100%;min-width: 0;">
                <div class="truncate">{{ channel.name }}</div>
                <div v-if="channel.status==='maintain'" class="truncate">{{ $t('维护中') }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!--  选择支付账号 v-if="depositStore().depositChannel.accountRequired"  v-if="depositStore().depositChannel.accountRequired"-->
      <div style="padding:.2rem 0;">
        <div style="padding-bottom: .1rem;">{{ $t('选择支付账号') }}</div>
        <!--  当前支付方式已绑定账号 -->
        <van-radio-group v-model="paymentAccountStore().chosenId">
          <div
              v-for="(account) in paymentAccountStore().accountsOfMethod(depositStore().paymentMethod.paymentMethodKey)"
              :key="'link-'+account.paymentAccountId">
            <van-cell
                :style="paymentAccountStore().chosenId===account.linkedId?'border:1px solid var(--main)!important;border-radius:.1rem!important;':''"
                @click="paymentAccountStore().chosenId=account.linkedId">
              <template #title>
                <div class="flex-center">
                  <img v-if="account.paymentImg1x1!=null" :src="account.paymentImg1x1" style="width:.44rem;height:.44rem">
                  <div style="padding-left: .1rem;flex:1;width: 100%;">
                    <div v-if="account.maskName" class="truncate">{{ account.maskName }}</div>
                    <div v-if="account.maskNumber" class="truncate">{{ account.maskNumber }}</div>
                    <div v-if="account.status==='maintain'">{{ $t('维护中') }}</div>
                  </div>
                </div>
              </template>
              <template #right-icon>
                <van-radio :name="account.linkedId"/>
              </template>
            </van-cell>
          </div>
        </van-radio-group>

        <van-cell style="margin: .1rem 0;border: thin solid var(--border);border-radius: .1rem;"
                  @click="open_by_key('payment_account')">
          <template #icon>
            <div class="flex-center">
              <img v-if="depositStore().paymentMethod.img1x1" :src="depositStore().paymentMethod.img1x1"
                   style="width:.44rem;height:.44rem">
              <i v-else class="fa-solid fa-credit-card"></i>
            </div>
          </template>
          <template #title>
            <div class="flex-center">
              <div style="padding-left: .1rem;flex:1;width: 100%;">
                <div class="truncate">{{ $t("绑定支付账号") }}</div>
              </div>
            </div>
          </template>
          <template #right-icon>
            <div class="flex-center"><i class="fa-solid fa-angle-right"></i></div>
          </template>
        </van-cell>
      </div>

      <!-- 订单 防止动态高度闪屏-->
      <div
          v-if="depositStore().channel.uiDepositNewOrder
          && (!depositStore().channel.linkedRequired || paymentAccountStore().chosenId)"
          style="min-height: 3.5rem;">
        <ViewImportByPath v-if="depositStore().channel.uiDepositNewOrder" :key="depositStore().channel.channelId"
                          :path="depositStore().channel.uiDepositNewOrder"></ViewImportByPath>

      </div>

    </div>
  </div>
</template>

<script setup>
import {onBeforeMount} from "vue";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
import {depositStore} from "@/config/store/deposit.js";
import {useI18n} from "vue-i18n";
import {paymentAccountStore} from "@/config/store/paymentAccount.js";

const {t} = useI18n();

onBeforeMount(() => {
  paymentAccountStore().init()
  depositStore().depositInit()
})


</script>

<style lang="scss" scoped>
div {
  transition: all .2s;
}

/*
.van-tabs--line  整个tab
.van-tabs__wrap 标题区 外层
.van-tab--line 标题区
  */

// tab栏
:deep(.van-tabs) {
  //背景色
  --van-tabs-nav-background: var(--bg);
  // 默认颜色
  --van-tab-text-color: var(--f2);
  // 选中颜色
  --van-tab-active-text-color: var(--main);
  // 下划线颜色
  --van-tabs-bottom-bar-color: var(--main);
}

:deep(.van-tabs--line .van-tabs__wrap) {
  height: .5rem;
}

:deep(.van-tab) {
  flex: 0 0 auto;
  font-size: initial;
}

:deep(.van-tabs__wrap) {
  margin-right: 0 !important;
  /*height:.5rem!important;*/
}

:deep(.van-tabs__line) {
  /*横线*/
  width: 1rem;
}


.category {

}

.payment {
  width: 100%;
  height: .7rem;
  padding: 0 .1rem;
  border: thin solid var(--border);
  border-radius: .1rem;
  justify-content: flex-start;
}

.channel {
  width: 100%;
  height: .7rem;
  padding: 0 .1rem;
  border: thin solid var(--border);
  border-radius: .1rem;
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

:deep(.van-dialog) {
  background: var(--bg1);
}
</style>
