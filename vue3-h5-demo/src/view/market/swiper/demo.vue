<script setup>
import { appStore } from "@/config/store/app.js";

const appState = appStore();
</script>

<template>
  <div style="padding-bottom: 0.2rem; width: 100%; margin: 0 auto">
    <van-swipe class="my-swipe" :autoplay="3000" indicator-color="white">
      <template v-for="(data, index) in appState.app.swiperList" :key="index">
        <van-swipe-item v-if="data">
          <img :src="data.src" alt="" />
        </van-swipe-item>
      </template>
    </van-swipe>
  </div>
</template>

<style scoped lang="scss">
.my-swipe {
  /* 17:5 */
  /*width: 7rem;
  height: 2.0588rem;*/
  width: 100%;
  aspect-ratio: 17 /5;
  overflow: hidden;
  border-radius: 0.2rem;

  img {
    width: 100%;
    object-fit: contain;
  }

  :deep(.van-swipe__indicators) {
    /*background-color: var(--bg1);*/
    padding: 0.05rem;
    border-radius: 0.05rem;
  }

  :deep(.van-swipe__indicator) {
    background-color: var(--bg) !important;
    opacity: 0.8;
  }

  :deep(.van-swipe__indicator--active) {
    background-color: var(--main) !important;
    opacity: 100%;
  }
}
</style>
