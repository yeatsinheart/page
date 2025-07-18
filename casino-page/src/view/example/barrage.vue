<template>
<!-- 弹幕 -->
  <div class="barrage-container">
    <div
        v-for="(item, index) in barrageList"
        :key="item.id"
        class="barrage-item"
        :style="{ top: `${item.track * 30}px` }"
    >
      {{ item.text }}
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const barrageList = ref([])

function addBarrage(text) {
  barrageList.value.push({
    id: Date.now(),
    text,
    track: Math.floor(Math.random() * 5) // 轨道数
  })
  setTimeout(() => {
    barrageList.value.shift()
  }, 8000)
}
</script>

<style scoped>
.barrage-container {
  position: relative;
  height: 200px;
  overflow: hidden;
}
.barrage-item {
  position: absolute;
  left: 100%;
  white-space: nowrap;
  animation: move 8s linear forwards;
}
@keyframes move {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(-120vw);
  }
}
</style>
