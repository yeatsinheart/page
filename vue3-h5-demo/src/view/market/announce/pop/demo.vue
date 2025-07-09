<template>
  <div class="announce_pop" >
    <div class="flex" style="width: 85%;text-align: right;padding: .13rem 0;justify-content: right">
    <van-checkbox v-model="no_reminder_show" checked-color="var(--main)"  @change="setNoReminder">{{ $t("今日不再提示") }}</van-checkbox>
    </div>
    <transition name="popup" v-show="show">
      <div class="cont">
        <div class="top">
          <span>{{ $t("平台公告") }}</span>
          <i class="fa-solid fa-xmark" @click="close"></i>
        </div>
        <van-collapse v-model="activeNames" accordion @change="scrollToItem">
          <van-collapse-item
            :name="index" :data-name="index"
            v-for="(item, index) in appState.app.announceList.filter(item => item.popUp)"
            :key="index"
          >
            <template #title>
              <div class="title">
                <i class="fa-solid fa-circle"></i>
                <span>{{ item.title }}</span>
              </div>
            </template>
            <div class="ck-content" v-html="item.html"></div>
          </van-collapse-item>
        </van-collapse>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { appStore } from "@/config/store/app.js";
const emit = defineEmits(["destroy"]);
const appState = appStore();
const activeNames = ref();
const show = ref(false);
const no_reminder_show = ref(false);

const close = () => {
  show.value = false;
  emit("destroy");
};

const skip_key = "skipPopAnnounce";
// 设置“不再提醒”
const setNoReminder = (no_reminder) => {
  if(no_reminder){
    const today = new Date().toISOString().split("T")[0];
    localStorage.setItem(skip_key, today);
  }else {
    localStorage.setItem(skip_key, "");
  }
};
function check() {
  const skipReminderData = localStorage.getItem(skip_key) || "";
  const today = new Date().toISOString().split("T")[0];
  // 更新 localStorage 删除历史跳过提醒的数据

  if(skipReminderData!==today){
    localStorage.setItem(skip_key, "");
      show.value = appState.app.announceList.some(item => item.popUp);
      if(!show.value){
        close();
      }
  }else {
    close();
  }
}

onBeforeMount(()=>{
  check()
})

const scrollToItem = (name) => {
  nextTick(() => {
    const area = document.querySelector(".van-collapse");
    const item = document.querySelector(`.van-collapse-item[data-name="${name}"]`);
    if (area && item) {
      const title = item.querySelector(".van-collapse-item__title")
      const targetTop = item.offsetTop-2*title.getBoundingClientRect().height; // 计算目标 item 相对 van-collapse 的位置
      area.scrollTo({ top: targetTop, behavior: "smooth" });
      // 等待折叠动画完成，再调整滚动
      setTimeout(() => {
        const topAfter = item.getBoundingClientRect().top;
        const areaRect = area.getBoundingClientRect();
        if (topAfter < areaRect.top) {
          // 永远看到两个标题
          const collapsed_top = item.offsetTop-2*title.getBoundingClientRect().height;
          area.scrollTo({ top: collapsed_top , behavior: "smooth" });
        }
      }, 300); // Vant 动画时间通常是 300ms
    }
  });
};
</script>

<style lang="scss" scoped>
:deep(.van-cell){
  color: var(--f3);
  background:var(--bg1)
}
:deep(.van-collapse-item__content){
  color: var(--f3);
  background:var(--bg1)
}
:deep(.van-hairline--top-bottom:after) {
  border: none !important;
}
.announce_pop {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 99;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(0, 0, 0, .5);
  flex-direction: column;

  .cont {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 85%;
    max-height: 85%;
    background: var(--bg1);
    color: var(--f3);
    border-radius: 8px;
    overflow: hidden;
    .top {
      width: 100%;
      height: .8rem;
      flex-shrink: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      font-size: 24px;
      background: var(--main);
      color: var(--main_font);
      i {
        position: absolute;
        right: 10px;
        font-size: 24px;
        color: var(--main_font);
        padding: 10px;
      }
    }
    .van-collapse {
      width: 100%;
      overflow-y: auto;
    }
    .title {
      i {
        margin-right: 5px;
      }
    }
  }

  .popup-enter-active,
  .popup-leave-active {
    transition: all 0.3s ease;
  }
  .popup-enter-from,
  .popup-leave-to {
    transform: scale(0.5);
    opacity: 0;
  }
  .popup-enter-to,
  .popup-leave-from {
    transform: scale(1);
    opacity: 1;
  }
}
:deep(.van-checkbox__label){
  color: #fff!important;
}

:deep(.van-checkbox__icon .van-icon){
  border: 0.01714rem solid #fff!important;
}
</style>
