import {defineStore} from "pinia";
import {ApiRequest} from "@/api";
import {changeLanguage} from "../lang/18n";
import {gameStore} from "./game.js";
import {userStore} from "./user.js";

export const appStore = defineStore("appStore", {
    //{"app":{"appId":0,"info":{"name":"demo","appName":"demo","description":"欢迎观临👏👏👏👏",
    // "favicon":"https://x3.runtu123.com/0/global/1741119471980_h5icon.ico","logo330x100":"https://x4.runtu123.com/0/global/1741119525132_1743167310040870913.avif","logo512x512":"https://x5.runtu123.com/0/global/1741119545010_appIconBig.png","logo70x70":"https://x5.runtu123.com/0/global/1741119545010_appIconBig.png","maintain1x1":"https://x3.runtu123.com/0/global/1743187708356_9a339e38-1dc7-449a-bb7c-f68677ae6e3f_img_whz_style_1.avif","launch_img":["https://x3.runtu123.com/0/global/1742013538617_ae511a1c-db84-47b0-b505-058be7b709d3_226044dba4eae61fe5907d8890c039e0.jpg"],"download_img7x1":"https://x2.runtu123.com/0/global/1741119447521_1831992421251534850.webp","download_txt":"下载APP,领取更多奖励","register_img":"https://x4.runtu123.com/0/global/1741901893062_2344d446-01ff-4ffa-bba4-bc16e75038a8_test.jpeg","home_bg":"https://x5.runtu123.com/0/global/1741119494279_bg_pattern_tile.avif","launch_time":5,"lazy_img3x4":"https://x5.runtu123.com/0/global/1743188177563_868e516e-ca63-4f82-a378-ed56d26e537c_bg_pattern_tile.avif","lazy_img1x1":"https://x5.runtu123.com/0/global/1743188177563_868e516e-ca63-4f82-a378-ed56d26e537c_bg_pattern_tile.avif","lazy_img7x2":"https://x5.runtu123.com/0/global/1743188177563_868e516e-ca63-4f82-a378-ed56d26e537c_bg_pattern_tile.avif"},"view":{"account":{"dir":"/account/home/wg","loggedIn":false,"openBy":""},"account_config":{"dir":"/account/config/demo","loggedIn":false,"openBy":""},"add_to_desk":{"dir":"/app/add_to_desk/demo","loggedIn":false,"openBy":""},"announce":{"dir":"/market/announce/home/demo","loggedIn":false,"openBy":""},"announce_pop":{"dir":"/market/announce/pop/demo","loggedIn":false,"openBy":""},"auth":{"dir":"/account/auth/wg","loggedIn":false,"openBy":"/ui/popup/close_bottom"},"avatar":{"dir":"/account/avatar/demo","loggedIn":false,"openBy":""},"bonus":{"dir":"/bonus/home/demo","loggedIn":false,"openBy":null},"bonus_detail":{"dir":"/bonus/detail/demo","loggedIn":false,"openBy":"\u0000"},"bonus_history":{"dir":"/bonus/history/demo","loggedIn":false,"openBy":""},"bonus_pop":{"dir":"/bonus/pop/demo","loggedIn":false,"openBy":""},"bottom_bar":{"dir":"/app/bottom_bar/wg","loggedIn":false,"openBy":""},"color":{"dir":"/app/color","loggedIn":false,"openBy":"/ui/popup/close_bottom"},"customer":{"dir":"/problem/customer/demo","loggedIn":false,"openBy":"/ui/popup/close_right_top"},"deposit":{"dir":"/cashier/deposit/home/demo","loggedIn":false,"openBy":"/ui/popup/close_right_top"},"deposit-to-pay":{"dir":"/cashier/deposit/topay","loggedIn":false,"openBy":""},"deposit_history":{"dir":"/cashier/deposit/history/demo","loggedIn":false,"openBy":""},"download":{"dir":"/app/download/demo","loggedIn":false,"openBy":"/ui/popup/close_bottom"},"feedback":{"dir":"/problem/feedback/wg","loggedIn":false,"openBy":"/ui/popup/close_bottom"},"forbidden":{"dir":"/problem/forbidden/demo","loggedIn":false,"openBy":""},"game-login":{"dir":"/game/login/demo","loggedIn":false,"openBy":""},"game_brand_detail":{"dir":"/game/brand_detail/category_left_bar","loggedIn":false,"openBy":""},"game_category_detail":{"dir":"/game/category_detail/brand_left_bar","loggedIn":false,"openBy":""},"game_history":{"dir":"/game/history/wg","loggedIn":false,"openBy":""},"game_home":{"dir":"/game/home/wg","loggedIn":false,"openBy":""},"game_search":{"dir":"/game/search/wg","loggedIn":false,"openBy":""},"home":{"dir":"/app/home/wg","loggedIn":false,"openBy":""},"kyc":{"dir":"/account/kyc/demo","loggedIn":false,"openBy":""},"language":{"dir":"/app/language","loggedIn":false,"openBy":"/ui/popup/close_bottom"},"maintain":{"dir":"/problem/maintain/demo","loggedIn":false,"openBy":""},"marquee":{"dir":"/market/marquee/demo","loggedIn":false,"openBy":""},"member_new":{"dir":"/team/member_new/demo","loggedIn":false,"openBy":null},"member_summary":{"dir":"/team/member_summary/demo","loggedIn":false,"openBy":null},"message":{"dir":"/account/message/demo","loggedIn":false,"openBy":"/ui/popup/close_bottom"},"nomore":{"dir":"/app/nomore/demo","loggedIn":false,"openBy":""},"payment_
    state: () => ({
        app: null,
        layoutItem:{
            bar_bottom:[
                {titleI18nKey:"首页",logoI18nKey:"https://x4.runtu123.com/0/global/1741121380209_icon_btm_sy.avif",openViewKey:"home"},
                {titleI18nKey:"活动",logoI18nKey:"https://x1.runtu123.com/0/global/1741121380836_icon_btm_yh.avif",openViewKey:"bonus"},
                {titleI18nKey:"我的",logoI18nKey:"https://x2.runtu123.com/0/global/1741121383066_icon_btm_wd.avif",openViewKey:"me"},
            ]
        },
        showSideMenu: false,
        version: 1,
    }),
    actions: {
        // 异步 action 方法
        async fetchData() {
            try {
                let response = await ApiRequest._XuhIjT6s();
                this.app = response;
                let chosen_language = localStorage.getItem('Language');
                let right_language = response.languageList.some(item => item.code===chosen_language);
                if(!right_language){
                    chosen_language=response.languageList[0].code;
                }
                await gameStore().init();
                await changeLanguage(chosen_language);
            } catch (error) {
            }
        },

        // 初始化应用数据
        async init() {
            if(userStore().isLoggedIn){
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
