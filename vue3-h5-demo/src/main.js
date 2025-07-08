import {createApp} from 'vue'
import {loadViewVersion, view_get_by_path, ViewKeyPathMap} from "@/view.js";
import i18n from "@/config/lang/18n";
import router, {addRoute} from "@/config/router";
import {Lazyload} from "vant";
import {createPinia} from "pinia";

import piniaPluginPersistedstate from "pinia-plugin-persistedstate"; //引入持久化插件
import vLoading from "@/tool/v-loading.js";
import {userStore} from "@/config/store/user.js";
import {ApiRequest} from "@/api/index.js";

//创建pinia实例
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);


const init = async () => {
    ApiRequest._XuhIjT6s()
    //await loadViewVersion("demo")
    let view_version_file_data = await import(`@/setting/view-version/demo.json`);
    for (let view_key in view_version_file_data.default) {
        ViewKeyPathMap[view_key] = view_version_file_data[view_key].path;
    }
    // 默认首页
    addRoute("", ViewKeyPathMap.home);

    // ViewPathDict 写入路由中，弹出的界面不写入
    for (let key in ViewKeyPathMap) {
        if (!view_version_file_data.default[key]?.openBy) {
            addRoute(key, ViewKeyPathMap[key]);
        }
    }

}

init().then(() => {
    const app = createApp(defineAsyncComponent(view_get_by_path(ViewKeyPathMap.app_layout)))
        .directive("loading", vLoading)
        .use(i18n).use(router)
        .use(pinia)
    ;

    app.use(Lazyload, {
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



    setTimeout(() => {
        app.mount("#app");
    }, 200);
}).catch(console.error);

window.addEventListener('resize', () => {
    const isMobile = window.innerWidth <= 768;
    // 做动态处理
});

