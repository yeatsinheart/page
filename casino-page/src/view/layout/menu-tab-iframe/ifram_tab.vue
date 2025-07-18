

<template>
  <div>
<!--    <div style="position: absolute;right:15px;bottom:15px;">
      <div class="flex-center" style="background-color: rgba(0,0,0,0.5);color:var(&#45;&#45;f3);width: 50px;height: 50px;border-radius: 15px;font-size: 30px;"
        @click="notify('<div>test</div>','warning')">
      <el-icon><Notification /></el-icon>
      </div>
    </div>-->
    <div class="flex nav-tab">
      <!-- 目录操作 -->
      <div class="flex nav-tab-arrow nav-tab-item" @click="menuTabState.show_menu=!menuTabState.show_menu">
        <el-tooltip class="item" effect="dark" :content="(menuTabState.show_menu?'隐藏':'显示')+'菜单'" placement="bottom-start">
<!--          <i class="fa nav-tab" :class="menuTabState.show_menu?'fa-eye-slash':'fa-eye'" :style="menuTabState.show_menu?'color:var(&#45;&#45;main)':'color:var(&#45;&#45;main)'"></i>-->
          <el-icon size="22" v-if="menuTabState.show_menu">
            <Open />
          </el-icon>
          <el-icon size="22" v-else><TurnOff /></el-icon>
        </el-tooltip>
      </div>
      <!-- 向左滚动 -->
      <div class="flex nav-tab-arrow nav-tab-item" @click="scroll_tab(-200)">
        <el-tooltip class="item" effect="dark" content="查看左边选项卡" placement="bottom-start">
          <i class="fa nav-tab fa-backward"></i>
        </el-tooltip>
      </div>

      <!-- 选项卡 -->
      <TabItem/>

      <!-- 向右滚动 -->
      <div class="flex nav-tab-arrow nav-tab-item" @click="scroll_tab(200)">
        <el-tooltip class="item" effect="dark" content="查看右边选项卡" placement="bottom-end">
          <i class="fa fa-forward nav-tab"></i>
        </el-tooltip>
      </div>

      <!-- 选项卡操作 -->
      <div class="flex" style="flex-shrink: 0;height:27px;">
        <div @click="()=>{menuTabState.tab_dropdown=false;}" style="position:absolute; top:0; left:0;width:100%; height:100%; background:transparent;"  v-if="menuTabState.tab_dropdown"></div>

        <div class="nav-tab-item">
          <div class="nav-tab-more flex-center"
               @click="menuTabState.tab_dropdown=!menuTabState.tab_dropdown"
          >
            {{ menuTabState.tabs.length }}
          </div>
          <div class="dropdown-menu" :style="!menuTabState.tab_dropdown?'display:none':''">
            <!--          <div>选项卡数量{{ menuTabState.tabs.length }}</div>-->
            <div @click="menuTabState.closeTabs(-1)">关闭全部</div>
            <div @click="menuTabState.onlyKeepThis(menuTabState.select_index)">关闭其他</div>
            <div @click="menuTabState.closeTabs(menuTabState.select_index,1)">关闭右侧</div>
            <div @click="menuTabState.closeTabs(menuTabState.select_index,-1)">关闭左侧</div>
          </div>
        </div>
<!--        <div class="flex-center">其余</div>-->
      </div>
    </div>
    <IframeView/>
  </div>
</template>

<script setup>
import {menuTabStore, scroll_tab} from './menu-tab.js'
import TabItem from "./tab-item.vue";
import IframeView from "./iframe-view.vue";
const menuTabState  = menuTabStore()
const loaders = document.querySelectorAll('.loader');
// 初始化：显示所有加载指示器
loaders.forEach(loader => loader.style.display = 'block');

</script>

<style scoped lang="scss">

.tab-view .fa:hover {
  cursor: pointer;
  color: #d73b3b;
}

.nav-tab-arrow {
  /* border-right: solid 1px #eee;*/
  width: 40px;
 /* height: 40px;*/
  justify-content: center;
  align-items: center;
  :hover {
    background-color: rgba(51, 51, 51, 0.1);
    color: #d73b3b;
  }
}

/*更多操作*/
.nav-tab-more {
  user-select: none;
  /*line-height: 40px;*/
  border-color: var(--main);
  background-color: var(--main);
  color: var(--main-font);
  padding-left: 10px;
  padding-right: 10px;
  height: 100%;
}

.nav-tab-more::after {
  display: inline-block;
  margin-left: .255em;
  vertical-align: .255em;
  content: "";
  border-top: .3em solid;
  border-right: .3em solid transparent;
  border-bottom: 0;
  border-left: .3em solid transparent;
}

.nav-tab-more:after {
  content: "\f0d7";
  font-family: FontAwesome;
  border: 0;
  vertical-align: middle;
  margin-left: .25em;
  line-height: 1;
}

.dropdown-menu {
  position: absolute;
  right: 0;
  width: 150px;
  padding:10px;
  text-align: center;
  background-color: var(--bg1);
  user-select: none;

  z-index: 2;
  overflow: hidden;
  border-radius: 12px;
  box-shadow: 0 0 50px 0 rgba(82, 63, 105, 0.15);
  >div{
    padding:3px;
  }
}

.dropdown-menu div:hover {
  color:var(--main);
}



</style>