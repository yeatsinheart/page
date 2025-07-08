<script setup>
import { ref } from "vue";

const footList = ref(0);

const questionActive = ref([1]);
const questionList = ref([
  { id: "1", icon: "", title: "帐户信息", url: "" },
  { id: "2", icon: "", title: "如何成为代理商", url: "" },
  { id: "3", icon: "", title: "提现问题", url: "" },
  { id: "4", icon: "", title: "存款问题回答", url: "" },
  { id: "5", icon: "", title: "游戏回答", url: "" },
]);

import { appStore } from "@/config/store/app.js";
import router from "@/router/index.js";
import {view_route_by_key} from "@/tool/View.js";
const appState = appStore();
</script>

<template>
  <div style="height: 100%">
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
<!--      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>-->
      <div></div>
      <div class="flex-center">
        {{$t('客服')}}
      </div>
      <div></div>
<!--
      <div class="flex-center" style="width: 1rem" @click="view_route_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>-->
    </div>

    <div style="padding: .2rem;">
      <div v-for="data in appState.app.customerList" :key="data.id" class="flex" style="gap:.1rem;padding-bottom: .1rem;">
        <img :src="data.logo" alt="" style="width: 1rem;height: 1rem" />
        <div class="flex" style="flex-direction: column;justify-content: space-around;">
          {{ data.title }}
          <div>
            <button style="background-color: var(--bg1);color: var(--c2);border: 1px solid var(--c2);cursor: pointer;">
              {{ $t("立即联系") }}
            </button>
          </div>
        </div>
      </div>

<!--      <div>
        <van-tabs v-model:active="footList" swipeable>
          <van-tab :title="$t('常问问题')">
            <template #default>
              <van-collapse v-model="questionActive">
                <van-collapse-item v-for="(item, index) in questionList" :name="item.id" :key="index">
                  <template #title>
                    <div>
                      <van-icon name="question-o" />
                      {{ item.title }}
                    </div>
                  </template>
                  <div>
                    <p>
                      1、 如何修改密码。
                    </p>
                  </div>
                </van-collapse-item>
              </van-collapse>
            </template>
          </van-tab>
          <van-tab :title="$t('热点关注')">
            <template #default>
              <van-collapse v-model="questionActive">
                <van-collapse-item v-for="(item, index) in questionList" :name="item.id" :key="index">
                  <template #title>
                    <div>
                      <van-icon name="question-o" />
                      {{ item.title }}
                    </div>
                  </template>
                  <div>
                    <p>
                      1、 如何修改密码。
                    </p>
                  </div>
                </van-collapse-item>
              </van-collapse>
            </template>
          </van-tab>
        </van-tabs>
      </div>-->
    </div>
  </div>
</template>

<style scoped lang="scss">
// tab栏
:deep(.van-tabs) {
  // 背景色
  --van-tabs-nav-background: var(--bg1);
  // 字体颜色
  --van-tab-text-color: var(--f2);
  // 选中字体颜色
  --van-tab-active-text-color: var(--c2);
  // 下划线颜色
  --van-tabs-bottom-bar-color: var(--c2);
}
:deep(.van-tab) {
  flex: 0 0 auto;
  margin-right: 10px;
}
:deep(.van-collapse) {
  // 背景色
  --van-cell-background: var(--bg1);
  // 字体颜色
  --van-cell-text-color: var(--f3);
  // 点击时背景色
  --van-cell-active-color: var(--bg1);
  // 弹出 背景色
  --van-collapse-item-content-background: var(--bg1);
  // 弹出 字体颜色
  --van-collapse-item-content-text-color: var(--f3);
  // 下边框颜色
  --van-border-color: var(--border);
}
</style>
