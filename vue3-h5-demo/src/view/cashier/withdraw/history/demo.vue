<template>
  <div class="record">
    <div class="content-top">
      <div
        @click="showTypeList = !showTypeList"
        class="typeSelect"
        :style="{
          border: showTypeList
            ? '1px solid var(--c2)'
            : '1px solid var(--border)',
        }"
      >
        <p>{{ $t(typeList[typeActive].title) }}</p>
        <i
          class="fa-solid fa-chevron-down"
          :class="{ 'icon-action': showTypeList }"
        ></i>
      </div>
      <div class="rule">
        {{ $t("提款总额") }}
        <span> P 0,00</span>
        <i class="fa-solid fa-arrows-rotate"></i>
      </div>
      <ul class="typeSelect-ul" :class="{ 'ul-active': showTypeList }">
        <li
          v-for="(item, index) in typeList"
          :key="index"
          @click="changeType(index)"
          :style="{ color: typeActive === index ? 'var(--c2)' : 'var(--f2)' }"
        >
          {{ item.title }}
        </li>
      </ul>
    </div>
    <div class="empty">
      <van-empty :description="$t('暂无记录')" />
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
const typeList = ref([
  { id: 1, title: "今天" },
  { id: 2, title: "昨天" },
  { id: 3, title: "过去16天" },
  { id: 4, title: "过去30天" },
  { id: 4, title: "自定义" },
]);
const typeActive = ref(0);
const showTypeList = ref(false);
const changeType = (index) => {
  typeActive.value = index;
  showTypeList.value = false;
};
</script>

<style lang="scss" scoped>
.record {
  width: 100%;
  height: 100%;
  padding: 0 10px;
  box-sizing: border-box;
}
.content-top {
  width: 100%;
  display: flex;
  margin: 10px 0;
  justify-content: space-between;
  position: relative;
  .typeSelect {
    width: 95px;
    height: 30px;
    color: var(--f2);
    padding: 0 10px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-radius: 20px;
    background-color: var(--bg1);
    border: 1px solid var(--border);
    box-sizing: border-box;
    .fa-solid {
      font-size: 20px;
      transition: all 0.3s;
    }
    .icon-action {
      transform: rotate(180deg);
    }
  }
  .rule {
    display: flex;
    align-items: center;
    color: var(--f3);
    span {
      color: var(--f4);
      margin: 0 5px;
    }
    .i-icon {
      font-size: 18px;
    }
  }
  .typeSelect-ul {
    width: 94px;
    height: 0px;
    opacity: 0;
    padding: 10px;
    color: var(--f2);
    border: 1px solid var(--border);
    border-radius: 10px;
    background-color: var(--bg1);
    position: absolute;
    top: 32px;
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
}
</style>
