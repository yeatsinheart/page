<script setup>
import {open_by_key} from "@/view.js";

import {appStore} from "@/config/store/app.js";
import { useRoute } from "vue-router";
const route = useRoute();

const isActive = (callKey) => {
  return route.path === callKey || ("/" === route.path && "/home" === callKey);
};

const params = defineProps({modelValue: null});
</script>

<template>
  <div class="bottom-bar max-width flex" v-if="modelValue">
    <div class="flex bottom-tab-item" v-for="layoutItem in appStore().app.layoutItem.bar_bottom"
         :key="layoutItem.titleI18nKey" @click="open_by_key(layoutItem.openViewKey)">
      <img class="img1x1" :src="isActive('/' + layoutItem.openViewKey)
            ? layoutItem.iconFocusI18nKey ? $t(layoutItem.iconFocusI18nKey) : $t(layoutItem.iconI18nKey)
            : $t(layoutItem.iconI18nKey)
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
