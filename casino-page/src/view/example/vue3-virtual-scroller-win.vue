<template>
  <div class="container">
    <virtual-list
        :size="40"
        :data-key="'id'"
        :data-sources="records"
        class="scroll-list"
        ref="vlist"
    >
      <template #default="{ item }">
        <div class="list-item">
          恭喜 {{ item.user }} 获得 {{ item.amount }} 元奖励！
        </div>
      </template>
    </virtual-list>
  </div>
</template>

<script setup>
import VirtualList from 'vue3-virtual-scroll-list'
import { ref, onMounted, nextTick } from 'vue'

let id = 0

const records = ref([
  { id: ++id, user: '139****8888', amount: 88 },
  { id: ++id, user: '138****1234', amount: 188 },
])

const vlist = ref()

function addRandomRecord() {
  records.value.push({
    id: ++id,
    user: `13${Math.floor(Math.random() * 10)}****${Math.floor(Math.random() * 9000 + 1000)}`,
    amount: Math.floor(Math.random() * 1000) + 1,
  })

  // 限制最大记录数（如 100）
  if (records.value.length > 100) {
    records.value.splice(0, records.value.length - 100)
  }

  // 自动滚动到底部
  nextTick(() => {
    vlist.value.scrollToBottom()
  })
}

onMounted(() => {
  setInterval(() => {
    addRandomRecord()
  }, 2000)
})
</script>

<style scoped>
.container {
  height: 300px;
  border: 1px solid #ccc;
  overflow: hidden;
}
.scroll-list {
  height: 100%;
}
.list-item {
  height: 40px;
  line-height: 40px;
  padding: 0 10px;
  border-bottom: 1px dashed #eee;
}
</style>
