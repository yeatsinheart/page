<template>
  <div>
    <Head title="实名认证"></Head>
    <!-- 校验 -->
    <div class="content">
      <van-form ref="refForm" @submit="onSubmit">
        <van-cell-group inset>
          <!-- 账号 -->
          <van-field
            v-model="account"
            required
            name="用户名"
            :placeholder="$t('请输入账号')"
            :rules="[{ required: true, message: $t('请输入账号') }]"
          >
            <template #label>
              <i class="fa-solid fa-user"></i>
            </template>
          </van-field>
          <!-- 身份证号 -->
          <van-field
            v-model="numberID"
            required
            name="密码"
            placeholder="请输入身份证号码"
            :rules="[{ validator: valNumberID }]"
          >
            <template #label>
              <i class="fa-duotone fa-solid fa-lock"></i>
            </template>
          </van-field>
        </van-cell-group>
      </van-form>
      <div class="id_warning">
        <span>{{ $t("上传身份证照片") }}</span>
        <i class="fa-solid fa-circle-exclamation"></i>
        <span>{{ $t("注意事项") }}</span>
      </div>
      <div class="Filming">
        <video ref="video" autoplay class="video"></video>

        <!-- 拍摄后的图片（覆盖在视频上） -->
        <img v-if="photo" :src="photo" alt="身份证照片" class="photo-overlay" />

        <!-- 拍摄按钮（覆盖在视频上） -->
        <button @click.stop="takePhoto" class="capture-button">拍摄</button>
      </div>
      <div class="hint">
        <p>{{ $t("温馨提示") }}:</p>
        <p>
          {{ $t("无法通过认证") }}? <span>{{ $t("点击获取帮助") }}?</span>
        </p>
        <p></p>
      </div>
      <button @click="check" class="submit">{{ $t("确认提交") }}</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import { useI18n } from "vue-i18n";
const { t } = useI18n();

const refForm = ref();
const account = ref("");
const numberID = ref("");

// 身份证校验
const valNumberID = (val) => {
  if (!val) {
    return t("身份证号不能为空");
  }
};

const video = ref(null);
const canvas = ref(null);
const photo = ref(null);

let stream = null;

const initCamera = async () => {
  try {
    stream = await navigator.mediaDevices.getUserMedia({
      video: { facingMode: "environment" },
    });
    if (video.value) {
      video.value.srcObject = stream;
    }
  } catch (error) {
    console.error("无法访问摄像头：", error);
  }
};

const takePhoto = () => {
  console.log("123");
  if (video.value && canvas.value) {
    const context = canvas.value.getContext("2d");
    canvas.value.width = video.value.videoWidth;
    canvas.value.height = video.value.videoHeight;
    context.drawImage(
      video.value,
      0,
      0,
      canvas.value.width,
      canvas.value.height
    );

    // 将图片保存为 base64 数据
    photo.value = canvas.value.toDataURL("image/jpeg");
  }
};

onMounted(() => {
  initCamera();
});
onUnmounted(() => {
  if (stream) {
    stream.getTracks().forEach((track) => track.stop());
  }
});
// 校验

const check = () => {
  refForm.value.submit();
};

const onSubmit = () => {
  console.log("提交通过123");
};
</script>

<style lang="scss" scoped>
// 校验表单
:deep(.van-form) {
  // 输入框背景
  --van-cell-group-background: none;
  // 输入框左侧图标宽
  --van-field-label-width: 30px;
  // 输入框外边距
  --van-cell-group-inset-padding: 0;
}
:deep(.van-cell-group--inset) {
  overflow: unset;
}
// 校验错误提示
:deep(.van-field__error-message) {
  position: absolute;
  top: 40px;
  color: var(--error);
  font-size: 18px;
}
:deep(.van-cell) {
  //   字体颜色
  --van-field-input-text-color: var(--f4);
  background: unset;
  position: unset;
  border: 1px solid var(--border);
  border-radius: 7px;
  padding: 10px;
  font-size: 20px;
  margin-bottom: 25px;
  overflow: unset;
  &::after {
    border: none;
  }
}
.content {
  padding: 10px;
  margin: 12px;
  .id_warning {
    margin: 20px 0;
    padding-top: 20px;
    font-size: 20px;
    border-top: 1px solid var(--border);
    display: flex;
    align-items: center;
    span:nth-of-type(1) {
      color: var(--f4);
      margin-right: 25px;
    }
    span:nth-of-type(2) {
      margin-left: 5px;
      font-size: 18px;
    }
  }
}
.Filming {
  margin-top: 20px;
  video {
    width: 45%;
    height: 150px;
    border-radius: 10px;
    border: 1px solid #ddd;
    object-fit: cover;
    position: relative;
  }
  /* 图片覆盖样式 */
  .photo-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: 2;
    border-radius: 8px;
  }
}
.hint {
  p:nth-of-type(1) {
    color: var(--f4);
    font-size: 20px;
  }
  p:nth-of-type(2) {
    text-align: center;
    margin: 15px 0;
    font-size: 18px;
  }
  span {
    margin-left: 5px;
    color: var(--main);
  }
}
.submit {
  width: 100%;
  height: 55px;
  border: none;
  font-size: 18px;
  border-radius: 30px;
  color: var(--main_font);
  background: var(--main);
}
</style>
