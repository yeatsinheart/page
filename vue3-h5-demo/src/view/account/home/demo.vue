<script setup>
import {useRouter} from "vue-router";

import {appStore} from "@/config/store/app.js";
import {userStore} from "@/config/store/user.js";

import un_login_avatar from '@/assets/un_login_avatar.png';
import coin from '@/assets/coin.png';

const appState = appStore();
const userState = userStore();

const router = useRouter();
// 退出登录
const logout_show = ref(false);
const status=ref([
  {img:'',type:'kyc',status:null},
  {img:'',type:'passwordWithdraw',status:null},
])

import {CurrencyUtil} from "@/tool/currency.js";

import {useI18n} from "vue-i18n";
import {open_by_key} from "@/view.js";
const {t} = useI18n();

const copyToClipboard = async (data) => {
  try {
    await navigator.clipboard.writeText(data);
    showSuccessToast(t("复制成功"));
  } catch (err) {
    console.error("复制失败", err);
  }
};
</script>

<template>
  <div style="height: 100%;padding:0 .2rem;padding-bottom: 1.4rem;overflow-y: auto;">
    <div style="background: url('@/assets/images2/style_1_topbg_yd.avif') 0 0 / 100% no-repeat;">
      <header class="flex-center head_superior" style="height: 1rem; font-size: 0.2rem; justify-content: flex-end">
        <div style="flex-grow: 1"></div>
        <div @click="open_by_key(item.openViewKey)" class="flex-column" style="padding: 0.1rem"
             v-for="(item, index) in appState.app.layoutItem.account_top" :key="index">
          <img class="img1x1" style="width: 0.5rem" :src="item.iconI18nKey"/>
          <span>{{ $t(item.titleI18nKey) }}</span>
        </div>
      </header>

      <div class="flex" style="height: 0.88rem;">
        <img @click="()=>{if(userState.isLoggedIn){open_by_key('avatar')}}" class="img1x1" style="width: 0.88rem;height: 0.88rem;border-radius: 50%;margin-right: 0.1333rem;"
             :src="userState.account?.avatar||un_login_avatar"/>
        <div class="flex" style="flex-direction: column;width: 100%;justify-content: space-between">
          <div>
            <span class="account">{{ $t("昵称") }}:</span>
            <span>{{ userState.account?.nickName || '???' }}</span>
          </div>
          <div class="flex-center"
               style="justify-content:space-between;width:100%;height: 0.32rem;line-height: 0.32rem;font-size: 0.32rem;flex-grow: 1;">
            <div><span>UID: </span>
              <span>{{ userState.account?.accountId||'????' }}</span>
              <i v-if="userState.account" class="fa-solid fa-copy" style="padding-left: 0.13rem" @click="copyToClipboard(userState.account?.accountId)"></i>
            </div>
            <div class="flex" style="align-items:center;padding-right: .5rem;" >
              <img class="img1x1" style="width: 0.32rem; height: 0.32rem;margin-right: .1rem;" :src="coin"/>
              <span class="info_id_Balance" >{{ CurrencyUtil.formatBy1000(userState.account?.balance) }}</span>
              <i v-if="userState.isLoggedIn" @click="userStore().refreshBalance()" class="fa-solid fa-arrows-rotate" style="padding-left: 0.13rem"/>
            </div>
          </div>
        </div>
      </div>

      <div class="flex-center" style="justify-content:space-around;padding: 0.2rem">
        <div @click="open_by_key(item.openViewKey)" class="flex-column"
            v-for="(item, index) in appState.app.layoutItem.account_hot" :key="index">
          <img class="img1x1" style="width: 0.5rem" :src="$t(item.iconI18nKey)"/>
          <span>{{ $t(item.titleI18nKey) }}</span>
        </div>
      </div>
    </div>
<!--

    <div class="vip" @click="open_by_key(ViewKeyDict.vip)">
      <div class="vip_main">
        <div class="vip_upper flex-center">
          <div class="rank flex-center">
            <span>{{ 'VIP'+(userState.account?.vipLevel||'?') }}</span>
          </div>
          <p style="flex-grow: 1">
            {{ $t("距离") }}
            <span class="">vip2</span>
            {{ $t("投注还差") }}
            <span>888</span>
          </p>
          <i class="fa-solid fa-chevron-right" style="color: var(&#45;&#45;main_font); padding: 0.2rem"/>
        </div>
        <div class="vip_mid flex-center">
          <div class="level">
            <span>{{ (userState.account?.vipLevel||'?') }}</span>
            <img src="/src/assets/images2/img_dj0.png" alt=""/>
          </div>
          <span class="illustrate">{{ $t("晋级再投注") }}</span>
          <div class="schedule">
            <p :style="{ width: '60px ' }"></p>
            <span>1200/1500</span>
          </div>
        </div>
      </div>
    </div>
-->

    <div class="container">
      <ul>
        <li @click="open_by_key(item.openViewKey)" v-for="(item, index) in appState.app.layoutItem.account_data" :key="index"
            :style=" index !== appState.app.layoutItem.account_data.length - 1 ? 'border-bottom: 0.015rem solid var(--f1)' : ''">
          <div>
            <img style="width: 0.5rem" :src="item.iconI18nKey"/>
            <span class="span-title">{{ $t(item.titleI18nKey) }}</span>
          </div>
          <div>
            <span v-show="item.subtitleI18nKey" style="color: var(--f3)">{{item.subtitleI18nKey}}</span>
            <i class="fa-solid fa-chevron-right" style="color: var(--f3)"></i>
          </div>
        </li>
      </ul>
    </div>
<!--
    <van-cell-group inset style="margin:.2rem 0;">
      <van-cell title="实名KYC" value="去实名" >
        <template #icon><div class="flex-center"><i class="fa-solid fa-credit-card"></i></div></template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(&#45;&#45;f3)"></i></div></template>
      </van-cell>
      <van-cell title="提现密码" value="去设置" >
        <template #icon><div class="flex-center"><i class="fa-solid fa-credit-card"></i></div></template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(&#45;&#45;f3)"></i></div></template>
      </van-cell>
    </van-cell-group>
    -->
<!--    <van-cell-group inset style="margin:.2rem 0;">
      <van-cell title="用户名" value="去设置">
        <template #icon><div class="flex-center"><i class="fa-solid fa-credit-card"></i></div></template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(&#45;&#45;f3)"></i></div></template>
      </van-cell>
      <van-cell title="手机号" value="去绑定">
        <template #icon><div class="flex-center"><i class="fa-solid fa-credit-card"></i></div></template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(&#45;&#45;f3)"></i></div></template>
      </van-cell>
      <van-cell title="谷歌" value="去绑定">
        <template #icon><div class="flex-center"><i class="fa-solid fa-credit-card"></i></div></template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(&#45;&#45;f3)"></i></div></template>
      </van-cell>
      <van-cell title="Facebook" value="去绑定">
        <template #icon><div class="flex-center"><i class="fa-solid fa-credit-card"></i></div></template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(&#45;&#45;f3)"></i></div></template>
      </van-cell>
    </van-cell-group>-->

    <van-cell-group inset style="margin:.2rem 0;">
      <van-cell  @click="open_by_key(item.openViewKey)"
                v-for="(item, index) in appState.app.layoutItem.account_other" :key="index">
        <template #icon><div class="flex-center"><img style="width: 0.5rem" :src="item.iconI18nKey"/></div></template>

        <template #title >
            <div class="flex" style="flex-shrink: 0;">{{ $t(item.titleI18nKey) }}</div>
            <div class="flex truncate"  style="padding-left: .1rem;flex:1;display: block;" v-show="item.subtitleI18nKey">{{item.subtitleI18nKey}}</div>
        </template>
        <template #right-icon><div class="flex-center"><i class="fa-solid fa-angle-right" style="color: var(--f3)"></i></div></template>
      </van-cell>
    </van-cell-group>



    <div v-if="userState.account" class="btn flex-center"  @click="logout_show=true;">{{ $t("退出登录") }}</div>
    <div v-else class="btn flex-center"  @click="userStore().toLogin()">{{$t("登录")}}</div>

    <!-- 退出登录 -->
    <van-dialog v-model:show="logout_show" :showConfirmButton="false">
      <p class="dialog2-title">{{ $t("温馨提示") }}</p>
      <p class="dialog2-content">{{ $t("是否退出当前账号") }}?</p>
      <div class="foot-btn">
        <button @click="userState.logout();logout_show = false">{{ $t("确认退出") }}</button>
        <button @click="logout_show = false">{{ $t("我点错了") }}</button>
      </div>
    </van-dialog>
  </div>
</template>

<style scoped lang="scss">
.btn {
  height: .8rem;
  background: var(--bg1);
  border-radius: 0.1333rem;
  box-shadow:  0 0 10px 0 var(--shadow);
}

.vip {
  padding: 0.1rem 0;
  .vip_main {
    border-radius: 0.1333rem;
    padding: 0.1267rem 0.16rem;
    background-color: var(--main);
  }
}
.rank {
  width: 0.8rem;
  height: 0.3333rem;
  border-radius: 0.1467rem 0 0.1467rem 0;
  background-color: var(--c1);
  span {
    font-weight: 700;
    font-style: italic;
  }
}
.vip_upper {
  p {
    margin-left: 0.2667rem;
    font-size: 0.24rem;

    span {
      font-weight: 700;
    }

    span:nth-of-type(1) {
      font-style: italic;
    }
  }
}

.vip_mid {
  height: 0.8667rem;
  margin-top: 0.1333rem;
  .level {
    width: 0.86rem;
    height: 0.86rem;
    background: url("src/assets/images2/color1.png") no-repeat 0 0 / 100% 100%;
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;

    span {
      font-size: 0.3333rem;
      font-weight: 700;
      color: var(--c2);
    }

    img {
      width: 0.8667rem;
      height: 0.8667rem;
      position: absolute;
    }
  }

  .illustrate {
    margin: 0 0.4rem 0 0.2rem;
    color: var(--f3);
  }

  .schedule {
    width: 60%;
    height: 0.24rem;
    overflow: hidden;
    background-color: var(--f2);
    border-bottom: 0.0133rem solid var(--shadow);
    border-radius: 0.1333rem;
    position: relative;

    p {
      height: 0.24rem;
      background-color: var(--c1);
    }

    span {
      position: absolute;
      top: 0;
      left: calc(50% - 0.2667rem);
      font-size: 0.1733rem;
    }
  }
}

// 弹出层
:deep(.van-dialog) {
  // 背景色
  --van-dialog-background: var(--bg1);
  --van-text-color: var(--f4);
  // 圆角
  --van-dialog-radius: 0.1333rem;
  overflow: unset;
  border: 0.0133rem solid var(--border);
}
// 复选框
:deep(.van-checkbox) {
  --van-checkbox-size: 0.3333rem;
}

.dialog2-title {
  color: var(--f3);
  padding: 0.1633rem;
  display: flex;
  font-size: 0.2933rem;
  justify-content: center;
}

.dialog2-content {
  margin-top: 0.1733rem;
  display: flex;
  justify-content: center;
  font-size: 0.24rem;
}

.foot-btn {
  margin: 0.4667rem 0 0.3333rem;
  display: flex;
  justify-content: space-evenly;
  button {
    font-size: 0.24rem;
    color: var(--c2_font);
    border: 0.0133rem solid var(--c2);
    border-radius: 0.1333rem;
    background-color: unset;
    padding: 0.1733rem 0.5733rem;
    &:nth-of-type(1) {
      color: var(--c2);
    }
    &:nth-of-type(2) {
      background-color: var(--c2);
    }
  }
}


</style>
