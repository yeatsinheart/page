<script setup>
import { useRouter } from "vue-router";
import {gameStore} from "@/store/game.js";
import {format_str} from "@/tool/string.js";
import {appStore} from "@/store/app.js";
import GameListViewX3 from "../game-list-view-x3.vue";
const active = ref(6);

const gameState = gameStore();
/** 动态传参数为 props*/
const data = defineProps({
  props: {categoryKey: null,}
});
const filteredGames = computed(() => {
  return gameState.game_hot.filter((element, index) => index < active.value);
})
</script>

<template>
  <div style="padding:0 .2rem;">
        <GameListViewX3 v-model="filteredGames"/>

    <div class="More" @click="active = gameState.game_hot.length" v-if="active < gameState.game_hot.length" style="text-align: center;margin-top:.16rem;">
      <p style="color: var(--f1)">{{format_str($t("当前展示 %s 共 %s"),active,gameState.game_hot.length)}}</p>
      <p style="color: var(--f3)">{{$t("显示更多")}}
        <i class="fa-solid fa-angles-down"></i>
      </p>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.hot_game {
  display: flex;
  flex-wrap: wrap;
  .item {
    width: 31%;
    height: 3rem;
    margin: 5px 1.1%;
    border-radius: 15px;
    overflow: hidden;
    .i-icon {
      position: absolute;
      z-index: 1;
      font-size: 30px;
      color: yellow;
      width: 30px;
      height: 30px;
      left: 5px;
      top: 5px;
    }
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
  .More {
    height: 50px;
    text-align: center;
    width: 100%;
    color: var(--f3);
    margin: 10px 0;
    .c2 {
      color: var(--f2);
    }
  }
}
</style>
 
