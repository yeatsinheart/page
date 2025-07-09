<script setup>
import {onBeforeMount, ref} from "vue";
import {appStore} from "@/config/store/app.js";
import {userStore} from "@/config/store/user.js";
import Menu from "./menu.vue";
import ViewImportByPath from "@/tool/ViewImportByPath.vue";
import {open_by_key, ViewKeyDict, ViewKeyPathMap} from "@/view.js";

onBeforeMount(() => {
  //获取配置数据 需要弹出在弹出 排前面弹出的会最后显示
 /* openby("/ui/popup/empty", appStore().app.view.bonus_pop.dir);
  setTimeout(() => {
    openby("/ui/popup/empty", appStore().app.view.announce_pop.dir);
  }, 300)
*/
});

const changemenu = () => {
  show_sidebar.value = !show_sidebar.value;
};

const show_sidebar = ref(false);

</script>

<template>
  <div :style="(show_sidebar?'overflow-y:hidden !important;':'overflow-y:auto;')+''
  +(appStore().app?.info?.home_bg? 'background:url(' + appStore().app.info.home_bg + ');': '' )
  " class="home">

    <div class="brand_bar" style="background: var(--bg1);padding: 0 0.2rem;">
      <div style=" display: flex;height: 0.9rem;justify-content: space-between;align-items: center;">
        <div class="flex-center">
          <div class="flex-center" style="height: .9rem" @click="changemenu">
            <i :class="!show_sidebar ? 'fa-indent' : 'fa-outdent'" class="fa-solid fa-indent"
               style="color: var(--main);font-size: 0.3rem;margin-right: 0.2rem;"></i>
          </div>
          <img :src="appStore().app?.info?.logo330x100" alt="" style="height: 0.74rem"/>
        </div>
        <div class="right">
          <div v-show="!userStore().isLoggedIn" class="flex-center">
            <div style="background: var(--main);color: var(--main_font);"
                 @click="userStore().toRegister()">
              {{ $t("注册") }}
            </div>
            <div style="color: var(--main);border: 1px solid var(--main);"
                 @click="userStore().toLogin()">
              {{ $t("登录") }}
            </div>
          </div>

          <span class="flex-center" style="height: 0.9rem"
                @click="open_by_key('game_search')">
            <i class="fa-solid fa-magnifying-glass"
               style="color: var(--main); font-size: 0.3rem; margin-left: 0.2rem"></i>
          </span>

        </div>
      </div>
    </div>

    <div v-if="show_sidebar" class="mask" @click="show_sidebar = false"></div>
    <div :style="'height:calc(100% - .9rem);position:relative;background-attachment: fixed;'">
      <Menu v-if="show_sidebar" style="position: absolute;height:100%;" v-model="show_sidebar"/>

      <ViewImportByPath :path="ViewKeyPathMap.swiper"></ViewImportByPath>
      <ViewImportByPath :path="ViewKeyPathMap.marquee"></ViewImportByPath>
      <ViewImportByPath :path="ViewKeyPathMap.game_home"></ViewImportByPath>

      <div class="ck-content" style="padding:.2rem;background-color: var(--bg1);"
           v-html="appStore().app.info.description"></div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.home {
  height: 100%;

  .brand_bar {
    .right {
      display: flex;
      align-items: center;

      div {
        padding: 0.1rem 0.2rem;
        margin: 0 0.1rem;
        border-radius: 0.1rem;
      }
    }
  }

  .h-info {
    padding: 0.2rem;

    .top {
      display: flex;
      padding-bottom: 15px;
      border-bottom: 1px solid var(--border);

      .item {
        width: 33%;
        padding-left: 5px;

        div {
          margin: 5px 0;
        }

        .title {
        }
      }
    }

    .middle {
      padding-bottom: 15px;
      border-bottom: 1px solid var(--border);

      .title {
        line-height: 40px;
      }

      .us {
        display: flex;
        margin-bottom: 25px;

        img {
          width: 40px;
          height: 40px;
          margin-right: 10px;
          border-radius: 50%;
        }
      }

      span {
        word-break: break-all;
        text-align: center;
        font-size: 12px;
        display: block;
      }
    }
  }
}

.rocket {
  position: absolute;
  bottom: 1.5rem;
  right: 0.3rem;
  background: var(--bg3);
  display: flex;
  border-radius: 50%;
  padding: 0.2rem;
  z-index: 1;
}
</style>
<style lang="scss">
.van-back-top {
  background: #2b4258;
}
</style>
