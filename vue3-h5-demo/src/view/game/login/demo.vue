<!--根据实际地址引用页面-->
<template>
  <!-- 需要监听 destroy
  最大宽度6.5rem class="flex-center"
  -->
  <!-- 遮罩层 -->
  <div class="flex-center" style="width:100%;height:100%;background: rgba(0,0,0,.5);">
    <!--  窗体  -->
    <div style="width:100%;height: 100%;flex-direction: column;position: relative">
      <div class="flex-center" style="position: absolute;right:0;width: 1rem;height: 1rem;z-index: 3000;" @click="back">
        <i class="fa-sharp fa-regular fa-circle-xmark" style="font-size: .45rem;"></i>
      </div>
      <div style="width:100%;height:100%;background-color:var(--bg);overflow-y: auto;">
        <!--     动态界面？？<ViewImportByPath :path="howToLogin.viewPath"/>   -->
        <iframe v-if="howToLogin.url" :src="howToLogin.url" allowtransparency="false"
                frameborder="0"
                style="background-color:var(--bg);width:100%;height: 100%; border: 0;"></iframe>
        <iframe v-else-if="howToLogin.html" :srcdoc="howToLogin.html" allowtransparency="false"
                frameborder="0"
                style="background-color:var(--bg);width:100%;height: 100%; border: 0;"></iframe>
        <van-empty v-else></van-empty>
      </div>
    </div>
  </div>

</template>

<script setup>
import {gameStore} from "@/config/store/game.js";
import router from "@/config/router"
const emit = defineEmits();
const howToLogin = ref({});

const back = () => {
  router.back();
};

onBeforeMount(() => {
  howToLogin.value = JSON.parse(JSON.stringify(gameStore().login_game_res))
})
</script>
