import {createApp} from 'vue'
import {loadViewVersion, view_get_by_path, ViewKeyPathMap} from "@/view.js";
import i18n from "@/config/lang/18n";
import router, {addRoute} from "@/config/router";
import {Lazyload} from "vant";
import {createPinia} from "pinia";

import piniaPluginPersistedstate from "pinia-plugin-persistedstate"; //引入持久化插件
import vLoading from "@/tool/v-loading.js";

//创建pinia实例
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);


const init = async () => {
    await loadViewVersion("demo")
}

init().then(() => {
    // 默认首页
    addRoute("", ViewKeyPathMap.home);
    const app = createApp(defineAsyncComponent(view_get_by_path(ViewKeyPathMap.app_layout)))
        .directive("loading", vLoading)
        .use(i18n).use(router)
        .use(pinia)
    ;

    app.use(Lazyload, {
        loading: "imgI18nKey",
        lazyComponent: true,
    });
    setTimeout(() => {
        app.mount("#app");
    }, 200);
}).catch(console.error);

window.addEventListener('resize', () => {
    const isMobile = window.innerWidth <= 768;
    // 做动态处理
});

