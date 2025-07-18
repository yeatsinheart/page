<template>
  <div :class="['chat-item', source.type, isMe ? 'me' : 'other']">
    <!-- 系统提示 -->
    <template v-if="source.type === 'system'">
      <div class="system-msg">{{ source.content }}</div>
    </template>
    <!-- 普通消息（文本 / 图片等） -->
    <template v-else>
      <img class="avatar" :src="source.avatar" alt="avatar" />
      <div class="bubble-container">
        <div class="meta">
          <span class="nickname">{{ source.nickname }}</span>
          <span class="timestamp">{{ formatTime(source.timestamp) }}</span>
        </div>
        <div class="bubble">
          <!-- 文本类型 -->
          <div
              v-if="source.type === 'text'"
              class="text-content"
              v-html="renderMarkdown(source.content)"
          ></div>

          <!-- 图片类型 -->
          <div v-else-if="source.type === 'image'" class="image-content">
            <img :src="source.content" @click="previewImage(source.content)" />
          </div>

          <!-- 其他类型（保底） -->
          <div v-else class="unknown-content">[Unsupported message type]</div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
/* npm install marked dompurify */
import { marked } from 'marked'
import DOMPurify from 'dompurify'

/*
{
  id: 'msg001',
  type: 'text', // 'text' | 'image' | 'system'
  userId: 'user123',
  nickname: 'Alice',
  avatar: 'https://example.com/avatar.jpg',
  content: 'Hello **world** 😄',
  timestamp: 1690000000000
}
* */
const props = defineProps({
  source: {
    type: Object,
    required: true,
  },
  currentUserId: {
    type: String,
    required: true,
  },
})

const isMe = computed(() => props.source.userId === props.currentUserId)

function formatTime(ts) {
  const date = new Date(ts)
  return `${date.getHours()}:${String(date.getMinutes()).padStart(2, '0')}`
}

function renderMarkdown(text) {
  const html = marked.parseInline(text ?? '')
  return DOMPurify.sanitize(html)
}

function previewImage(url) {
  const win = window.open()
  win?.document.write(`<img src="${url}" style="max-width:100%;" />`)
}
</script>

<style scoped>
.chat-item {
  display: flex;
  margin: 10px 12px;
}
.chat-item.me {
  flex-direction: row-reverse;
}
.chat-item.other {
  flex-direction: row;
}
.avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  margin: 0 8px;
}
.bubble-container {
  max-width: 70%;
}
.meta {
  font-size: 12px;
  color: #888;
  margin-bottom: 4px;
}
.bubble {
  background-color: #f1f1f1;
  padding: 10px 14px;
  border-radius: 12px;
  line-height: 1.5;
  word-break: break-word;
}
.chat-item.me .bubble {
  background-color: #cce5ff;
}
.system-msg {
  width: 100%;
  text-align: center;
  font-size: 12px;
  color: #999;
  padding: 6px 0;
}
.text-content :deep(*) {
  margin: 0;
}
.image-content img {
  max-width: 180px;
  border-radius: 8px;
  cursor: pointer;
}
</style>
