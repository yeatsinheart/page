import {createApp} from 'vue'
import { view_get_by_path, ViewKeyPathMap} from "@/view.js";
import i18n from "@/config/lang/18n";
import router, {addRoute} from "@/config/router";
import {Lazyload} from "vant";
import {createPinia} from "pinia";

import piniaPluginPersistedstate from "pinia-plugin-persistedstate"; //引入持久化插件
import vLoading from "@/tool/v-loading.js";
import {userStore} from "@/config/store/user.js";
import {appStore} from "@/config/store/app.js";

const app = createApp({}); //先用空对象创建 app

//创建pinia实例
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

app.use(pinia).use(i18n).directive("loading", vLoading).use(Lazyload, {
    loading: "imgI18nKey",
    lazyComponent: true,
});

// 解析 URL 并存储邀请码
const urlParams = new URLSearchParams(window.location.search);
const inviteCode = urlParams.get("ic");
if (inviteCode) {
    console.log("邀请码:", inviteCode);
    userStore().inviteCode=inviteCode;
}

const init = async () => {
    await appStore().init()
}

init().then(() => {
    app._component = defineAsyncComponent(view_get_by_path(ViewKeyPathMap.app_layout))
    console.debug("已完成初始化",ViewKeyPathMap.app_layout)
    setTimeout(() => {
        app.use(router)
        app.mount("#app");
    }, 200);
}).catch(console.error);

window.addEventListener('resize', () => {
    const isMobile = window.innerWidth <= 768;
    // 做动态处理
});

