<script setup>
import { ref } from "vue";
const description = ref("ip受限,切换ip登录");
</script>

<template>
  <div class="forbidden">
    <van-empty image="error" />
    <div class="forbidden-content">
      <h2 class="title">{{ $t("访问限制") }}</h2>
      <p class="illustrate">
        {{ $t(description) }}
        ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录ip受限,切换ip登录
      </p>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.forbidden {
  padding: 12px;
}
.forbidden-content {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.title {
  font-size: 33px;
  color: var(--f4);
}
.illustrate {
  text-indent: 2em;
  margin-top: 20px;
  font-size: 20px;
  line-height: 40px;
}
</style>
