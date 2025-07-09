<script setup>
import {appStore} from "@/store/app.js";
import {gameStore} from "@/store/game.js";
const gameState = gameStore()
const searchvalue = ref("");
const active = ref(0);

const clicksearch = () => {
  console.log("search");
};

import { useRoute } from "vue-router";
import GameListViewX3 from "@/view/game/ui/game-list-view-x3.vue";
import router from "@/router/index.js";
import {view_route_by_key} from "@/tool/View.js";
const route = useRoute();
const categories = ref([]);
const category_chosen = ref({});
const brand_chosen = ref({});
const games = ref([]);
function choose_brand(brand) {
  brand_chosen.value=brand;
  categories.value = gameState.all_category_of_brand(brand_chosen.value.brandKey);
  choose_category(categories.value[0]);
  show_choice.value=false;
}
function choose_category(category){
  category_chosen.value = category;
  games.value = gameStore().byCategoryAndBrand(category.categoryKey, brand_chosen.value.brandKey);
}
onBeforeMount(()=>{
  brand_chosen.value=gameState.brands.find(v=>v.brandKey===route.query.brand)||gameState.brands[0]
  categories.value = gameState.all_category_of_brand(brand_chosen.value.brandKey);
  let category = categories.value.find(v=>v.categoryKey===route.query.category)||categories.value[0]
  choose_category(category)
})
const show_choice = ref(false);
</script>

<template>
  <div style="height: 100%;">
    <div style="height: .9rem;background-color: var(--bg1);justify-content: space-between" class="flex-center">
      <div style="width: 1rem" class="flex-center" @click="router.back();"> <i class="fa-solid fa-chevron-left"></i> </div>
      <div  @click="show_choice=!show_choice;" class="flex-center">
        {{$t(brand_chosen.name)}}
        <i class="fa-solid fa-angle-down" :class="show_choice?'fa-angle-up':'fa-angle-down'" style="padding:0 .2rem;"></i>
      </div>
      <div style="width: 1rem" class="flex-center" @click="view_route_by_key('customer')"><i class="fa-solid fa-headset"></i></div>
    </div>

    <!--  品牌选择  -->
    <div :style="show_choice?'':'height:0;opacity:0;left:-9999px;z-index: -100;'"
         class="col-5 max-width"
         style="margin:0;position:absolute;width: 100%;z-index: 100;background-color: var(--bg2);max-height: calc(100% - .9rem);overflow-y:auto;transition: all .3s;padding:.2rem;">
      <div v-for="brand in gameState.brands"
           class="flex-center" style="flex-direction: column;border-radius: .18rem;padding:.1rem;justify-content: space-between;"
           @click="choose_brand(brand)"
      >
        <img v-if="brand.img3x4" :src="brand.img3x4" alt="" class="img3x4" style="width: 100%;"/>
        <div class="truncate">{{ $t(brand.name) }}</div>
      </div>
    </div>

    <div style="background: var(--bg);padding: 0 .2rem .2rem .2rem;height: calc(100% - .9rem);">
      <div class="left" style="height: calc(100%);overflow-y: auto;color: var(--f3);float: left">
        <div v-for="(category, index) in categories" :key="index"
             v-show="category?.categoryKey!=='hot'"
             style="height: 1.05rem;width: 1.5rem;border-radius: .18rem;margin-top:.18rem;flex-direction: column"
             :style="category_chosen.categoryKey === category.categoryKey?'background:var(--main);':'background:var(--bg1);'"
             @click="choose_category(category)"
             class="flex-center"
        >
          <img v-if="category.img1x1" :src="category.img1x1"  class="img1x1" style="width: .5rem;" alt=""/>
          <div v-else style="width: .5rem;height:.5rem;"></div>
          <div class="truncate flex-center">{{ $t(category.name) }}</div>
        </div>
      </div>

      <div style="width: calc(100% - 1.8rem);height:100%;overflow-y: auto;padding:.2rem 0;float: right;">
        <!--          <div class="flex">
                    <div :class="{ active: active == 0 }" @click="active = 0">All</div>
                    <div :class="{ active: active == 1 }" @click="active = 1">Hot</div>
                  </div>-->
          <GameListViewX3 v-model="games"/>

      </div>
      <!--      <div class="pagination">
              <van-pagination
                v-model="currentPage"
                :total-items="50"
                :show-page-size="3"
              >
                <template #prev-text>
                  <van-icon name="arrow-left" />
                </template>
                <template #next-text>
                  <van-icon name="arrow" />
                </template>
                <template #page="{ text }">{{ text }}</template>
              </van-pagination>
            </div>-->
    </div>
  </div>
</template>

<style lang="scss" scoped>
:deep(.van-field__body){
  width: 100%;
}
</style>

