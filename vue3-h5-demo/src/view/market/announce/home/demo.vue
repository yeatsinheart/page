<script setup>
import { ref, reactive } from "vue";
import { useRouter } from "vue-router";

import { appStore } from "@/config/store/app.js";
import dayjs from "dayjs";
import router from "@/config/router/index.js";
import {open_by_key} from "@/view.js";
const appState = appStore();
</script>

<template>
  <div class="message " style="height: 100%">
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div class="flex-center">
        {{$t('公告')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="open_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <ul>
      <li v-for="(item,index) in appState.app.announceList" :key="index">
        <div class="top">
          <i class="fa-solid fa-volume-off"></i>
          <span>{{ item.title }}</span>
        </div>
        <div class="content ck-content" v-html="item.html">
        </div>
        <div>{{dayjs(item.createAt).format('YYYY-MM-DD HH:mm:ss')}}</div>
      </li>
    </ul>
  </div>
</template>

<style scoped lang="scss">
.message {
  height: 100%;
  overflow: auto;
  ul {
    margin: 30px 15px;
    li {
      background: var(--bg1);
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
      .top{
        font-size: .4rem;
        .fa-solid{
          font-size: .4rem;
        }
        span{
          margin-left: 15px;
          
        }
      }
      .content{
        margin: 10px 0;
      }
    }
  }
}
</style>
