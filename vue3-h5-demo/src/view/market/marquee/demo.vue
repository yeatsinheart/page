<script setup>
import { appStore } from "@/config/store/app.js";

const appState = appStore();

import { ref, onMounted } from "vue";
import {open_by_key} from "@/view.js";

const marqueeContainer = ref(null);
const marqueeContent = ref(null);

onMounted(() => {
  // 获取内容和容器宽度
  const contentWidth = marqueeContent.value.offsetWidth;
  const containerWidth = marqueeContainer.value.offsetWidth;

  // 设置一个基础速度，比如每秒滚动50像素
  const speed = 50; // 每秒滚动50px，可以根据需要调整

  // 计算动画时间：内容宽度加上容器宽度（确保内容完全滚出视口）
  const animationDuration = (contentWidth + containerWidth) / speed;

  // 动态设置 CSS 变量，控制动画时间
  marqueeContent.value.style.animationDuration = `${animationDuration}s`;
});
</script>

<template>
  <div class="notice flex-center">
    <!--    <van-notice-bar left-icon="volume-o" style="font-size: .22rem">-->
    <!--  循环8次，到一半就从新开始 方便收尾能衔接上    -->
    <div
      class="flex-center"
      @click="open_by_key('announce')"
      style="flex-grow: 1; max-width: 6.5rem"
    >
      <div class="flex-center" style="padding: 0 0.2rem; height: 100%">
        <i class="fa-solid fa-volume-high"></i>
      </div>
      <div class="marquee" ref="marqueeContainer">
        <div class="marquee-content" ref="marqueeContent">
          <!--    8份滚动 绝对能一直滚不会留白    -->
          <template v-for="index in 8" :key="index">
            <template
              v-for="data in appState.app.announceList"
              :key="data.title"
            >
              <span>{{ data.title }}</span>
            </template>
          </template>
        </div>
      </div>
    </div>

    <div
      class="flex-center"
      @click="open_by_key('message')"
      style="padding: 0 0.2rem; height: 100%"
    >
      <i class="fa-solid fa-envelope"></i>
    </div>

    <!--    </van-notice-bar>-->
  </div>
</template>

<style scoped lang="scss">
.notice {
  height: 0.6rem;
}

.marquee {
  width: 100%;
  overflow: hidden;
  white-space: nowrap;
  position: relative;
}

.marquee-content {
  display: inline-flex;
  animation: marquee linear infinite;
  /* 默认动画持续时间，将在脚本中动态更新 */
}

.marquee-content span {
  padding: 0 0.4rem; /* 内容之间的间隔 */
}

@keyframes marquee {
  0% {
    transform: translateX(0); /* 从起点开始 */
  }
  100% {
    transform: translateX(-50%); /* 滚动内容宽度，形成循环 */
  }
}
</style>
