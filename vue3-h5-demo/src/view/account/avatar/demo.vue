<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import {ApiRequest} from "@/api/index.js";
import {userStore} from "@/config/store/user.js";
import {showToast} from "vant";
import i18n from "@/config/lang/18n.js";
import {view_route_by_key} from "@/tool/View.js";
const router = useRouter();
const avatarIndex = ref();
const avatars = ref([]);
const changeAvatar = (index) => {
  avatarIndex.value = index;
  // router.go(-1);
};
onBeforeMount(()=>{
  ApiRequest._QnVID0lT().then((res)=>{
    avatars.value = res;
    res.forEach((item,index)=>{
      if(item===userStore().account.avatar){
        avatarIndex.value = index;
      }
    })
  })
})
function update() {
  ApiRequest._TGXC9vB5({avatarIndex:avatarIndex.value}).then((res)=>{
    if(res.success){
      showToast(i18n.global.t('修改成功'))
      userStore().account.avatar=avatars.value[avatarIndex.value];
    }
  })
}
</script>
<template>
  <div style="height:100%">
    <div class="flex-center" style="height: .9rem;background-color: var(--bg1);justify-content: space-between">
      <div class="flex-center" style="width: 1rem" @click="router.back();"><i class="fa-solid fa-chevron-left"></i>
      </div>
      <div class="flex-center">
        {{$t('更换头像')}}
      </div>
      <div class="flex-center" style="width: 1rem" @click="view_route_by_key('customer')">
        <i class="fa-solid fa-headset"></i></div>
    </div>

    <div class="avatarList">
      <div class="col-4">
        <div
            v-for="(avatar, index) in avatars"
            @click="changeAvatar(index)"
            :key="index"
        >
          <!--  src="/src/assets/images/feedbackImg.png"      -->
          <img :src="avatar" :class="{ imgActive: avatarIndex === index }"
              alt=""
          />
          <van-icon v-show="avatarIndex === index" name="checked" />
        </div>
      </div>
    </div>
    <div class="max-width" style="position: absolute;bottom: 0;">
      <van-button type="primary" block @click="update()">保存</van-button>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.avatarList {
  height: calc(100vh - 0.9rem);
  overflow: auto;
  div {
    position: relative;
  }
  img {
    width: 96%;
    height: 120px;
    margin-bottom: 15px;
    border-radius: 15px;
    box-sizing: border-box;
    border: 2.5px solid #ffd000;
  }
  .imgActive {
    border: 2.5px solid #f2413b;
  }
  :deep(.van-icon) {
    position: absolute;
    bottom: 25px;
    right: 15px;
    font-size: 25px;
    color: #f2413b;
  }
}
</style>
