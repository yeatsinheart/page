<script setup>

import {appStore} from "@/config/store/app.js";
import {ApiRequest} from "@/api/index.js";
import router from "@/config/router/index.js";
import {gameStore} from "@/config/store/game.js";

const games = ref([])
const params = defineProps({modelValue: null})

// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (newVal !== games.value) {games.value = newVal;}
    }
);
onBeforeMount(() => {
  games.value = params.modelValue || []
})

</script>

<template>
  <div v-if="games.length>0" class="col-3">
    <div v-for="(game,index) in games" :key="game.gameKey" @click="()=>{if('on'===game.status){gameStore().login(game.gameKey)}}"
    style="border-radius: .18rem;">
      <div style="width: 100%;position: relative;">
        <img v-if="'maintain'===game.status" :src="appStore().app.info.maintain1x1" class="img3x4" style="position: absolute;">
        <img v-lazy="game.img3x4" class="img3x4"/>
        <div class="" style="width:100%;text-align: center;position: absolute;bottom: 0;background: linear-gradient(transparent, rgba(1, 1, 1, 0.8));color:#fff;">{{game.name}}</div>
      </div>
    </div>
  </div>
  <van-empty v-else></van-empty>
</template>

<style lang="scss" scoped>

</style>