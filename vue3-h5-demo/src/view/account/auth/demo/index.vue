<script setup>
import {appStore} from "@/config/store/app.js";
import {userStore} from "@/config/store/user.js";
import OAuth from "./o-auth.vue";
import {useRoute} from "vue-router";
import LoginByPhone from "./login-by-phone.vue";
import RegisterByPhone from "./register-by-phone.vue";
import LoginByName from "./login-by-name.vue";
import RegisterByName from "./register-by-name.vue";

const route = useRoute();
const emit = defineEmits();
const {props} = defineProps({props: null});

const appState = appStore();
const userState = userStore();

const action = ref("login");
onBeforeMount(() => action.value = props?.action || route.query?.action || "login");

// 刷新登录配置
watch(() => action.value, () => userState.how2Login(), {immediate: true});

// 监听 已登录 就直接销毁登录注册弹窗
watch(() => userState.isLoggedIn, () => {
  emit("destroy");
});

</script>

<template>
  <div>
    <img v-if="appState.app?.info?.register_img" :src="appState.app?.info?.register_img"
         style="width: 100%;object-fit:cover;">
    <div class="dashboard">
      <van-tabs v-model:active="action">
        <!-- 注册 -->
        <van-tab name="register">
          <template #title>
            <div class="flex-center" style="height: 100%;">
              <i class="fa-solid fa-user"></i>
              <span style="padding:0 5px;">{{ $t("注册") }}</span>
            </div>
          </template>
        </van-tab>
        <!-- 登录 -->
        <van-tab name="login">
          <template #title>
            <div class="flex-center" style="height: 100%;">
              <i class="fa-sharp-duotone fa-solid fa-arrow-right-to-bracket"/>
              <span style="padding:0 5px;">{{ $t("登录") }}</span>
            </div>
          </template>
        </van-tab>
      </van-tabs>

      <template v-if="userState.loginType === 'phone'">
        <LoginByPhone v-if="action === 'login'"/>
        <RegisterByPhone v-if="action === 'register'"/>
      </template>

      <template v-if="userState.loginType === 'name'">
        <LoginByName v-if="action === 'login'"/>
        <RegisterByName v-if="action === 'register'"/>
      </template>


      <!-- 切换登录方式 -->
      <van-divider style="margin: .2rem "  v-if="userState.loginConfig?.howToLogin?.activeForm?.length > 1">
        <div class="changeType" @click="userState.loginType = userState.loginType === 'name' ? 'phone' : 'name';">
          <span>
            {{ $t(`通过${userState.loginType === "phone" ? "用户名" : "手机号"}${action === 'login' ? "登录" : "注册"}`) }}
          </span>
        </div>
      </van-divider>

      <OAuth/>

      <div class="flex-center">
      <span @click="view_route_by_key('customer')" style="padding: .2rem">
        {{ $t("联系客服") }}
      </span>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.dashboard {
  //background-color: var(--bg1);
  padding: 0 .2rem;
  --van-tab-text-color: var(--f2);
  --van-tab-active-text-color: var(--main);

  :deep(.van-tabs__nav--line) {
    background: unset;
  }

  :deep(.van-tabs__line) {
    background: var(--main)
  }
}

:deep(.van-tab__text--ellipsis) {
  height: 100%;
}

:deep(.van-form) {
  --van-checkbox-label-color: var(--f2);
  // 输入框背景
  --van-cell-group-background: none;
  /*// 输入框左侧图标宽
  --van-field-label-width: .46rem;*/
  // 输入框外边距
  --van-cell-group-inset-padding: 0;
}

:deep(.van-field__label) {
  width: .5rem;
  margin-right: .1rem;
  border: 0;
  display: flex;
  align-items: center;
}

:deep(.van-field__label--required:before) {
  position: relative;
  top: 0.06rem;
}

:deep(.van-cell-group--inset) {
  overflow: unset;
  border-radius: initial;
}


// 校验错误提示
:deep(.van-field__error-message) {
  position: absolute;
  top: 20px;
  color: var(--error);
}

:deep(.van-cell) {
  //   字体颜色
  --van-field-input-text-color: var(--f4);
  background: unset;
  // position: unset;
  border: 1px solid var(--main);
  border-radius: 7px;
  padding: .12rem; // 调整输入框大小
  font-size: 20px;
  margin-bottom: .2rem;
  overflow: unset;

  &::after {
    border: none;
  }
}

// 记住密码按钮
:deep(.van-checkbox__icon) {
  font-size: 20px;
  border-radius: 10px;
}

</style>
