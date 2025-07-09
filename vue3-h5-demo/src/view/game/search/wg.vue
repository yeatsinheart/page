<template>
  <div style="height: 100%;">

    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div class="flex-center">
        {{$t('游戏搜索')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="view_route_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <div class="game_search" style="height:calc(100% - .9rem);">
      <div class="top">
        <input type="text" :placeholder="$t('搜索')" v-model="search_word"/>
        <i class="fa-solid fa-magnifying-glass"></i>
      </div>
      <van-tabs
        v-model:active="active"
        background="unset"
        title-active-color="var(--main)"
        title-inactive-color="var(--f3)"
        color="var(--main)"
        style="height: calc(100% - 1.2rem);"
      >
        <van-tab>
          <template #title><i class="fa-solid fa-magnifying-glass"></i>{{ $t('搜索结果') }}</template>
          <div v-if="gameStore().games_search.length>0" style="padding:0 .2rem;width:100%;">
            <GameListViewX4 v-model="gameStore().games_search"/>
          </div>
          <ViewImportByPath v-else :path="ViewPathDict.nomore" style="padding:0 .2rem;width:100%;"></ViewImportByPath>
        </van-tab>
        <van-tab>
          <template #title><i class="fa-solid fa-clock"></i>{{$t("最近游戏")}}</template>
          <div class="col-3">
            <div v-for="item in 8" :key="item">
              <div style="margin: 5px;">
                <img
                  src="https://cdntoos.superace-pk.com/game_pictures/p/1073/EA/64/1/custom_PHP.avif"
                  alt=""
                />
              </div>
            </div>
          </div>
          <ViewImportByPath :path="ViewPathDict.nomore"></ViewImportByPath>
        </van-tab>
        <van-tab>
          <template #title><i class="fa-solid fa-star"></i>{{$t("我的收藏")}}</template>
          <div class="col-3">
            <div v-for="item in 8" :key="item">
              <div style="margin: 5px;">
                <img
                  src="https://cdntoos.superace-pk.com/game_pictures/p/1073/EA/82/6/custom_PHP.avif"
                  alt=""
                />
              </div>
            </div>
          </div>
          <ViewImportByPath :path="ViewPathDict.nomore"></ViewImportByPath>
        </van-tab>
      </van-tabs>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import {view_route_by_key, ViewPathDict} from "@/tool/View.js";
import {gameStore} from "@/store/game.js";
import GameListViewX3 from "@/view/game/ui/game-list-view-x3.vue";
import GameListViewX4 from "@/view/game/ui/game-list-view-x4.vue";
import router from "@/router/index.js";
const active = ref(0);
const search_word = ref("");
watch(() => search_word.value, (val) => {
  gameStore().search(search_word.value)
})
</script>

<style lang="scss" scoped>
.game_search {
  .top {
    height: .6rem;
    background: var(--bg2);
    border: 1px solid var(--border);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 15px;
    margin: 15px;
    border-radius: 30px;
    input {
      background: unset;
      border: none;
      width: 100%;
    }
  }
  .fa-solid {
    margin: 0 5px;
  }
  .col-3 {
    // height: 200px;
    img {
      width: 100%;
    }
  }
}

/*tab高度*/
:deep(.van-tabs--line .van-tabs__wrap) {
  height: .5rem;
  border-bottom: 0.01rem solid var(--border);
}
/*下划线宽度+颜色*/
:deep(.van-tabs__line) {
  width: 2rem;
  height: 0.06rem;
  background-color: var(--main);
  border-radius: 0.06rem 0.06rem 0 0;
}
/*tab内容窗高度*/
:deep(.van-tabs__content){
  height: calc(100% - .5rem);overflow-y: auto;
}
</style>
