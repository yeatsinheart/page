<script setup>
import {computed, ref} from "vue";

import {appStore} from "@/config/store/app.js";
import {show,openby} from "@/tool/pop.js";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
import {open_by_key} from "@/view.js";

const appState = appStore();

const chosenType = ref("全部");
const hdtype = ref(0);
// appState.app.bonus.type,
//appState.app.bonus.list,

const list = computed(() => {
  return appState.app.bonus?.list||[];
});


const open_detail = (bonus) => {
  if(bonus.openBy){
      openby(bonus.openBy, bonus.detailPath, bonus);
      // openby("/ui/popup/mask", i.view, {});
  }else {
    if(bonus.detailPath){
      show( bonus.detailPath, bonus);
    }
  }
};

</script>

<template>
  <div style="height: 100%;">
    <div class="flex-center " style="position:relative;height: .9rem;line-height: .9rem;background:var(--bar_top);border-bottom-right-radius: .3rem;
    border-bottom-left-radius: .3rem;">
      <div class="tab">
        <span :class="{ active: hdtype === 0 }" @click="hdtype=0;">{{ $t("活动") }}</span>
        <span :class="{ active: hdtype === 1 }" @click="hdtype=1;">{{ $t("领取记录") }}</span>
      </div>
      <div class="flex-center" style="width: .8rem;height:100%;position: absolute;right:0;top:0;"
           @click="open_by_key('customer')">
        <i class="fa-solid fa-headset"></i>
      </div>
    </div>
    <div v-if="hdtype === 0" style="height: calc(100% - .9rem)">
      <div v-if="appState.app.bonus.type" class="flex listype" style="">
        <div :class="{ active: chosenType == '全部' }" @click="chosenType = '全部'">{{ $t("全部") }}</div>
        <div v-for="(item, index) in appState.app.bonus.type" :key="index" :class="{ active: chosenType == item }" @click="chosenType = item">
          {{ $t(item) }}
        </div>
      </div>

      <div style="height: calc(100% - .9rem);overflow-y: auto; background: var(--bg1);border-top-right-radius: .3rem;
    border-top-left-radius: .3rem;padding: 0 .2rem 1.4rem .2rem;">
        <div v-for="(item, index) in list" :key="index" @click="open_detail(item)"
             v-show="chosenType === '全部' || item.type === chosenType" style="background: var(--bg2);padding:0 .2rem;border-radius: .15rem;box-shadow: 0 3px 5px rgba(0, 0, 0, 0.08);border: 1px solid var(--border);margin-top: .2rem;">
          <div class="flex" style="margin: .15rem 0;display: flex;justify-content: space-between;"> <h4 style="color: var(--f3)">{{ item.title }}</h4> <span style="color: var(--main)">{{ $t("查看详情") }}</span> </div>
          <img :src="item.banner" alt="" style="width: 100%;"/>
        </div>
      </div>
    </div>
    <ViewImportByPath v-else path="/bonus/bonus/history/demo" style="height: calc(100% - .9rem)"/>

  </div>
</template>

<style scoped lang="scss">
  .tab {
    span {
      color: var(--bar_top_font);
      font-size: .22rem;
      margin: 0 .1rem;
    }
    .active {
      color: var(--main);
      font-size: .26rem;
      font-weight: 600;
    }

  }

  .listype {
    height:.9rem;gap:.1rem;flex-wrap:nowrap;padding: .2rem;background:var(--bg);
    div {
      padding: .1rem .24rem;
      background: var(--bg1); border-radius: .24rem;transition: all 0.3s;
      color: var(--f3);
      border: 1px solid var(--border);
    }
    .active {
      color: var(--main);
      border:1px solid var(--main);
    }
  }


</style>
