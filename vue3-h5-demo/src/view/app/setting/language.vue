<!--根据实际地址引用页面-->
<template>
  <div class="language-choose">
    <div @click="setLanguage(language)" class="flex-center" v-for="(language) in appState.app.languageList" :key="language.code" style="padding:.1rem 0;color: var(--f4);">
<!--        <i class="fa-solid fa-globe"></i>-->
        <p :style="(language.code===localLanguage)?'color: var(--main)':''">{{language.name }}</p>
    </div>
  </div>

</template>

<script setup>
import {appStore} from "@/store/app.js";
import {changeLanguage} from "@/lang/18n.js";

const appState = appStore();
const localLanguage = ref("");
const setLanguage = async (language) => {
  try {
    localStorage.setItem('Language',language.code)
    appState.language = language.code
    await changeLanguage(language.code)
    localLanguage.value=language.code;
  } catch (error) {
  }
}
onBeforeMount(()=>{
  localLanguage.value=localStorage.getItem('Language')
})
</script>
<style scoped>
.language-choose>div:not(:last-child){
  border-bottom:.01rem solid var(--f4);
}
</style>
