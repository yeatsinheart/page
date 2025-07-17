<script setup>

import {colorStore} from "@/view/color/base/color.js";
</script>

<template>
  <div style="height: 100%;position: relative;">
    <div :style="{backgroundColor: colorStore().container.browser }" class="browser"
         style="padding: 10px;height: 100%;">
      <div :style="{backgroundColor: colorStore().container.bar_top.bg,color:colorStore().container.bar_top.font }"
           class="theme flex flex-center"
           style="height: 50px;">
        头部
      </div>
      <div :style="{backgroundColor: colorStore().container.page }" class="page"
           style="height: 100%;overflow-y: auto;">

        <div :style="{
          backgroundColor: colorStore().container.card.bg,
             border: `1px solid ${colorStore().container.card.border}`,
             boxShadow: `1px 0 10px 10px ${colorStore().container.card.shadow}`}" class="card flex flex-space"
             style="height: 50px;">

          <div :style="{color: colorStore().container.font.title }" class="flex flex-center">标题</div>
          <div :style="{color: colorStore().container.font.sub_title }" class="flex flex-center">子标题</div>
          <div :style="{color: colorStore().container.font.normal }" class="flex flex-center">通用</div>
          <div :style="{color: colorStore().container.font.placeholder }" class="flex flex-center">说明</div>
          <div :style="{color: colorStore().container.font.disabled }" class="flex flex-center">备案</div>
        </div>

        <div :style="{backgroundColor: colorStore().container.gap.bg }" class="gap" style="height: 50px;"></div>

        <div :style="{backgroundColor: colorStore().container.gap.bg }" class="gap" style="height: 50px;"></div>

        <div :style="{backgroundColor: colorStore().container.card.bg }" class="card" style="padding:10px;">
          <div :style="{backgroundColor: colorStore().container.div1.bg }" class="div1" style="height: 50px;"></div>

          <div :style="{backgroundColor: colorStore().container.div1.bg }" class="div1" style="padding:20px;">
            <div :style="{backgroundColor: colorStore().container.div2.bg }" class="div2" style="height: 50px;"></div>
          </div>

          <div class="flex" style="margin: 10px;">
            <div :style="{backgroundColor: colorStore().colors.theme.color,color:colorStore().colors.theme.font }"
                 class="theme flex flex-center"
                 style="height: 50px;width: 100%;">
              主题
            </div>

            <div  style="height: 50px;width: 100%;border: 1px solid black;"
                  :style="{color:colorStore().colors.theme.color,borderColor: colorStore().colors.theme.color }"
                  class="theme flex flex-center"
            >
              主题
            </div>
          </div>


        </div>

        <div style="height: 50%;"></div>

      </div>

      <div :style="{
        backgroundColor: colorStore().container.bar_bottom.bg,
           color:colorStore().container.bar_bottom.font
      }" class="theme flex flex-center"
           style="height: 50px;position:absolute;bottom: 0;width: calc(100% - 20px);">
        底部
      </div>

    </div>
  </div>
</template>

<style lang="scss" scoped>
.card {
  margin: 10px;
}
</style>