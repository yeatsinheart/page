<script setup>
import router from "@/config/outer/index.js";
import {open_by_key} from "@/view.js";
</script>

<template>
  <div class="message" style="height: 100%;">

    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
    <!--   @click="router.back();"   <i class="fa-solid fa-chevron-left"></i> -->
      <div class="flex-center" style="width: 1rem"></div>
      <div class="flex-center">
        {{$t('通知消息')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="open_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <ul>

      <li v-for="item in 8" :key="item">
        <div class="top">
          <i class="fa-solid fa-volume-off"></i>
          <span>ANNOUNCEMENT!!!</span>
        </div>
        <div class="content">
          This is a test announcement, please pay attention to the follow-up
          notice, if you have any questions, please contact ZANE
        </div>
        <div>2024/11/12 13 :11</div>
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
