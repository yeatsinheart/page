<script setup>

import Menu from "./menu.vue";
import IframeTab from "./ifram_tab.vue";
import {menuTabStore, new_tab} from './menu-tab.js'

const menuTabState = menuTabStore()
</script>

<template>
  <!--左 中 右 当 float: left; 存在时，如果外层容器（parent）没有 padding 或 overflow: hidden; 之类的属性，可能会导致盒子模型异常，比如塌陷或子元素超出预期布局。-->
  <div style="height: 100%;overflow: auto;" :class="menuTabState.show_menu?'menu_show':'menu_hide'">
    <Menu class="menu"></Menu>
    <IframeTab class="tab"></IframeTab>
  </div>
</template>

<style scoped lang="scss">
.menu{
  width: 300px; float: left;
  height: 100%;
  transition: all 0.3s ease-in-out;
  /*transition: all 1s ease-in-out ;*/
  /*, opacity 0.3s ease-in-out*/
}
.tab{
  min-width:1010px;
  height: 100%;
  width:100%;
  background: var(--bg1);
  /*
  transition-duration: .15s;
  transition-property: padding-left;
  transition-timing-function: cubic-bezier(.4,0,.2,1);*/
  /*transition: all 0.5s ease-in-out;*/
}
.menu_hide{
  .menu{
    width: 0;opacity: 0;height: 0;
    /*display: none;*/
  }
}

</style>