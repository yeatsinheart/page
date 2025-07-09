<template>
  <div class="betting" style="height: 100%">
    <!-- 提现任务列表 -->
<!--    <div class="betting-title">
      <p>
        {{ $t("您还需要有效下注{num}才能提款!") }}
      </p>
      <i class="fa-sharp-duotone fa-solid fa-arrows-rotate"></i>
    </div>-->
    <div v-if="task_list.length===0" class="empty">
      <van-empty :description="$t('暂无数据')" />
    </div>
    <div v-else class="content">
      <div class="content-top">
<!--        <div @click="showTypeList = !showTypeList"
            class="typeSelect"
            :style="{ border: showTypeList
              ? '1px solid var(&#45;&#45;c2)'
              : '1px solid var(&#45;&#45;border)',
          }"
        >
          <p>{{ $t(typeList[typeActive].title) }}</p>
          <i
              class="fa-solid fa-chevron-down"
              :class="{ 'icon-action': showTypeList }"
          ></i>
        </div>-->
<!--        <p @click="showDialog = true" class="rule">
          {{ $t("有效投注计算规则") }}
        </p>-->
<!--        <ul class="typeSelect-ul" :class="{ 'ul-active': showTypeList }">
          <li
              v-for="(item, index) in typeList"
              :key="index"
              @click="changeType(index)"
              :style="{ color: typeActive === index ? 'var(&#45;&#45;c2)' : 'var(&#45;&#45;f2)' }"
          >
            {{ item.title }}
          </li>
        </ul>-->
      </div>
      <div v-for="(task, index) in task_list" :key="index" class="bet-list">
        <div class="bet-header">
          <p class="bet-reward">
            <span>{{task.amount}}</span>
          </p>
          <p class="bet-required">
            {{ $t("需有效投注") }}
            <span> {{task.taskAmount}} </span>
          </p>
        </div>

        <div class="bet-details">
          <div class="bet-source">
            <i class="fa-sharp-duotone fa-solid fa-gift"></i>
            <span>{{task.type}} - {{task.subType}}</span>
          </div>
          <div class="bet-time">{{ dayjs(task.createAt).format('YYYY-MM-DD HH:mm:ss') }}</div>
        </div>
      </div>
    </div>

    <!-- 弹窗 -->
    <!-- <van-dialog v-model:show="showDialog" title="标题" show-cancel-button>
    </van-dialog> -->
  </div>
</template>

<script setup>
import { ref } from "vue";
import {ApiRequest} from "@/api/index.js";
import dayjs from "dayjs";

const task_list = ref([])
onBeforeMount(()=>{
  ApiRequest._z3QwN5Y6().then((res)=>{
    task_list.value = res||[];
  })
})

</script>

<style lang="scss" scoped>
.betting-title {
  width: 100%;
  height: 55px;
  display: flex;
  color: var(--error);
  justify-content: center;
  align-items: center;
  background-color: var(--bg1);
  p {
    margin-right: 10px;
  }
}
.content {
  width: 100%;
  padding: 15px;
  box-sizing: border-box;
  font-size: 13px;
}
.content-top {
  width: 100%;
  display: flex;
  margin: 10px 0;
  justify-content: space-between;
  .typeSelect {
    width: 95px;
    height: 30px;
    font-size: 15px;
    color: var(--f2);
    padding: 0 10px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-radius: 20px;
    background-color: var(--bg1);
    border: 1px solid var(--border);
    box-sizing: border-box;
    position: relative;
    .icon-action {
      transform: rotate(180deg);
    }
  }
  .rule {
    color: var(--main);
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
    top: 110px;
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
.bet-list {
  padding: 10px;
  border-radius: 8px;
  &:nth-child(even) {
    background-color: var(--bg1);
  }
}

.bet-header {
  display: flex;
  justify-content: space-between;
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 8px;
  font-size: 13px;
  color: var(--f3);
}

.bet-reward {
  span {
    color: var(--c2);
  }
}

.bet-required {
  span {
    font-weight: bold;
    color: var(--f4);
  }
}

.bet-status {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  color: var(--f3);
  span {
    color: var(--f4);
  }
  p:nth-of-type(2) {
    display: flex;
    align-items: center;
    font-weight: bold;
    color: var(--c2);
  }
}

.bet-details {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: var(--f3);
  .bet-source {
    height: 20px;
    display: flex;
    align-items: center;
    .fa-solid {
      margin-right: 5px;
    }
    span:nth-of-type(2) {
      margin: 0 3px;
    }
    span:nth-of-type(3) {
      color: var(--c2);
    }
  }
  .bet-time {
    text-align: right;
  }
}
</style>
