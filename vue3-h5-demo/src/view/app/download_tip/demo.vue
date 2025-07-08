<script setup>
import {ref} from "vue";
import {appStore} from "@/config/store/app.js";

const download_show = ref(true);

</script>
<template>
    <div v-if="download_show" class="download">
      <div style="flex-grow: 1; padding-left: 0.2rem">
        <img :src="appStore().app.info.download_img7x1" style="height: 0.51rem"/>
      </div>
      <div>
        <p style=" background: var(--c1);color: var(--c1_font);border-radius: 0.07rem;padding: 0.1rem 0.2rem;font-size: 0.18rem;">
          {{ $t("立即下载") }}
        </p>
      </div>
      <div class="flex-center" style="
          padding: 0 0.2rem;text-align: center;
          height: 0.7rem;line-height: 0.7rem;" @click="download_show = false">
        <i class="fa-solid fa-xmark" style="color: var(--main); font-size: 0.3rem"></i>
      </div>
    </div>
</template>
<style scoped lang="scss">
.download {
  background: var(--bg2);
  border-bottom: 0.01rem solid var(--border);
  height: 0.7rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>