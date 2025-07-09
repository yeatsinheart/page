<script setup>
import {gameStore} from "@/store/game.js";
import router from "@/router/index.js";
import {useRoute} from "vue-router";
import GameListViewX3 from "@/view/game/ui/game-list-view-x3.vue";
import {view_route_by_key} from "@/tool/View.js";

const gameState = gameStore()
const searchvalue = ref("");
const active = ref(0);

const clicksearch = () => {
  console.log("search");
};

const route = useRoute();
const category_chosen = ref({});
const brands = ref([]);
const brand_chosen = ref({});
const games = ref([]);

function choose_category(category) {
  category_chosen.value = category
  brands.value = category?.brands || [];
  choose_brand(brands.value[0]);
  show_choice.value = false;
}

function choose_brand(brand) {
  brand_chosen.value = brand;
  games.value = gameStore().byCategoryAndBrand(category_chosen.value.categoryKey, brand.brandKey);
}

onBeforeMount(() => {
  let category_key = route.query.category;
  if (!category_key) {
    category_key = gameStore().category.find(v => v.categoryKey !== 'hot').categoryKey
  }
  let category = gameState.category.find(v => v.categoryKey !== 'hot' && v.categoryKey === category_key)
  choose_category(category)
})
const show_choice = ref(false)
</script>

<template>
  <div style="height: 100%;">
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div @click="show_choice=!show_choice;" class="flex-center">
        {{ $t(category_chosen.name) }}
        <i class="fa-solid fa-angle-down" :class="show_choice?'fa-angle-up':'fa-angle-down'" style="padding:0 .2rem;"></i>
      </div>
      <div class="flex-center" style="width: 1rem" @click="view_route_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>
    <!--  大类选择  -->
    <div :style="show_choice?'':'height:0;opacity:0;left:-9999px;z-index: -100;'"
         class="col-5 max-width"
         style="margin:0;position:absolute;width: 100%;z-index: 100;background-color: var(--bg2);max-height: calc(100% - .9rem);overflow-y:auto;transition: all .3s;padding:.2rem;">
      <div v-for="category in gameState.category.filter(value => value.categoryKey!=='hot')"
           class="flex-center" style="flex-direction: column;aspect-ratio:1/1;border-radius: .18rem;padding:.1rem;"
           @click="choose_category(category)"
      >
        <img v-if="category.img1x1" :src="category.img1x1" alt="" class="img1x1" style="width: .5rem;"/>
        <div class="truncate">{{ $t(category.name) }}</div>
      </div>
    </div>

    <div style="background: var(--bg);padding: 0 .2rem .2rem .2rem;height: calc(100% - .9rem);">
      <div class="left" style="height: calc(100%);overflow-y: auto;color: var(--f3);float: left">
        <div v-for="(brand, index) in brands" :key="index"
             :style="brand_chosen.brandKey === brand.brandKey?'background:var(--main);':'background:var(--bg1);'"
             class="flex-center"
             style="height: 1.05rem;width: 1.5rem;border-radius: .18rem;margin-top:.18rem;flex-direction: column"
             @click="choose_brand(brand)"
        >
          <img v-if="brand.img1x1" :src="brand.img1x1" alt="" class="img1x1" style="width: .5rem;"/>
          <div v-else class="img1x1" style="width: .5rem;height:.5rem;"></div>
          <div class="truncate flex-center">{{ $t(brand.name) }}</div>
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
:deep(.van-field__body) {
  width: 100%;
}
</style>

