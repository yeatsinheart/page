<template>
  <div style="padding-top:.1rem;">
    <van-form @submit="()=>{}">
      <van-cell-group inset style="padding-bottom: .1rem;">
        <van-field v-model="form.loginName" :placeholder="$t('请输入账号')"
                   :rules="[{ required: true, message: $t('请输入账号') }]"
                   autocomplete="username" name="用户名" required>
          <template #label><i class="fa-solid fa-user"/></template>
        </van-field>
        <!-- 密码 -->
        <van-field v-model="form.credential" :placeholder="$t('请输入登录密码')"
                   :rules="[{validator: password_check }]"
                   :type="password_show ? '' : 'password'"
                   autocomplete="current-password" name="密码" required>
          <template #label>
            <i class="fa-solid fa-lock"></i>
          </template>
          <template #right-icon>
            <i :class="password_show?'fa-eye':'fa-eye-slash'" class="fa-solid " style="width: .25rem;"
               @click="password_show = !password_show"> </i>
          </template>
        </van-field>
        <Captcha v-model="form" action="login"/>
      </van-cell-group>
      <!-- 记住密码 -->
      <div style="color: var(--f2)">
        <van-checkbox v-model="remember_password" shape="square">{{ $t("记住密码") }}</van-checkbox>
      </div>
    </van-form>
    <button
        style="width: 100%;padding:10px;margin-top:.2rem;border-radius: 10px;
          background-color: var(--main);color: var(--main_font);border: none;"
        @click="onSubmit()">
      {{ $t("登录") }}
    </button>
  </div>
</template>

<script setup>
import {useI18n} from "vue-i18n";
import {ApiRequest} from "@/api/index.js";
import {userStore} from "@/config/store/user.js";
import Captcha from "@/view/ui/captcha/captcha.vue";
import {appStore} from "@/config/store/app.js";

const userState = userStore();
const {t} = useI18n();
const emit = defineEmits(["update:modelValue", "destroy"]);
const form = ref({})

const remember_password = ref(false);
const password_show = ref(false);

// 密码校验
const password_check = (val) => {
  // required: true 和 validator 不能一起使用，否则 validator 的自定义提示可能会失效。
  // required 具有更高的优先级，会先触发默认的“必填”校验，而 validator 只有在输入值不为空时才会生效。
  const trimmedVal = val.trim(); // 去除前后空格
  if (!trimmedVal) {
    return t("请输入登录密码");
  }
};

// 校验
const onSubmit = () => {
  if (userState.loginConfig?.captcha?.login) {
    if (!form.value.inputValue) {
      return;
    }
  }
  if (!form.value.loginName || !form.value.credential) {
    return;
  }
  let data = {
    "verifyId": form.value.verifyId,
    "inputValue": form.value.inputValue,
    "loginType": userState.loginType,
    "loginName": form.value.loginName,
    "credential": form.value.credential,
  };
  ApiRequest._1R7O9QTF(data).then(res => {
    userStore().login_success(res)
    emit("destroy");
  }).catch(err => {
    console.log(err);
  })
};

</script>

<style lang="scss" scoped>

</style>
