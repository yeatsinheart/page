<script setup>
import mitt from "@/mitt";
import { ref } from "vue";
const scrollToref = ref(null);
const homegameactive = ref(null);
mitt.on("typescrollTo", (i) => {
  scrollToref.value && scrollToref.value.scrollTo(i);
});
import { gameStore } from "@/store/game.js";
const gameState = gameStore();
onBeforeMount(()=>{
})
</script>

<template>
  <div class="game_product_wg">
    <van-tabs v-model:active="homegameactive" scrollspy sticky ref="scrollToref">
      <van-tab v-for="(item, index) in gameState.category" :title="item.title" :key="index">
        <template #title>
          <div class="typehead flex-center" style="height: 100%;">
            <img :src="item.img1x1" alt="" class="img1x1" style="width: .5rem;"/>
            <div class="truncate">{{ $t(item.name) }}</div>
          </div>
        </template>
        <div>
          <ViewImportByPath :path="item.uiHome" :props="{ categoryKey: item.categoryKey }"/>
        </div>
      </van-tab>
    </van-tabs>
  </div>
</template>

<style lang="scss" scoped>
:deep(.van-tab--grow){
  padding: 0;
}
:deep(.van-sticky) {
  background: var(--bg1);
  padding: 0 0.2rem;
}
:deep(.van-tabs--line .van-tabs__wrap) {
  height: 1.1rem;
}
:deep(.van-tabs__line) {
  width: 1.5rem;
  height: 0.06rem;
  background-color: var(--main);
  border-radius: 0.06rem 0.06rem 0 0;
}
.truncate{text-align: center;}
:deep(
    .van-tabs__nav--line.van-tabs__nav--shrink,
    .van-tabs__nav--line.van-tabs__nav--complete
  ) {
  padding-left: 0;
}
.game_product_wg {
  .van-tabs--line .van-tabs__wrap {
    height: 1.1rem;
    border-bottom: 0.01rem solid var(--border);
  }

  :deep(.van-tabs__nav) {
    background: var(--bg1);
    .typehead {
      display: flex;
      flex-direction: column;
      align-items: center;
      span {
        color: var(--f2);
      }
    }
    .van-tab--grow {
      width: 1.5rem;
      padding-bottom: 5px;
    }
  }
  /*
  :deep(.van-tabs__content) {
    margin: 0.3rem 0;
  }*/
  .grid-nr {
    position: relative;
    right: -3px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    div {
      position: relative;
      width: 32%;
      height: 180px;
      margin: 5px 2px;
      border-radius: 15px;
      overflow: hidden;
      img {
        position: absolute;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
      }
      span {
        position: absolute;
        bottom: 5px;
        width: 100%;
        text-align: center;
      }
    }
  }
}
</style>
 
