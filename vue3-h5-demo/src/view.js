import { appStore } from "@/config/store/app.js";
import {userStore} from "@/config/store/user.js";

import router from "@/config/router";
import { openby } from "@/tool/pop.js";
/** 编译时生成文件映射 */
export const pathmap = import.meta.glob("@/view/**/*.vue");

/**
 * 只查找/src/view下的文件 对应view——key的dir
 * 可能是单文件.vue
 * 可能是符合文件夹/index.vue
 * path 是 / 开头
 * */

export const view_get_by_path = (path) => {
    return (
        pathmap["/src/view" + path + ".vue"] || //简单页面
        pathmap["/src/view" + path + "/index.vue"] || //复杂页面，多个子组件构成
        pathmap["/src/view" + path + "/demo.vue"] || //默认版本
        pathmap[path] ||
        pathmap["/src/view/app/nomore/demo.vue"] // nomore
        //|| pathmap["/src/view/ui/developing.vue"] // 最后选择：开发中
    );
};
export const ViewKeyPathMap = {
    app_layout: "/app/layout/test",
    download_tip: "/app/download_tip/demo",
    bottom_bar: "/app/bottom_bar/demo",
    home: "/app/home/demo",

    color: "/app/setting/color",
    language: "/app/setting/language",
    view: "/app/setting/view",

    auth: "/account/auth/demo",
    me: "/account/home/demo",
    avatar: "/account/avatar/demo",

    notfound: "/app/page/home/wg",
    swiper: "/market/swiper/demo",

    game_home: "/game/home/wg",

    bonus_history: "/bonus/bonus_history/demo",
    message: "/account/message/demo",
    game_history: "/game/history/demo",
    game_search: "/game/search/wg",

    marquee: "/market/marquee/demo",

    announcement: "/market/announcement/demo",
    account_config: "/account/config/demo",
    withdraw: "/cashier/withdraw/home/demo",

    invite: "/fixation/invite",
    loginPassword: "/fixation/loginPassword",
    mail: "/fixation/mail",
    fbettingHistory: "/fixation/bettingHistory",
    faddBankCard: "/fixation/addBankCard",
    fsubordinate: "/fixation/subordinate",
    finvitation: "/fixation/invitation",
    fteamReport: "/fixation/teamReport",
    fmycommission: "/fixation/mycommission",
    fteamPartner: "/fixation/teamPartner",
    fpromotionRule: "/fixation/promotionRule",
    fsettingCenter: "/fixation/settingCenter",
    frebate: "/fixation/rebate",
    fnotify: "/fixation/notify",
    fgiftExchange: "/fixation/giftExchange",
    fgameStatistics: "/fixation/gameStatistics",
    retBalance: "/fixation/retBalance",
    accountDetails: "/fixation/accountDetails",
    betRecords: "/fixation/betRecords",
    reports: "/fixation/reports",
    promotion: "/fixation/promotion",
    device: "/fixation/device",
    safety: "/fixation/safety",
    about: "/fixation/about",
    customer: "/problem/customer/demo",
    gdbrand_all: "/ui/gamble_detail/brand_all",
    brand_left_bar: "/ui/gamble_detail/brand_left_bar",
    forbidden: "/problem/forbidden/demo",
    maintain: "/problem/maintain/demo",
    recharge_history: "/wallet/recharge_history/demo",
    nomore: "/app/nomore/demo",
};

export const ViewKeyDict = Object.freeze({
    auth: "auth",
    home: "home",
});

export function is_pop_view(view_key,params){
    let userState = userStore();

    let appState = appStore();
    let viewMap = appState.app?.view;
    if (viewMap && viewMap[view_key]) {
        const view_info = viewMap[view_key];
        let isLogged = userState.isLoggedIn;
        /** 已登录情况 无需再访问注册登录页*/
        if (isLogged && [ViewKeyDict.auth].includes(view_key)) {
            return true;
        }
        /** 未登录且页面需要登录 */
        if (!isLogged && true === view_info.loggedIn) {
            userStore().toLogin()
            return true;
        }
        /** 弹出逻辑 */
        if (view_info.openBy) {
            openby(view.openBy, view.dir, params);
            return true;
        }
    }
    return false;
}
/** 防止浏览器直接打开路由，所以只能通过方法，弹出页面的路由就无法访问 */
export function open_by_key(view_key, params) {
    let b = is_pop_view(view_key,params);
    if(!b){
        /**最终走路由*/
        // params 只有在 name 跳转时才生效。
        // 路由传参数，必须暴露在URL中，导致如果传递富文本，可能会出问题。
        router.push({ name: view_key, query: params});
    }
}


