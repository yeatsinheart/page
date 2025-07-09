<template>
  <div style="height: 100%">
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div class="flex-center">
        {{$t('游戏记录')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="view_route_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <div @click="closeList" class="accountDetails">
      <div class="select">
        <!-- 时间选择 -->
        <div class="time">
          <button
            @click.stop="showTime"
            class="timeSelect"
            :style="{
              border: showTimeList
                ? '1px solid var(--c2)'
                : '1px solid var(--border)',
            }"
          >
            <p>{{ $t(timeList[timeActive].title) }}</p>
            <i class="fa-solid fa-chevron-down" :class="{ 'icon-action': showTimeList }"></i>
          </button>
          <ul class="timeSelect-ul" :class="{ 'ul-active': showTimeList }">
            <li
              v-for="(item, index) in timeList"
              :key="index"
              @click="changeTime(index)"
              :style="{
                color: timeActive === index ? 'var(--c2)' : 'var(--f2)',
              }"
            >
              {{ item.title }}
            </li>
          </ul>
        </div>
        <p class="award">
          {{ $t("COMMISSION cOLLECTED") }}
          <span>{{ award || '0.00' }}</span>
        </p>
      </div>
      <!-- 空状态 -->
      <van-empty :description="$t('暂无数据')" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import router from "@/router/index.js";
import {view_route_by_key} from "@/tool/View.js";

const award = ref();
// 时间选择
const timeList = ref([
  { id: 1, title: "今天" },
  { id: 2, title: "昨天" },
  { id: 3, title: "本周" },
  { id: 4, title: "上周" },
  { id: 4, title: "上月" },
]);
const timeActive = ref(0);
const showTimeList = ref(false);
// 显示时间列表
const showTime = () => {
  showTimeList.value = !showTimeList.value;
};
// 切换时间选择
const changeTime = (index) => {
  timeActive.value = index;
  showTimeList.value = false;
};
// 类型选择
const input = ref();
const typeList = reactive([
  { id: 1, title: "全部状态" },
  { id: 2, title: "未结算" },
  { id: 3, title: "已结算" },
  { id: 4, title: "已撤单" },
]);
const inputType = ref();
const inputPlaceholder = ref();
onMounted(() => {
  inputPlaceholder.value = typeList[0].title;
});

// 关闭列表
const closeList = () => {
  showTimeList.value = false;
};
</script>

<style lang="scss" scoped>
.accountDetails {
  padding: 12px;
  .select {
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
  }
  .time {
    position: relative;
    margin-right: 15px;
  }
}
.timeSelect {
  height: 30px;
  padding: 0px 20px;
  color: var(--f2);
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-radius: 20px;
  background-color: var(--bg1);
  border: 1px solid var(--border);
  box-sizing: border-box;
  .i-icon {
    padding-top: 5px;
    font-size: 20px;
    transition: all 0.3s;
  }
  .icon-action {
    transform: rotate(180deg);
  }
}
.timeSelect-ul {
  width: 94px;
  height: 0px;
  opacity: 0;
  padding: 10px;
  color: var(--f2);
  border: 1px solid var(--border);
  border-radius: 10px;
  background-color: var(--bg1);
  position: absolute;
  top: 30px;
  box-sizing: border-box;
  transition: all 0.3s;
  z-index: -1;
  li {
    height: 40px;
    line-height: 40px;
  }
}
.ul-active {
  height: 220px;
  opacity: 1;
  z-index: 2;
}
.award {
  span {
    color: var(--c2);
  }
}
</style>
