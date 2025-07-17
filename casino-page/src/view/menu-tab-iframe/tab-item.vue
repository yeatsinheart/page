<script setup>
import {menuTabStore} from './menu-tab.js'
import TabContextmenu from "@/view/menu-tab-iframe/tab-contextmenu.vue";

const menuTabState = menuTabStore()
</script>

<template>
  <nav id="tab_scroller" class="flex" style="width:100%;flex-wrap: nowrap;overflow-x: auto;">
    <template v-for="(tab,index) in menuTabState.tabs">
      <!--   @contextmenu.prevent="showMenu($event)"        -->
      <div :id="'tab_'+tab.id" :class="menuTabState.select_index!==index?'':'tab-selected'" class="nav-tab-item"
           style="padding: 0 14px;"
           @click="menuTabState.activeTab(index)"
           @contextmenu.prevent="menuTabState.activeTabMenu(index,$event)">

        <el-tooltip :content="'切换到'+tab.title" class="item" effect="dark" placement="bottom">
          <span style="">{{ tab.title }}</span>
        </el-tooltip>

        <el-tooltip class="item" content="刷新" effect="dark" placement="bottom">
          <i class="fa fa-rotate-right" style="margin: 0 10px;" @click="menuTabState.reload(index)"></i></el-tooltip>
        <el-tooltip class="item" content="关闭" effect="dark" placement="bottom">
          <i class="fa fa-times-circle" @click="menuTabState.closeTabs(index)"></i></el-tooltip>

        <el-divider
            v-if="!(menuTabState.select_index===(index+1) || index===(menuTabState.tabs.length-1)) && menuTabState.select_index!==index"
            direction="vertical"></el-divider>

      </div>
    </template>
    <TabContextmenu/>
  </nav>
</template>

<style lang="scss" scoped>


/*整个滚动条*/
#tab_scroller::-webkit-scrollbar {
  height: 7px;
  display: block;
  cursor: pointer;
}

/*定义滚动条轨道 内阴影+圆角*/
#tab_scroller::-webkit-scrollbar-track {
  border-radius: 10px;
  background-color: rgba(9, 38, 180, 0.1);
}

/*定义滑块*/
#tab_scroller::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background-color: var(--c1);
}


.nav-tab-item {
  user-select: none;
  position: relative;
  flex-shrink: 0;
  font-size: 14px;
  /*line-height: 40px;*/
  cursor: pointer;
}

/*选中 效果*/
.tab-selected {
  opacity: 1;
  background: var(--main);
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  color: var(--main-font);
  /* 阴影向右下角偏移 14 像素。 第二个阴影向左下角偏移 14 像素。 */
  box-shadow: 13px 13px 0 0 var(--main), -13px 13px 0 0 var(--main);
  z-index: 10;
}

.tab-selected::before, .tab-selected::after {
  content: '';
  position: absolute;
  display: inline-block;
  background: var(--bg1);
  width: 14px;
  height: 100%;

}

.tab-selected::before {
  left: -14px;
  border-bottom-right-radius: 8px;
}

.tab-selected::after {
  right: -14px;
  border-bottom-left-radius: 8px;
}

</style>