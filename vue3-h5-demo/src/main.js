import {createApp} from 'vue'
import {view_get_by_path, ViewKeyPathMap} from "@/view.js";
import i18n from "@/config/lang/18n";
import router, {addRoute} from "@/config/router";
import {Lazyload} from "vant";
import {createPinia} from "pinia";

import piniaPluginPersistedstate from "pinia-plugin-persistedstate"; //引入持久化插件
import vLoading from "@/tool/v-loading.js";
import {userStore} from "@/config/store/user.js";
import {appStore} from "@/config/store/app.js";
import {ApiRequest} from "@/api/index.js";

//创建pinia实例
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

ApiRequest.getApp().then((app_data => {
    // 首选语言
    let chosen_language = localStorage.getItem('Language');
    let right_language = app_data.languageList.some(item => item.code === chosen_language);
    if (!right_language) {
        chosen_language = app_data.languageList[0].code;
    }
    // 页面组合
    let viewMap = app_data.view;
    for (let view_key in viewMap) {
        ViewKeyPathMap[view_key] = viewMap[view_key].path;
    }
    // 默认首页
    addRoute("", ViewKeyPathMap.home);
    // ViewKeyPathMap 写入路由中，弹出的界面不写入
    for (let key in ViewKeyPathMap) {
        if (!viewMap[key]?.openBy) {
            addRoute(key, ViewKeyPathMap[key]);
        }
    }

    const app = createApp(defineAsyncComponent({
        loader: view_get_by_path(ViewKeyPathMap.app_layout),
    }));

    app.use(pinia).use(i18n).directive("loading", vLoading).use(Lazyload, {
        loading: app_data.info.lazy_img1x1,
        lazyComponent: true,
    });

    // 解析 URL 并存储邀请码
    const urlParams = new URLSearchParams(window.location.search);
    const inviteCode = urlParams.get("ic");
    if (inviteCode) {
        console.log("邀请码:", inviteCode);
        userStore().inviteCode = inviteCode;
    }
    appStore().app = app_data;
    setTimeout(() => {
        app.use(router)
        app.mount("#app");
    }, 200);
})).catch(console.error);


window.addEventListener('resize', () => {
    const isMobile = window.innerWidth <= 768;
    // 做动态处理
});

