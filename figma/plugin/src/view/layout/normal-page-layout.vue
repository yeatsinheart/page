<template>
  <div style="padding: 4px;height:100%;">
    <div class="flex-column page" style="">
      <template v-if="$slots.header">
        <div style="width:100%;padding: 4px;">
          <slot name="header"></slot>
        </div>
        <div class="border"></div>
      </template>

      <div v-if="$slots.main" style="width:100%;height:100%;overflow: auto;padding: 4px;">
        <slot name="main"></slot>
      </div>

      <template v-if="$slots.footer">
        <div class="border"></div>
        <div style="padding: 4px;width:100%;">
          <slot name="footer"></slot>
        </div>
      </template>
    </div>
  </div>

</template>
<script setup>
</script>

<style scoped lang="scss">
.page {
  border: 1px solid var(--border);
  border-radius: 4px;
  height: 100%;
  /* 高度 100% - 2marin 2border */
}

.border {
  height: 1px;
  border-top: 1px solid var(--border);
}

/*整个滚动条*/
*::-webkit-scrollbar {
  height: 7px;width: 5px;display: block; cursor: pointer;
}
/*定义滚动条轨道 内阴影+圆角*/
*::-webkit-scrollbar-track {
  border-radius: 10px;
  background-color:  rgba(9, 38, 180, 0.1);
}
/*定义滑块*/
*::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background-color:  var(--c1);
}


</style>