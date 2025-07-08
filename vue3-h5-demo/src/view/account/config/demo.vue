<template>
  <div style="height: 100%;">
    <div class="container">
      <ul class="section">
        <li v-for="(item, index) in accountInfo1" :key="index" class="item">
          <div class="item-text">
            <i class="fa-solid fa-user"></i>
            {{ $t(item.label) }}
          </div>
          <div class="status">
            {{ $t(item.status) }}
            <van-icon name="arrow" />
          </div>
        </li>
      </ul>
      <ul class="section newSection">
        <li v-for="(item, index) in accountInfo2" :key="index" class="item">
          <div class="item-text">
            <i class="fa-solid fa-key"></i>
            {{ $t(item.label) }}
          </div>
          <div class="status">
            {{ $t(item.status) }}
            <van-icon name="arrow" />
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from "vue";

const accountInfo1 = reactive([
  { icon: "user", label: "会员账号", status: "webtom" },
  { icon: "iphone", label: "手机", status: "未绑定" },
  { icon: "mail", label: "邮箱", status: "未绑定" },
  { icon: "fingerprint", label: "谷歌验证器", status: "未绑定" },
]);
const accountInfo2 = reactive([
  { icon: "key", label: "登录密码", status: "设置" },
  { icon: "bank-card", label: "提现密码", status: "已设置" },
  { icon: "protect", label: "密保问题", status: "未设置" },
]);
</script>

<style lang="scss" scoped>
.container {
  width: 100%;
  border-radius: 10px;
  padding: 12px;
  box-sizing: border-box;
}
.section {
  background-color: var(--browser);
  border-radius: 10px;
  padding: 5px 12px;
}
.newSection {
  margin-top: 14px;
}
.item {
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid var(--f1);
  &:last-child {
    border-bottom: none;
  }
}

.item-text {
  display: flex;
  align-items: center;
  .fa-solid {
    font-size: 20px;
    margin-right: 10px;
    padding-top: 5px;
  }
}
.status {
  display: flex;
  align-items: center;
  color: var(--f3);
}
:deep(.van-icon) {
  margin-left: 5px;
  font-size: 17px;
}
</style>
