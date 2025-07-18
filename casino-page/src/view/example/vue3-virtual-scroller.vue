<script setup>

import VirtualList from 'vue3-virtual-scroll-list';

const items = Array.from({ length: 10000 }, (_, i) => `Item ${i}`);
/*
vue3 虚拟滚动，支持无限加载，滚动位置记录，丝滑流畅
list	Array	[]	列表数据
grid	Number	1	每一排的数量，默认为1
height	Number	0	每一行的高度，该字段为必填
rowKey	String	id	每一行的唯一key，该字段为必填
loadingText	String	加载中，请稍等	加载时候的文字显示
bufferCount	Number	4	上下的缓冲条数，解决滑动过快时白屏bug
wrapperStyle	Object	{}	列表包裹容器的样式
colSpace	Number	0	列间距
rowSpace	Number	0	行间距
onTouchEnd	Function	function() {}	触底回调函数
* */
</script>

<template>
  <VirtualList
      :data-key="'id'"
      :data-sources="items"
      :keeps="20"
      :data-component="{
      render: ({ data }) => h('div', data)
    }"
  />
</template>
