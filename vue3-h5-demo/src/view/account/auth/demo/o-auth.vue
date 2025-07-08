<script setup>

import {userStore} from "@/config/store/user.js";
import {ApiRequest} from "@/api/index.js";
import {appStore} from "@/config/store/app.js";

const userState = userStore();
const urlMap = ref({})

onBeforeMount(() => {
  userState.loginConfig?.howToLogin?.oauth?.forEach((item) => {
    ApiRequest._oauth({type:item.type,uri:"/oauth.html"}).then(res => {
      urlMap[item.type] = res;
    })
  })
})

function oauth(item) {
  if(urlMap[item.type]) {
    const loginWindow = openCenteredWindow(urlMap[item.type], 'loginWindow', 400, 600);
    window.addEventListener('message', (event) => {
      if (event.data && event.data.type === 'oauth-login-success') {
        loginWindow.close();
        ApiRequest._oauthCheck({type: item.type, callback: event.data.callback, inviteCode: null}).then((res) => {
          userStore().login_success(res)
        })
      }
    });
  }
}

function openCenteredWindow(url, title, w, h) {
  // 获取屏幕宽高
  const dualScreenLeft = window.screenLeft !== undefined ? window.screenLeft : screen.left;
  const dualScreenTop = window.screenTop !== undefined ? window.screenTop : screen.top;

  const width = window.innerWidth
      ? window.innerWidth
      : document.documentElement.clientWidth
          ? document.documentElement.clientWidth
          : screen.width;

  const height = window.innerHeight
      ? window.innerHeight
      : document.documentElement.clientHeight
          ? document.documentElement.clientHeight
          : screen.height;

  const left = (width / 2) - (w / 2) + dualScreenLeft;
  const top = (height / 2) - (h / 2) + dualScreenTop;

  const newWindow = window.open(url, title, `scrollbars=yes,resizable=yes, width=${w}, height=${h}, top=${top}, left=${left}`);

  // 聚焦新窗口
  if (window.focus) {
    newWindow.focus();
  }
  return newWindow;
}
</script>

<template>
  <!--
  方式 1：前端轮询 Session 状态	传统后端渲染、增强安全	适用于 HttpOnly Cookie，安全性高	轮询有额外请求
  方式 2：WebSocket 推送通知	桌面应用、WebSocket 支持	实时推送，不需要轮询	依赖 WebSocket 服务器
   -->
  <ul class="flex-center" style="justify-content: space-around">
    <li v-for="(item, index) in userState.loginConfig?.howToLogin?.oauth" :key="index">
      <img :src="item.icon" alt="" @click="oauth(item)"/>
    </li>
  </ul>
</template>

<style lang="scss" scoped>
img {
  width: .5rem;
  height: .5rem;
}
</style>