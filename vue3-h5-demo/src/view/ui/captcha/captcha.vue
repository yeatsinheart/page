<script setup>
import {userStore} from "@/config/store/user.js";
import {showToast} from "vant";
import {ref} from "vue";
import {ApiRequest} from "@/api/index.js";

const userState = userStore();
const emit = defineEmits(['update:modelValue', 'destroy'])

const props = defineProps({modelValue: null, action: null,})
const form = ref({verifyId:"",inputValue:""})
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => props.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(form.value)) {
        form.value.verifyId = newVal;
      }
    }
);
// 监听 form 的变化
watch(form, (newVal) => {
  if (JSON.stringify(newVal) !== JSON.stringify(props.modelValue)) {
    emit('update:modelValue', newVal);
  }
});

const action = ref("login")// register login sms

const captchaRef = ref(null); // 绑定验证码的 DOM
const captchaInstance = ref(null); // 存储验证码实例

// 引入网易易盾 SDK
const loadDun163Js = () => {
  return new Promise((resolve, reject) => {
    if (window.initNECaptcha) {
      resolve(window.initNECaptcha);
    } else {
      const script = document.createElement('script');
      script.src = 'https://cstaticdun.126.net/load.min.js';
      script.async = true;
      script.id = "网易云盾";
      script.onload = () => resolve(window.initNECaptcha);
      script.onerror = () => reject(new Error('网易易盾 SDK 加载失败'));
      document.body.appendChild(script);
    }
  });
};
// 初始化网易易盾滑动验证码
const initDun163Captcha = async (captchaId) => {
  if(!captchaId){return;}
  try {
    await loadDun163Js();
    window.initNECaptcha({
          // config对象，参数配置
          captchaId: captchaId,
          element: captchaRef.value,
          lang: "en",
          mode: 'popup',//常规验证码三种模式可选："float"、"embed"、"popup"，即触发式、嵌入式、弹出式。智能无感知验证码类型可设置"bind"模式，绑定自有按钮模式
          //popupStyles: {position: 'absolute', top: '25%'},
          width: '320px', apiVersion: 2,
          onVerify:function(err, data) {
            // 第一个参数是err（Error的实例），验证失败才有err对象 第二个参数是data对象，验证成功后的相关信息，data数据结构为key-value，如下：
            // verify: data.validate  // 验证成功的token
            if(data?.validate){
              form.value.inputValue=data.validate;
              console.log(data.validate,form.value);
            }
          },
        }, function onload(instance) {
          captchaInstance.value = instance;
          setTimeout(() => {instance.verify();}, 300);
          // 初始化成功后得到验证实例instance，可以调用实例的方法
        }, function onerror(err) {
          console.log(err);
          // 初始化失败后触发该函数，err对象描述当前错误信息
        }, function onReady(instance) {
          console.log("onReady")
          // 验证码一切准备就绪，此时可正常使用验证码的相关功能
        },
    );
  } catch (error) {
    showToast('验证码初始化失败');
  }
};
// 显示验证码
const showDun163Captcha = () => {
  // 如果已经初始化了验证码实例，先销毁，避免重复初始化
  if (captchaInstance.value) {
    captchaInstance.value.destroy();
    captchaInstance.value = null;
  }
  let captchaId = "";
  let captcha_info = userState.loginConfig?.captcha?.[action.value];
  if (captcha_info && captcha_info.startsWith("dun163@")) {
    captchaId = captcha_info.replace("dun163@", "");
  }
  // 重新初始化验证码
  initDun163Captcha(captchaId)
};

// 登录方式
const img_captcha_value = ref("");

function img_captcha() {
  ApiRequest._rwweKP6Q().then(res => {
    form.value.verifyId = res.verifyId;
    img_captcha_value.value = res.captchaImg;
  })
}

onBeforeMount(() => {
  form.value = props.modelValue || {verifyId:"",inputValue:""};
  action.value = props.action || "";
  if (userState.loginConfig?.captcha?.[action.value]?.startsWith('dun163')) {
    loadDun163Js();
  }
  if (userState.loginConfig?.captcha?.[action.value] === 'img') {
    img_captcha();
  }
})

</script>

<template>
  <div>
    <div v-if="userState.loginConfig?.captcha?.[action]?.startsWith('dun163')">
      <!-- dun163行为验证 -->
      <van-button block type="success" @click="showDun163Captcha">获取验证码</van-button>
      <!-- 验证码容器（隐藏） -->
      <div id="dun163" ref="captchaRef"  style="position:absolute;top:25%;left:0;width: 100%;" class="flex-center"></div>
    </div>
    <van-field v-else-if="userState.loginConfig?.captcha?.login==='img'"
               v-model="form.inputValue" required
               :placeholder="$t('请输入图片中的字符')" :rules="[{ required: true, message: $t('请输入验证码') }]">
      <template #label>
        <i class="fa-solid fa-user-check" style=""></i>
      </template>
      <template #right-icon>
        <img :src="img_captcha_value" style="height: .5rem;" @click="img_captcha()">
      </template>
    </van-field>
  </div>
</template>

<style lang="scss" scoped>

// 校验错误提示
:deep(.van-field__error-message) {
  position: absolute;
  top: 35px;
  color: var(--error);
}

:deep(.van-cell) {
  //   字体颜色
  --van-field-input-text-color: var(--f4);
  background: unset;
  // position: unset;
  border: 1px solid var(--main);
  border-radius: 7px;
  padding: 5px; // 调整输入框大小
  font-size: 20px;
  overflow: unset;
  &::after {
    border: none;
  }
}
:deep(.van-field__right-icon){
  display: flex;
}


</style>