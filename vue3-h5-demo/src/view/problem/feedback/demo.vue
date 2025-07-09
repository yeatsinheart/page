<script setup>
import { ref } from "vue";
import router from "@/config/router/index.js";

const tabActive = ref(0);
// 类型列表
const feedbackTypeList = ref();
const feedbackType = ref("");
const showTypeList = ref(false);

const changeType = (value) => {
  feedbackType.value = value;

  showTypeList.value = false;

  console.log(showTypeList.value, feedbackType.value);
};

const feedbackContent = ref("");
// 上传图片
const fileList = ref();
// 上传图片前置处理
const beforeRead = () => {
  console.log("123");
  return true;
};
</script>

<template>
  <div style="height: 100%">
    <!-- 头部 -->
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div class="flex-center">
        {{$t('反馈中心')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="open_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <div @click="showTypeList = false" class="feedback">
      <div class="feedback_tabs">
        <button
          v-for="(item, index) in ['创建反馈', '我的反馈']"
          :key="index"
          @click="tabActive = index"
          type="button"
          class="ant-btn"
          :class="{ button_active: tabActive === index }"
        >
          {{ $t(item) }}
        </button>
      </div>
      <div class="feedback_main">
        <p class="feedback_main_title">{{ $t("反馈类型") }}</p>
        <div
          @click.stop="showTypeList = true"
          class="feedback_main_type"
          :style="{
            border: showTypeList
              ? '1px solid var(--main)'
              : ' 1px solid var(--border)',
          }"
        >
          <span :style="{ color: feedbackType ? 'var(--f4)' : 'var(--f2)' }">
            {{ feedbackType || $t("请选择反馈类型") }}
          </span>
          <van-icon name="arrow-down" :class="{ type_icon: showTypeList }" />
          <ul class="type_list" :class="{ type_list_active: showTypeList }">
            <li
              @click.stop="changeType(index)"
              v-for="(item, index) in 10"
              :key="index"
            >
              {{ $t("游戏充值") }}
            </li>
          </ul>
        </div>
        <p class="feedback_main_title">
          {{ $t("反馈内容 ") }}
          <span>({{ $t("修改建议") }})</span>
        </p>
        <van-cell-group inset>
          <van-field
            v-model="feedbackContent"
            rows="2"
            autosize
            type="textarea"
            maxlength="200"
            placeholder="请输入留言"
            show-word-limit
          />
        </van-cell-group>
        <p class="feedback_main_title">
          {{ $t("有图有真相") }}
          <span>({{ $t("更容易被采纳") }})</span>
        </p>
        <van-uploader
          v-model="fileList"
          :before-read="beforeRead"
          multiple
          :max-count="5"
        />
        <p class="feedback_main_subTitle">
          {{ $t("支持图片和视频格式,大小不超过50px") }}
        </p>

        <p class="feedback_main_title">
          {{ $t("奖励规则") }}
        </p>
        <p class="feedback_main_subTitle">
          我们专门设置了巨额奖励，用于收集反馈，以便我们优化系统和功能，为您提供更好的体验！一旦采纳，将根据实用性给予奖励（未采纳的除外）
        </p>
      </div>
    </div>
    <div class="feedback_foot">
      <button>{{ $t("提交反馈") }}</button>
    </div>
  </div>
</template>

<style lang="scss" scoped>
:deep(.van-icon) {
  font-size: 18px;
  transform: rotate(0deg);
  transition: all 0.5s;
}
:deep(.van-cell-group) {
  margin: 0;
  border: 1px solid var(--border);
  background: unset;
}
:deep(.van-field) {
  background: unset;
}
// 文字反馈
:deep(.van-field__control) {
  height: 120px !important;
  font-size: 12px;
  color: var(--f4);
}
// 图片上传
:deep(.van-uploader__upload) {
  width: 80px;
  height: 80px;
  background: unset;
  border: 1px solid var(--border);
  border-radius: 5px;
}
.feedback {
  width: 100%;
  padding: 15px 12px 0;
  box-sizing: border-box;
}
.feedback_tabs {
  display: flex;
  width: 100%;
  button {
    width: 100px;
    height: 30px;
    border: var(--border);
    background-color: var(--bg1);
    color: var(--f3);
    margin-right: 15px;
    border-radius: 20px;
  }
  .button_active {
    background-color: var(--main);
    color: var(--f4);
  }
}
.feedback_main {
  width: 100%;
  height: 580px;
  margin-top: 15px;
  padding: 5px 10px;
  background-color: var(--bg1);
  border-radius: 10px;
  box-sizing: border-box;
  .feedback_main_title {
    font-size: 15px;
    margin: 15px 0 10px;
    span {
      color: var(--f2);
      margin-left: 10px;
    }
  }
  .feedback_main_subTitle {
    color: var(--f2);
  }
  .feedback_main_type {
    width: 100%;
    height: 45px;
    margin-top: 10px;
    border: 1px solid var(--border);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 10px;
    color: var(--f2);
    box-sizing: border-box;
    position: relative;
  }
  .type_icon {
    transform: rotate(180deg);
  }
  .type_list {
    width: 100%;
    height: 0px;
    opacity: 0;
    color: var(--f2);
    border: 1px solid var(--border);
    border-radius: 10px;
    position: absolute;
    top: 45px;
    left: 0;
    background-color: var(--bg1);
    box-sizing: border-box;
    z-index: 2;
    overflow-y: auto;
    transition: all 0.5s;
    li {
      height: 50px;
      line-height: 50px;
      width: 100%;
      margin-left: 10px;
      box-sizing: border-box;
    }
  }
  .type_list_active {
    height: 300px;
    opacity: 1;
  }
}
.feedback_foot {
  width: 100%;
  height: 100px;
  margin: 10px 0 50px;
  padding: 10px;
  box-sizing: border-box;
  background-color: var(--bg1);
  button {
    width: 100%;
    height: 45px;
    border: none;
    border-radius: 10px;
    background-color: var(--main);
  }
}
</style>
