<template>
  <div style="color:#fff;background: rgb(67, 74, 80);border-right:1px solid #555555;">
    <div class="help flex" style="justify-content:space-around">
      <div class="flex-center">
        <!-- border:1px dashed #6f6f71;
        const choose = (color_version) => {
        }     -->
<!--        <el-tooltip class="item" effect="dark" placement="bottom-start"
                    :content="'提醒'">
        <el-badge :value="999" class="item" style="font-size: 12px;">
          <el-icon style="cursor: pointer;width: 30px;height: 30px;"
                   @click.native.stop="new_tab('提醒','/home');">
            <Notification/>
          </el-icon>
        </el-badge>
        </el-tooltip>-->

        <el-tooltip class="item" effect="dark" placement="bottom-start"
                    :content="'颜色设计'">
          <el-icon style="cursor: pointer;width: 30px;height: 30px;"
                   @click.native.stop="new_tab('颜色设计','/view/color/index');">
            <HelpFilled/>
          </el-icon>
        </el-tooltip>
<!--
        <el-tooltip class="item" effect="dark" placement="bottom-start"
                    :content="'仪表盘'">
          <el-icon style="cursor: pointer;width: 30px;height: 30px;"
                   @click.native.stop="new_tab('仪表盘','/home');">
            <Histogram/>
          </el-icon>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" placement="bottom-start"
                    :content="'切换'+(colorModeState.dark?'白天':'夜间')+'模式'">
          <el-icon style="cursor: pointer;width: 30px;height: 30px;"
                   @click="colorModeState.mode_change()">
            <MoonNight v-if="colorModeState.dark"/>
            <Sunny v-else/>
          </el-icon>
        </el-tooltip>
        -->
      </div>

    </div>

    <el-menu background-color="#545c64" text-color="#fff" active-text-color="#ffd04b"
             style="width: 100%; height: calc(100% - 30px - 40px); overflow-y: auto;"
             :default-openeds="getAllIndexes()">
      <template v-for="menu in menus">
        <el-sub-menu v-if="menu.children" :index="menu.title">
          <template #title>
            <el-icon v-if="menu.icon"><component :is="menu.icon"/></el-icon>
            <span>{{ menu.title }}</span>
          </template>
          <!-- 递归渲染子菜单 -->
          <template v-for="child in menu.children">
            <el-menu-item @click="new_tab(child.title,child.url)" :index="child.url">
              <el-icon v-if="child.icon"><component :is="child.icon"/></el-icon>
              {{ child.title }}
            </el-menu-item>
          </template>
        </el-sub-menu>
        <el-menu-item v-else :index="menu.title" @click="new_tab(menu.title,menu.url)">
          <el-icon v-if="menu.icon">
            <component :is="menu.icon"/>
          </el-icon>
          {{ menu.title }}
        </el-menu-item>
      </template>
    </el-menu>

    <div style="cursor: pointer;background-color: #8a4c4c;height: 40px;line-height: 40px;text-align: center;">
      <div @click="pop_by_container('/pop/container/sub-screen-right-80','/example/new-example')">
        新页面
      </div>
    </div>
  </div>
</template>

<script setup>
import {new_tab} from './menu-tab.js'
import menus from "./menu.js";
import {pop_by_container} from "@/init/pop.js";

function getAllIndexes() {
  const indexes = [];
  menus.forEach((item) => {
    indexes.push(item.title); // 添加当前菜单的 index
    // if (item.children) {
    //   indexes.push(...getAllIndexes(item.children)); // 递归添加子菜单的 index
    // }
  });
  return indexes;
}
</script>

<style scoped lang="scss">
:deep(.el-menu) {
  border: 0 !important;
}

:deep(.el-sub-menu__title) {
  height: 40px !important;
  line-height: 40px !important;
  padding: 0 !important;
  padding-left: 5px !important;
}

:deep(.el-sub-menu .el-menu-item) {
  height: 30px !important;
  line-height: 30px !important;
}

:deep(.el-menu-item) {
  padding: 0 !important;
}

:deep(.el-menu--vertical:not(.el-menu--collapse):not(.el-menu--popup-container) .el-menu-item, .el-menu--vertical:not(.el-menu--collapse):not(.el-menu--popup-container) .el-menu-item-group__title, .el-menu--vertical:not(.el-menu--collapse):not(.el-menu--popup-container) .el-sub-menu__title) {
  padding-left: 20px !important;
}

:deep(.el-sub-menu .el-icon) {
  margin-right: 0 !important;
}

:deep(.el-sub-menu .el-sub-menu__icon-arrow) {
  right: 5px !important;
}

.el-menu-vertical-demo:not(.el-menu--collapse) {

}

.help {
  /*box-shadow: -45px 0 54px 0 rgba(82, 63, 105, 0.15);*/
  height: 30px;
  line-height: 30px;
  text-align: center;

}
:deep(.el-badge__content){
  top: 6px;
  font-size: 12px;
  padding: 0 2px;
}
</style>