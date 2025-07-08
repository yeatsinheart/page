<script setup>
import {ref} from "vue";
import {appStore} from "@/config/store/app.js";

const download_tip_show = ref(true);

const params = defineProps({modelValue: null});
const emit = defineEmits(['update:modelValue', 'destroy'])
// 监听对话框隐藏时的逻辑 因为时通过pop弹出需要发起注销事件
watch(download_tip_show, (newVal) => {
  emit('update:modelValue',newVal)
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(download_tip_show.value)) {
        download_tip_show.value = newVal;
      }
    }
);
onBeforeMount(()=>{
  download_tip_show.value = params.modelValue;
  // 是软件
  // 已关闭
  check();
})


const today = new Date().toISOString().split("T")[0];
const skip_key = "skipDownloadTip";
// 设置“不再提醒”
// 更新 localStorage 删除历史跳过提醒的数据
const setNoReminder = () => {
  localStorage.setItem(skip_key, today);
  download_tip_show.value = false;
};
function check() {
  const skipReminderData = localStorage.getItem(skip_key) || "";
  if(skipReminderData!==today){
    localStorage.setItem(skip_key, "");
    download_tip_show.value = true
  }else {
    download_tip_show.value = false;
  }
}


</script>
<template>
    <div v-if="download_tip_show" class="download">
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
          height: 0.7rem;line-height: 0.7rem;" @click="setNoReminder">
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