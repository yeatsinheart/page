<template>
  <div style="padding-top:.1rem;">
    <van-form @submit="()=>{}">
      <van-cell-group inset style="padding-bottom: .1rem;">
        <van-field v-model="form.loginName" :placeholder="$t('请输入账号')"
                   :rules="[{ required: true, message: $t('请输入账号') }]"
                   :name="'disable_autofill_'+Math.random()"  autocomplete="one-time-code" required>
          <template #label><i class="fa-solid fa-user"/></template>
        </van-field>
        <!-- 密码 -->
        <van-field v-model="form.credential" :placeholder="$t('请输入登录密码')"
                   :rules="[{validator: password_check }]"
                   :type="password_show ? '' : 'password'"
                   :name="'disable_autofill_'+Math.random()"  autocomplete="one-time-code" required>
          <template #label>
            <i class="fa-solid fa-lock"></i>
          </template>
          <template #right-icon>
            <i :class="password_show?'fa-eye':'fa-eye-slash'" class="fa-solid " style="width: .25rem;"
               @click="password_show = !password_show"> </i>
          </template>
        </van-field>
        <!-- 确认密码 -->
        <van-field v-model="password_repeat" :placeholder="$t('请再次输入密码')"
                   :rules="[{validator: password_repeat_check }]"
                   :type="password_show ? '' : 'password'"
                   :name="'disable_autofill_'+Math.random()"  autocomplete="one-time-code" required>
          <template #label>
            <i class="fa-solid fa-lock"></i>
          </template>
          <template #right-icon>
            <i :class="password_show?'fa-eye':'fa-eye-slash'" class="fa-solid " style="width: .25rem;"
               @click="password_show = !password_show"> </i>
          </template>
        </van-field>
<!--        <InviteCode v-model="form.inviteCode"></InviteCode>-->
<!--        <Captcha v-model="form" action="register"/>-->
      </van-cell-group>
      <button
          style="width: 100%;padding:10px;margin-top:.2rem;border-radius: 10px;
          background-color: var(--main);color: var(--main_font);border: none;"
          @click="onSubmit">
        {{ $t("注册") }}
      </button>
    </van-form>
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

const password_show = ref(false);
const password_repeat = ref("");

// 密码校验
const password_repeat_check=(val)=>{
  const trimmedVal = val.trim(); // 去除前后空格
  if (!trimmedVal) {
    return t("请再次输入密码");
  }
  if(trimmedVal!==form.value.credential){
    return t("两次密码输入不同");
  }
}
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
  /*if (userState.loginConfig?.captcha?.register) {
    if (!form.value.inputValue) {
      return;
    }
  }*/
  if (!form.value.loginName || !form.value.credential || form.value.credential!==password_repeat.value) {
    return;
  }
  let data = {
    "verifyId": form.value.verifyId,
    "inputValue": form.value.inputValue,
    "loginType": userState.loginType,
    "loginName": form.value.loginName,
    "credential": form.value.credential,
  };
  ApiRequest._Em27Dk37(data).then(res => {
    userStore().login_success(res)
    emit("destroy");
  }).catch(err => {
    console.log(err);
  })
};

</script>

<style lang="scss" scoped>

</style>
