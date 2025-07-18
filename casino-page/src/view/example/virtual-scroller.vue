<template>
  <div ref="container" class="container" @scroll="onScroll">
    <div :style="{ height: totalHeight + 'px', position: 'relative' }">
      <div
          v-for="item in visibleItems"
          :key="item.id"
          :style="{ position: 'absolute', top: item.top + 'px', height: itemHeight + 'px' }"
      >
        {{ item.name }}
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const itemHeight = 50
const visibleCount = 10
const buffer = 5

const container = ref(null)
const items = ref(
    Array.from({ length: 10000 }, (_, i) => ({
      id: i,
      name: `Item ${i}`,
    }))
)

const scrollTop = ref(0)

const totalHeight = items.value.length * itemHeight

const visibleItems = computed(() => {
  const start = Math.max(0, Math.floor(scrollTop.value / itemHeight) - buffer)
  const end = Math.min(items.value.length, start + visibleCount + buffer * 2)

  return items.value.slice(start, end).map((item, index) => ({
    ...item,
    top: (start + index) * itemHeight,
  }))
})

function onScroll(e) {
  scrollTop.value = e.target.scrollTop
}
</script>

<style>
.container {
  height: 500px;
  overflow-y: auto;
  border: 1px solid #ccc;
}
</style>
