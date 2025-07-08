import {defineStore} from "pinia";
import {ApiRequest} from "@/api";
import {gameStore} from "./game.js";
import {userStore} from "./user.js";

export const appStore = defineStore("appStore", {
    state: () => ({
        app: null,
        layoutItem: {
            bar_bottom: [
                {
                    titleI18nKey: "首页",
                    logoI18nKey: "https://x4.runtu123.com/0/global/1741121380209_icon_btm_sy.avif",
                    openViewKey: "home"
                },
                {
                    titleI18nKey: "活动",
                    logoI18nKey: "https://x1.runtu123.com/0/global/1741121380836_icon_btm_yh.avif",
                    openViewKey: "bonus"
                },
                {
                    titleI18nKey: "我的",
                    logoI18nKey: "https://x2.runtu123.com/0/global/1741121383066_icon_btm_wd.avif",
                    openViewKey: "me"
                },
            ]
        },
        showSideMenu: false,
        version: 1,
    }),
    actions: {
        // 异步 action 方法
        async fetchData() {
            try {
                await Promise.all([
                    ApiRequest._XuhIjT6s(),
                    ApiRequest.layoutItems(),
                ]).then(([app_res, layoutItems_res]) => {
                    this.layoutItem = layoutItems_res;
                    this.app = app_res;
                    let chosen_language = localStorage.getItem('Language');
                    let right_language = app_res.languageList.some(item => item.code === chosen_language);
                    if (!right_language) {
                        chosen_language = app_res.languageList[0].code;
                    }
                })
                //await changeLanguage(chosen_language);
                await gameStore().init();

            } catch (error) {
            }
        },

        // 初始化应用数据
        async init() {
            if (userStore().isLoggedIn) {
                userStore().refreshAccount()
            }
            if (import.meta.env.DEV) {
                await this.fetchData();
                return;
            }
            if (!this.app) {
                await this.fetchData();
            } else {
                setTimeout(() => {
                    this.fetchData()
                }, 300)
            }
        }
    },
    getters: {},
    // 配置持久化选项
    persist: {
        enabled: true,  // 开启持久化
        strategies: [
            {
                storage: localStorage,  // 存储方式，可以是 localStorage 或 sessionStorage
            },
        ],
    },
});
