<script setup>

import {onBeforeUnmount, onMounted, ref} from "vue";

import {menuTabStore, new_tab} from './menu-tab.js'
const menuTabState  = menuTabStore()

function hideMenu() {
  menuTabState.tab_contextmenu.visible = false
}
/*

function clickOutside(e) {
  console.log(e.target.closest('.tab-context-menu'))
  //如果点击的目标元素（e.target）不是菜单元素 .menu 本身，也不是其子元素，则隐藏菜单。
  if (!e.target.closest('.tab-context-menu')) hideMenu()
}

onMounted(() => {
  document.addEventListener('click', clickOutside)
})
onBeforeUnmount(() => {
  document.removeEventListener('click', clickOutside)
})
*/

</script>

<template>

  <div class="tab-context-menu" :style="{ top: `${menuTabState.tab_contextmenu.y}px`, left: `${menuTabState.tab_contextmenu.x}px` }" v-if="menuTabState.tab_contextmenu.visible">
    <div class="menu-item" @click="()=>{hideMenu();menuTabState.reload(menuTabState.tab_contextmenu.tabIndex);}">重新加载</div>
    <div class="menu-item" @click="()=>{hideMenu();new_tab(menuTabState.tab_contextmenu.title,menuTabState.tab_contextmenu.url);}">复制</div>
    <el-divider style="margin: 2px !important;"/>
    <div class="menu-item" @click="()=>{hideMenu();menuTabState.closeTabs(menuTabState.tab_contextmenu.tabIndex);}">关闭</div>
    <div class="menu-item" @click="()=>{hideMenu();menuTabState.closeTabs(-1);}">关闭全部</div>
    <div class="menu-item" @click="()=>{hideMenu();menuTabState.onlyKeepThis(menuTabState.tab_contextmenu.tabIndex);}">关闭其他</div>
    <div class="menu-item" @click="()=>{hideMenu();menuTabState.closeTabs(menuTabState.tab_contextmenu.tabIndex,1);}">关闭右侧-></div>
    <div class="menu-item" @click="()=>{hideMenu();menuTabState.closeTabs(menuTabState.tab_contextmenu.tabIndex,-1);}">关闭左侧<-</div>
  </div>
    <div @click="hideMenu" style="position:absolute; top:0; left:0;width:100%; height:100%; background:transparent;"  v-if="menuTabState.tab_contextmenu.visible"></div>
</template>

<style scoped lang="scss">
.tab-context-menu {
  padding:8px;
  position: fixed;
  background: #e7e9e4;
  border: 1px solid #ccc;
  box-shadow: 0 8px 8px rgba(0,0,0,0.1);
  border-radius: 6px;
  z-index: 9999;
  font-size: 14px;
}

.menu-item {
  padding: 2px 10px;
  cursor: pointer;
  border-radius: 6px;

}

.menu-item:hover {
  background: #007bff;
  color: #fff;
}
</style>