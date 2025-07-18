<template>
  <div class="chat-wrapper">

<!--    -->
    <VirtualList
        ref="chatList"
        class="chat-list"
        :data-key="'id'" :data-sources="messages"
        :extra-props="{ currentUserId: 'user_self',sources:messages }"
        :keeps="30"
        :data-component="ChatItem"
        @scroll="handleScroll"
        @totop="handleTotop"
    >
      <div slot="header" v-show="overflow" class="header">
        <div class="spinner" v-show="!finished"></div>
        <div class="finished" v-show="finished">No more data</div>
      </div>
    </VirtualList>

    <button
        v-if="showScrollToBottom"
        class="scroll-to-bottom-btn"
        @click="scrollToBottom"
    >
      ⬇ 新消息
    </button>
  </div>
</template>


<script setup>
import { ref, watch, nextTick } from 'vue';
import VirtualList from 'vue3-virtual-scroll-list';
import ChatItem from './ChatItem.vue';
const overflow=ref(false);
const finished=ref(false);

const chatList = ref(null);
const messages = ref([]);
const loadingHistory = ref(false);

const showScrollToBottom = ref(false);

function handleTotop() {
  // 加载历史消息
}
function handleScroll(event,range) {
  scrollAction();
}

function loadHistoryMessages() {
  loadingHistory.value = true;
  setTimeout(() => {
    const oldMessages = [
      { id: Date.now() - 3000, type: 'text', content: '旧消息 A', userId: 'user1', avatar: 'avatar1.png', nickname: 'UserA', time: '10:00', timestamp: 1690000000000 },
      { id: Date.now() - 2000, type: 'text', content: '旧消息 B', userId: 'user2', avatar: 'avatar2.png', nickname: 'UserB', time: '10:01', timestamp: 1690000000000 }
    ];
    messages.value = [...oldMessages, ...messages.value];
    loadingHistory.value = false;
  }, 200);
}

// 自动添加新消息
setInterval(() => {
  messages.value.push({
    id: Date.now(),
    type: 'text',
    content: '新消息 ' + new Date().toString(),
    userId: 'user1',
    avatar: 'avatar-self.png',
    nickname: 'Me',
    isSelf: true,
    time: new Date().toLocaleTimeString(),
    timestamp: new Date().getTime(),
  });

}, 1000);

// 自动滚到底部 有新消息时
watch(() => messages.value.length,
    () => {
      nextTick(() => {
        const el = chatList.value?.$el;
        if (el && el.scrollTop + el.clientHeight + 100 >= el.scrollHeight) {
          el.scrollTop = el.scrollHeight;
          showScrollToBottom.value = false;
        }else {
          showScrollToBottom.value = true;
        }
      });
    }
);

function scrollAction() {
  nextTick(() => {
    const el = chatList.value?.$el;
    if (el && el.scrollTop + el.clientHeight + 100 >= el.scrollHeight) {
      showScrollToBottom.value = false;
    }else {
      showScrollToBottom.value = true;
    }
  });
}

// 用户点击按钮滚到底部
function scrollToBottom() {
  chatList.value.scrollToBottom()
  /*const el = chatList.value?.$el;
  if (el) {
    el.scrollTop = el.scrollHeight;
    showScrollToBottom.value = false;
  }*/
}



</script>

<style scoped>.chat-wrapper {
  height: calc(100% - 200px);
  border: 1px solid #ddd;
  overflow: hidden;
  position: relative;
  /*消息从最底下顶上去*/
  display: flex;
  flex-direction: column-reverse;
}

.chat-list {
  max-height: 100%;
  overflow-y: auto;
}

.scroll-to-bottom-btn {
  position: absolute;
  right: 16px;
  bottom: 20px;
  background: #409eff;
  color: white;
  padding: 8px 12px;
  border: none;
  border-radius: 16px;
  cursor: pointer;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
  transition: opacity 0.3s ease;
  font-size: 14px;
}

</style>
