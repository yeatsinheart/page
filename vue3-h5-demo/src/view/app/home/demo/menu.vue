<script setup>
import {onBeforeMount,onBeforeUnmount, onMounted, ref} from "vue";
import {appStore} from "@/config/store/app.js";
import {gameStore} from "@/config/store/game.js";
import {open_by_key} from "@/view.js";

const appState = appStore();
const gameState = gameStore();
const actions = []; //语言列表

/* 滚动*//*
onMounted(() => {
  document.querySelector('.home').style['overflow-y'] = 'hidden';
})
onBeforeUnmount(() => {
  document.querySelector('.home').style['overflow-y'] = 'auto';
})
*/
const show_sidebar = ref(false);
const params = defineProps({modelValue: null});
const emit = defineEmits(['update:modelValue', 'destroy'])
// 监听对话框隐藏时的逻辑 因为时通过pop弹出需要发起注销事件
watch(show_sidebar, (newVal) => {
  emit('update:modelValue',newVal)
});
// 当父组件更新 modelValue 时，同步更新内部数据
watch(() => params.modelValue,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(show_sidebar.value)) {
        show_sidebar.value = newVal;
      }
    }
);
onBeforeMount(()=>{
  show_sidebar.value = params.modelValue;
})

const homegameactive = ref(null);
</script>

<template>
  <div style="z-index:15;width:3.6rem;height:100%;background:var(--bg);overflow-y: auto; padding: .2rem .2rem 1.4rem .2rem;">

    <div class="game_search" @click="()=>{show_sidebar = false;open_by_key('game_search');}">
      <input type="text" :placeholder="$t('搜索')"/>
      <i class="fa-solid fa-magnifying-glass"></i>
    </div>


    <div class="col-2">
      <div v-for="(category, index) in gameState.category" :key="index" class="flex-center"
           v-show="category.categoryKey !== 'hot'"
           style="flex-direction:column;padding:.1rem;border-radius: 8px;background: var(--bg2);"
           :class="{ active: homegameactive == index }"
           @click="show_sidebar= false;open_by_key('game_category_detail',{category:category.categoryKey})"
      >
        <img class="img1x1" style="width:.5rem;" :src="category.img1x1" alt=""/>
        <span class="truncate" style="text-align: center;">{{ $t(category.name) }}</span>
      </div>
    </div>

    <div class="col-4">
      <div v-for="(brand, index) in gameState.brands" :key="index" class="flex-center"
           @click="()=>{show_sidebar = false;open_by_key('game_brand_detail',{brand:brand.brandKey})}">
        <div style="padding: .05rem;font-size: .15rem;flex-direction: column;" class="flex-center">
          <img class="img1x1" style="width: .5rem;" :src="brand.img1x1" alt=""/>
          <div class="truncate" style="text-align: center;">{{ $t(brand.name) }}</div>
        </div>
      </div>
    </div>


    <div
        v-for="(item, index) in appState.app.layoutItem.account_other"
        :key="index" class="flex-center" style="line-height: .5rem"
        @click="()=>{show_sidebar=false;open_by_key(item.openViewKey)}"
    >
      <img style="height: 0.2rem;margin-right: .1rem;" :src="item.iconI18nKey"/>
      <span style="flex-grow: 1;">{{ $t(item.titleI18nKey) }}</span>
    </div>

    <div style="height: 1.4rem;"></div>
  </div>


</template>

<style lang="scss" scoped>

.game_search {
  height: .5rem;
  background: var(--bg1);
  border: 1px solid var(--border);
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: .5rem;
  padding: 0 .1rem;

  input {
    width: 100%;
    background: unset;
    border: none;
  }
}
</style>
