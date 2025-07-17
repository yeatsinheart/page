

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
      <nav class="flex" style="width:100%;flex-wrap: nowrap;overflow-x: auto;" id="tab_scroller">
        <template v-for="(tab,index) in menuTabState.tabs">
          <div :id="'tab_'+tab.id" class="nav-tab-item" :class="menuTabState.select_index!=index?'':'tab-selected'"
               style="padding: 0 14px;">
            <el-tooltip class="item" effect="dark" :content="'切换到'+tab.title" placement="bottom">
              <span @click="menuTabState.activeTab(index)" style="">{{ tab.title }}</span>
            </el-tooltip>
            <el-tooltip class="item" effect="dark" content="刷新" placement="bottom">
              <i class="fa fa-rotate-right" @click="menuTabState.reload(index)" style="margin: 0 10px;"></i></el-tooltip>
            <el-tooltip class="item" effect="dark" content="关闭" placement="bottom">
              <i class="fa fa-times-circle" @click="menuTabState.closeTabs(index)"></i></el-tooltip>
            <el-divider
                v-if="!(menuTabState.select_index==(index+1) || index==(menuTabState.tabs.length-1)) && menuTabState.select_index!=index"
                direction="vertical"></el-divider>
          </div>
        </template>
      </nav>
      <!-- 向右滚动 -->
      <div class="flex nav-tab-arrow nav-tab-item" @click="scroll_tab(200)">
        <el-tooltip class="item" effect="dark" content="查看右边选项卡" placement="bottom-end">
          <i class="fa fa-forward nav-tab"></i>
        </el-tooltip>
      </div>


      <!-- 选项卡操作 -->
      <div class="flex" style="flex-shrink: 0;height:27px;">
        <div class="nav-tab-item">
          <div class="nav-tab-more flex-center"
               @click="menuTabState.tab_dropdown=!menuTabState.tab_dropdown">
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
        <div class="flex-center">其余</div>
      </div>
    </div>

    <!--  Iframe 窗口  box-shadow: 0 0 50px 0 rgba(82, 63, 105, 0.15); background: #1c1d1f -->
    <div class="flex" style="height: calc(100% - 27px);background-color:var(--bg);">
      <template v-for="(tab,index) in menuTabState.tabs">
        <iframe  :id="'iframe_'+tab.id" :src="tab.url" frameborder="0"
                style="background-color:var(--bg);width:100%;height: 100%; border: 0;"
                :style="index!==menuTabState.select_index?'visibility: hidden;position: absolute;top: -9999px;left: -9999px;':''"
                allowtransparency="false"></iframe>
      </template>
    </div>
  </div>
</template>

<script setup>
import {menuTabStore, scroll_tab} from '@/store/menu-tab.js'
const menuTabState  = menuTabStore()
const iframes = document.querySelectorAll('.myIframe');
const loaders = document.querySelectorAll('.loader');
// 初始化：显示所有加载指示器
loaders.forEach(loader => loader.style.display = 'block');

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

/*整个滚动条*/
#tab_scroller::-webkit-scrollbar {
  height: 7px;
  display: block; cursor: pointer;
}
/*定义滚动条轨道 内阴影+圆角*/
#tab_scroller::-webkit-scrollbar-track {
  border-radius: 10px;
  background-color:  rgba(9, 38, 180, 0.1);
}
/*定义滑块*/
#tab_scroller::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background-color:  var(--c1);
}

.nav-tab-item {
  user-select: none;
  position: relative;
  flex-shrink: 0;
  font-size: 14px;
  /*line-height: 40px;*/
  cursor: pointer;
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

.tab-selected::before , .tab-selected::after {
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