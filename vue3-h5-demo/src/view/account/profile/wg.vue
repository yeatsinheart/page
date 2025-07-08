<script setup>
import { useRouter } from "vue-router";
import {userStore} from "@/config/store/user.js";

import {useI18n} from "vue-i18n";
import {view_route_by_key} from "@/tool/View.js";
const {t} = useI18n();

const router = useRouter();
const currentDate = ref(["2021", "01", "01"]);
const minDate = new Date(2020, 0, 1);
const maxDate = new Date();
const show = ref(false);

const copyToClipboard = async () => {
  try {
    await navigator.clipboard.writeText("要复制的文本内容");
    showSuccessToast(t("复制成功"));
  } catch (err) {
    console.error("复制失败", err);
  }
};
const confirm=(i)=>{
  show.value=false
}
</script>

<template>
  <div style="height: 100%">
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div class="flex-center">
        {{$t('账号资料')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="view_route_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <div class="profilewg flex" style="flex-direction: column">
      <div class="top">
        <img :src="userStore().account?.avatar" alt=""/>
        <div>
          <span>UID:{{ userStore().account?.accountId }}</span>
          <i class="fa-solid fa-copy" @click="copyToClipboard" ></i>
        </div>
      </div>
      <div class="item">
        <i class="fa-solid fa-user"></i>
        <input type="text" :placeholder="$t('请输入昵称')" />
      </div>
<!--      <div class="item">
        <i class="fa-solid fa-phone-volume"></i>
        <input type="text" placeholder="请输入手机号" />
        <p>关联</p>
      </div>-->

      <div class="time">
        <p>{{$t("生日 (设置后不可修改)")}}</p>
        <div @click="show = true">
          <span>{{currentDate[0]+'-'+currentDate[1]+"-"+currentDate[2]}}</span>
          <i class="fa-solid fa-chevron-down"></i>
        </div>
      </div>

    </div>
    <van-action-sheet v-model:show="show" :title="$t('选择时间')" :closeable="false" class="max-width">
      <van-date-picker class="max-width"
          v-model="currentDate"
          :min-date="minDate"
          :max-date="maxDate"
          @cancel="show=false"
          @confirm="confirm"
      />
    </van-action-sheet>
    <div class=" bombum">{{$t('确认')}}</div>
  </div>

</template>

<style lang="scss" scoped>
.profilewg {
  padding: 0 10px 5px 10px;
  border-top: 1px solid var(--border);
  .top {
    height: 70px;
    display: flex;
    margin: 15px;
    align-items: center;
    img {
      width: 70px;
      margin-right: 15px;
    }
    div {
      display: flex;

      span {
        margin-right: 5px;
      }
      .i-icon {
        font-size: 18px;
        color: var(--main);
      }
    }
  }
  .item {
    height: 40px;
    display: flex;
    align-items: center;
    padding: 5px 10px;
    border-radius: 6px;
    margin: 30px 0;
    border: 1px solid var(--border);
    input {
      background: unset;
      border: none;
      font-size: 16px;
      width: 80%;
    }
    span {
      font-size: 20px;
      margin-top: 5px;
      margin-right: 10px;
      color: var(--f2);
    }
    p {
      color: var(--main);
    }
  }
  .time {
    div {
      height: 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 5px 10px;
      border-radius: 6px;
      margin: 10px 0;
      border: 1px solid var(--border);
    }
  }
}
:deep(.van-popup){
  width: 100%;
  max-width: calc(var(--theme-max-width));
  left:50%;transform:translate(-50%, -0%);
  bottom: 0rem;
}
.bombum {
  position: fixed;
  width:90%;
  max-width: calc(var(--theme-max-width) * 0.9);
  left:50%;transform:translate(-50%, -0%);
  bottom: .2rem;
  line-height: 40px;
  text-align: center;
  background: var(--main_linear_to);
  color: var(--main_font);
  border-radius: 8px;
}

</style>
