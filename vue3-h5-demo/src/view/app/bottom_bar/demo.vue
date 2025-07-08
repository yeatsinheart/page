<script setup>
import {open_by_key} from "@/view.js";

import { useRoute } from "vue-router";
const route = useRoute();

const isActive = (callKey) => {
  return route.path === callKey || ("/" === route.path && "/home" === callKey);
};

const bar_bottom=[
  {titleI18nKey:"首页",logoI18nKey:"https://x4.runtu123.com/0/global/1741121380209_icon_btm_sy.avif",openViewKey:"/"},
  {titleI18nKey:"活动",logoI18nKey:"https://x1.runtu123.com/0/global/1741121380836_icon_btm_yh.avif",openViewKey:"bonus"},
  {titleI18nKey:"我的",logoI18nKey:"https://x2.runtu123.com/0/global/1741121383066_icon_btm_wd.avif",openViewKey:"me"},
]
const canShow = () => {
  return bar_bottom.some((item) => {
    return route?.path === "/" || "/" + item.openViewKey === route?.path;
  });
};

</script>

<template>
  <div class="bottom-bar max-width flex" v-if="canShow()">
    <div class="flex bottom-tab-item" v-for="layoutItem in bar_bottom" :key="layoutItem.title" @click="open_by_key(layoutItem.openViewKey)">
      <img class="img1x1" :src="isActive('/' + layoutItem.openViewKey)
            ? layoutItem.iconFocus ? $t(layoutItem.logoFocusI18nKey) : $t(layoutItem.logoI18nKey)
            : $t(layoutItem.logoI18nKey)
        "
      />
      <span class="bottom-tab-item-title" :style="isActive('/' + layoutItem.openViewKey) ? 'color:var(--main)' : ''">
        {{ $t(layoutItem.titleI18nKey) }}
      </span>
    </div>
  </div>
</template>

<style scoped lang="scss">
.bottom-bar {
  z-index: 5;
  height: 1.24rem;
  width: 100%;
  padding-bottom: env(safe-area-inset-bottom);
  background: var(--bg2);
  position: fixed;
  bottom: 0;
}

.bottom-tab-item {
  align-items: center;
  cursor: pointer;
  -ms-flex: 1;
  flex: 1;
  -ms-flex-direction: column;
  flex-direction: column;
  line-height: 1;
  color: var(--f3);
  font-size: 0.24rem;
  justify-content: flex-end;
  img {
    width: 0.5rem; height: 0.5rem;
  }
}

.bottom-tab-item-title {
  word-wrap: break-word;
  white-space: pre-wrap;
  height: 0.56rem; /*.54rem*/
  line-height: 1.2;
  overflow: hidden;
  padding: 0 0.05rem;
  text-align: center;
  text-overflow: ellipsis;
  vertical-align: middle;
}
</style>
