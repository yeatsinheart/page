<script setup>

import {gameStore} from "@/store/game.js";
import {format_str} from "@/tool/string.js";
import {view_route_by_key} from "@/tool/View.js";
import {appStore} from "@/store/app.js";

const gameState = gameStore();
/** 动态传参数为 props*/
const data = defineProps({props: {categoryKey: null,}});
const active = ref(6);
</script>

<template>
<div style="padding:0 .2rem;">
  <template v-for="(category, category_index) in gameState.category" :key="'category'+category_index">
    <template v-if="category.categoryKey===props.categoryKey">
      <div class="flex" style="line-height: 0.53333rem;padding: .1rem .1rem;">
        <div class="flex " style="flex-grow: 1">
          <img class="img1x1" style="width: .5rem;" :src="category.img1x1" alt=""/>
          <div style="padding-left: .1rem;">{{ $t(category.name) }}</div>
        </div>
        <div style="flex-shrink: 0;line-height: 0.53333rem;width: 1.4rem;text-align: right;padding-right: .2rem;"
          @click="view_route_by_key('game_category_detail',{category:props.categoryKey})">
          {{$t("更多")}}
        </div>
      </div>

    </template>
  </template>
    <template v-for="(category, category_index) in gameState.category" :key="'category'+category_index">
      <template v-if="category.categoryKey===props.categoryKey">
        <div class="col-3">
        <template v-for="(brand, brand_index) in category.brands" :key="'brand'+brand_index">
          <div v-if="brand_index < active" style="border-radius: .18rem;position: relative;"
               @click="view_route_by_key('game_brand_detail',{category:props.categoryKey,brand:brand.brandKey})">
            <img v-if="'maintain'===brand.status" :src="appStore().app.info.maintain1x1" style="position: absolute;width: 100%;object-fit: contain;aspect-ratio:3/4;">
            <img v-lazy="brand.img3x4" class="img3x4" />
            <div style="width:100%;text-align: center;position: absolute;bottom: 0;background: linear-gradient(transparent, rgba(1, 1, 1, 0.8));color:#fff;">{{$t(brand.name)}}</div>
          </div>
        </template>
        </div>
        <div class="More" @click="active = category.brands.length" v-if="active < category.brands.length" style="text-align: center;margin-top:.16rem;">
          <p style="color: var(--f1)">{{format_str($t("当前展示 %s 共 %s"),active,category.brands.length)}}</p>
          <p style="color: var(--f3)">{{$t("显示更多")}}
            <i class="fa-solid fa-angles-down"></i>
          </p>
        </div>
      </template>
    </template>
</div>

</template>
