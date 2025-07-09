<script setup>
import {ApiRequest} from "@/api/index.js";
import {showNotify} from "vant";
import {view_route_by_key, ViewKeyDict} from "@/tool/View.js";
import {userStore} from "@/store/user.js";

const params = defineProps({props: {}})
const claim_check = ref()
const loading = ref(true)
const showRewards = ref(false)
const showHistory = ref(false)
const notify_claim_success = ref(false)
const notify_claim_failed = ref(false)
const htmlContent = ref()

onBeforeMount(() => {

  // 非系统派发 展示可领取项目
  if("bySystem"!==params.props.howToClaim){
    ApiRequest._qD0l54JX({bonusId: params.props.bonusId}).then(res=>{
      claim_check.value = res;
    })
  }

  Promise.all([ApiRequest._qIn5tguk({bonusId: params.props.bonusId})])
      .then(([detail_response])=>{
        htmlContent.value = detail_response.htmlContent;
        loading.value = false;
      })
  .then((res) => {

  })
})

function claim() {
  notify_claim_success.value = false;
  notify_claim_failed.value = false;
  ApiRequest._CEV6992q({bonusId: params.props.bonusId}).then((res) => {
    notify_claim_success.value = res.success;
    notify_claim_failed.value = !res.success;
    setTimeout(() => {
      notify_claim_success.value = false;
      notify_claim_failed.value = false;
    },3000)
  })
}
</script>

<template>
  <van-loading class="flex-center" style="height: 100%;" v-if="loading" type="spinner" size="24px" color="var(--main)">{{ $t("加载中...") }}</van-loading>
  <div v-else>

    <div class="ck-content" style="padding: 0.28rem 0.28rem 1.24rem;background-color: var(--bg);color:var(--f3)"
         v-html="htmlContent">

    </div>
    <div class="flex-center claim-bar" style="border-top: 1px solid var(--border);">
      <div class="flex-center" style="width: 80%">领取</div>
      <div class="flex-center" style="width: 10%" @click="showRewards=true">
        <i class="fa-solid fa-gift" style="font-size: .3rem;"></i>
      </div>
      <div class="flex-center" style="width: 10%" @click="showHistory=true">
      <i class="fa-solid fa-list-ul" style="font-size: .3rem;"></i>
      </div>
    </div>
    <!--  点击打开显示所有礼包🎁    -->
    <!-- 底部弹出 -->
    <van-popup position="bottom" round :style="{ height: '50%' }" v-model:show="showRewards">
      <div style="padding: .2rem;">
        礼包内容<br/>
        礼包内容<br/>
        礼包内容<br/>
        礼包内容<br/>
        礼包内容<br/>
      </div>
    </van-popup>
    <van-popup position="bottom" round :style="{ height: '50%' }" v-model:show="showHistory">
      <div style="padding: .2rem;">
        领取历史<br/>
        领取历史<br/>
        领取历史<br/>
        领取历史<br/>
        领取历史<br/>
      </div>
    </van-popup>
<!--

    <div class="flex-center claim-bar" v-if="'viewOnly'!==claim_check.status">
      <div @click="userStore().toLogin()" v-if="'pleaseLogIn'===claim_check.status">{{ $t("未登录") }}</div>
      <div v-else-if="'incomplete'===claim_check.status">{{ $t("未满足条件") }}</div>
      <div @click="claim()" v-else-if="'claimed'===claim_check.status">{{ $t("已领取") }}</div>
      <div @click="claim()" v-else-if="'claimable'===claim_check.status">{{ $t("立即领取") }}</div>

      <van-notify v-model:show="notify_claim_success" type="success">
        <van-icon name="bell" style="margin-right: 4px;" />
        <span>{{ $t("领取成功") }}</span>
        <div class="flex-center close"  @click="notify_claim_failed=false">
          <van-icon name="close"  />
        </div>
        <van-icon name="close" style="margin-left: 4px;position: relative;right: 4px;" />
      </van-notify>
      <van-notify v-model:show="notify_claim_failed" type="danger">
        <van-icon name="bell" style="margin-right: 4px;" />
        <span>{{ $t("领取失败") }}</span>
        <div class="flex-center close"  @click="notify_claim_failed=false">
        <van-icon name="close"  />
        </div>
      </van-notify>
    </div>

-->

  </div>
</template>

<style scoped lang="scss">

.claim-bar {
  justify-content: space-around;
  position: fixed;
  bottom: 0;
  width: 100%;
  height: 1rem;
  font-size: .3rem;


  > div {
    /*background-color: var(--main);
    color: var(--main_font);*/
    padding: .12rem .24rem;
    border-radius: .12rem;
    cursor: pointer;
  }
}
:deep(.van-popup) {
  height: 100%;
}
.close{
  position: absolute;width:1rem;height:100%;right:.01rem;font-size: .4rem;
}
</style>