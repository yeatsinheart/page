<template>
  <div style="padding-top:.1rem;">
    <van-form @submit="()=>{}">
      <van-cell-group inset style="padding-bottom: .1rem;">
        <van-field v-model="form.loginName" :placeholder="$t('请输入手机号')"
                   :rules="[{ required: true, message: $t('请输入手机号') }]"
                   autocomplete="username"
                   class="phone" required type="tel">
          <template #label>
            <div class="flex" style="width:100%;color: var(--f3);" @click="country_select_show=!country_select_show">
              <img :src="country_chosen?.flag" style="width: .5rem;"/>
              <span style="padding-left: .1rem;">{{ country_chosen?.phoneCode }}</span>
            </div>
            <ul :style="country_select_show?'z-index:2;':'z-index: -1;height:0;opacity:0;'"
                style="transition: all .3s;position: absolute;top: .5rem; left: .2rem;border-radius: 10px;
                  background-color: var(--bg);">
              <li v-for="(item, index) in appState.app?.countryList" :key="index" class="flex" style="color: var(--f3);"
                  @click="country_choose(index)">
                <img :src="item.flag" alt="" style="width: .5rem;"/>
                <span style="padding-left: .1rem;">{{ item?.phoneCode }}</span>
              </li>
            </ul>
          </template>
        </van-field>

        <div class="flex" style="margin-bottom: .12rem;">
          <div class="flex" @click="type = 'password'">
            <div style="margin-right: .1rem;">
              <i class="fa-solid fa-lock"></i>
            </div>
            <span :style="type==='password'?'color:var(--main)':''">{{ $t("密码登录") }}</span>
          </div>

          <div class="flex" @click="type = 'sms'" style="margin-left: .4rem;">
            <div style="margin-right: .1rem;">
              <span class="bg_span">123</span>
            </div>
            <span :style="type==='sms'?'color:var(--main)':''">{{ $t("短信登录") }}</span>
          </div>
        </div>

        <!--手机号登录 切换密码/验证码 -->
        <van-field v-if="type==='sms'" v-model="form.inputValue"
                   :rules="[{ required: true, message: $t('验证码不能为空') }]" :placeholder="$t('请输入短信验证码')"
                   required type="digit">
          <template #label>
            <i class="fa-solid fa-comment-sms"></i>
          </template>
          <template #right-icon>
            <span @click="openby('/ui/popup/close_bottom','/account/auth/wg/phone-sms',form,)">
              {{ $t("获取短信验证码") }}
            </span>
          </template>
        </van-field>
        <!-- 密码 -->
        <van-field v-if="type==='password'" v-model="form.credential" :placeholder="$t('请输入登录密码')"
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
        <!-- 短信登录 没有 登录行为验证码 -->
        <Captcha v-if="type==='password'" v-model="form" action="login"/>
      </van-cell-group>
      <!-- 记住密码 -->
      <div v-if="type==='password'" style="color: var(--f2)">
        <van-checkbox v-model="remember_password" shape="square">{{ $t("记住密码") }}</van-checkbox>
      </div>
      <button
          style="width: 100%;padding:10px;margin-top:.2rem;border-radius: 10px;
          background-color: var(--main);color: var(--main_font);border: none;"
          @click="onSubmit">
        {{ $t("登录") }}
      </button>
    </van-form>
  </div>
</template>

<script setup>
import {useI18n} from "vue-i18n";
import {ApiRequest} from "@/api/index.js";
import {userStore} from "@/config/store/user.js";
import {appStore} from "@/config/store/app.js";
import Captcha from "@/view/ui/captcha/captcha.vue";
import {ref} from "vue";
import {openby} from "@/tool/pop.js";

const appState = appStore();
const userState = userStore();
const {t} = useI18n();
const emit = defineEmits(["update:modelValue", "destroy"]);
const form = ref({})
const type = ref("password");
const remember_password = ref(false);
const password_show = ref(false);

// 国家选择
const country_chosen = ref({});

const country_select_show = ref(false);

const country_choose = (index) => {
  country_chosen.value = appState.app?.countryList?.[index];
  country_select_show.value = false;
};
onBeforeMount(() => {
  country_chosen.value = appState.app?.countryList?.[0];
})
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
  /*if (userState.loginConfig?.captcha?.login) {
    if (!form.value.inputValue) {
      return;
    }
  }*/
  if (!form.value.loginName || !form.value.credential ) {
    return;
  }
  let data = {
    "verifyId": form.value.verifyId,
    "inputValue": form.value.inputValue,
    "loginType": userState.loginType,
    "loginName": country_chosen.value.phoneCode+"@"+form.value.loginName,
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
.phone {
  :deep(.van-field__label) {
    width: initial;
    border-right: 1px solid var(--border);
  }
}


li {
  padding: .12rem;
  border-bottom: 1px solid var(--border);
  &:nth-last-child(n){
    border-bottom: none;
  }
}

</style>
