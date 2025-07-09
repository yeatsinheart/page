<template>
  <div class="bonus_pop">
    <transition name="popup" v-for="(item, index) in list" :key="index">

      <div class="cont" v-show="active === index">
        <img :src="item.popImg" alt="" @click="changeactive(item)"/>
        <p>
          <van-checkbox v-model="item.noReminder" checked-color="var(--main)" @change="setNoReminder(item)">
            {{ $t("今日不再提示") }}
          </van-checkbox>
        </p>
        <div @click="changeactive(false)">
          <i class="fa-solid fa-xmark"></i>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import {ref} from "vue";
import {show,openby} from "@/tool/pop.js";
import {appStore} from "@/store/app.js";

const emit = defineEmits();
const active = ref(-1);
const appState = appStore();
const checked = ref(false);
const list = ref([]);

const changeactive = (bonus) => {
  if (bonus && bonus.detailPath) {
    if (bonus.openBy) {
      setTimeout(() => {
        openby(bonus.openBy, bonus.detailPath, bonus);
        // openby("/ui/popup/mask", i.view, {}, "");
      }, 350);
    } else {
      show(bonus.detailPath, bonus);
    }
  }
  active.value = String(parseInt(active.value) + 1);
  // 和动画效果时间相同
  setTimeout(() => {
    active.value = Number(active.value);
  }, 300);
  if (list.value.length === parseInt(active.value)) {
    destroy_all();
  }
};
const skip_key = "skipPopBonusReminderList";

function destroy_all() {
    emit("destroy", "Hello from child!");
}

// 设置“不再提醒”
const setNoReminder = (item) => {
  const today = new Date().toISOString().split("T")[0];
  let skipReminderData = JSON.parse(localStorage.getItem(skip_key) || "{}");
  if (item.noReminder) {
    skipReminderData[`item_${item.bonusId}`] = today;
    localStorage.setItem(skip_key, JSON.stringify(skipReminderData));
  } else {
    skipReminderData[`item_${item.bonusId}`] = "";
    localStorage.setItem(skip_key, JSON.stringify(skipReminderData));
  }
};

function check() {
  const skipReminderData = JSON.parse(localStorage.getItem(skip_key) || "{}");
  const today = new Date().toISOString().split("T")[0];
  // 过滤掉不是今天的数据
  let validData = Object.fromEntries(
      Object.entries(skipReminderData).filter(([_, date]) => date === today)
  );
  // 更新 localStorage 删除历史跳过提醒的数据
  localStorage.setItem(skip_key, JSON.stringify(validData));
  list.value = appState.app.bonus?.list.filter((item) => item.popUp && skipReminderData[`item_${item.bonusId}`] !== today) || [];
  if (list && list.value.length === 0) {
    destroy_all();
  } else {
    setTimeout(() => {
      changeactive();
    }, 200);
  }
}

onBeforeMount(() => {
  check();
})

</script>

<style lang="scss" scoped>
.bonus_pop {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 99;
  background: rgba($color: #000, $alpha: 0.5);
  display: flex;
  align-items: center;
  justify-content: center;

  .cont {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;

    img {
      width: 80%;
    }

    & > div {
      width: 35px;
      height: 35px;
      line-height: 35px;
      text-align: center;
      border: 3px solid #fff;
      border-radius: 50%;
      margin-top: 20px;

      .fa-solid {
        color: #fff;
        font-weight: bold;
      }
    }

    & > p {
      width: 100%;
      padding: 10px 10%;

      :deep(.van-checkbox__label) {
        color: #fff;
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
  border: 0.01714rem solid  #fff!important;
}
</style>
