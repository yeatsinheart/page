<script setup>
import {menuTabStore} from './menu-tab.js'
const menuTabState = menuTabStore()
const iframes = document.querySelectorAll('.myIframe');
// 监听每个 iframe 的加载事件
iframes.forEach((iframe, index) => {
  iframe.onload = function() {
    // 当 iframe 加载完成时，隐藏对应的加载指示器
    loaders[index].style.display = 'none';

    // 检查所有 iframe 是否都加载完成
    if (Array.from(iframes).every(iframe => iframe.contentWindow.document.readyState === 'complete')) {
      // 所有 iframe 加载完成，隐藏所有加载指示器
      loaders.forEach(loader => loader.style.display = 'none');
    }
  };
});
</script>

<template>
  <!--  Iframe 窗口  box-shadow: 0 0 50px 0 rgba(82, 63, 105, 0.15); background: #1c1d1f -->
  <div class="flex" style="height: calc(100% - 27px);background-color:var(--bg);">

    <template v-for="(tab,index) in menuTabState.tabs">
      <iframe  :id="'iframe_'+tab.id" :src="tab.url" frameborder="0"
               style="background-color:var(--page);width:100%;height: 100%; border: 0;"
               :style="index!==menuTabState.select_index?'visibility: hidden;position: absolute;top: -9999px;left: -9999px;':''"
               allowtransparency="false"></iframe>
    </template>
  </div>
</template>

<style scoped lang="scss">

</style>