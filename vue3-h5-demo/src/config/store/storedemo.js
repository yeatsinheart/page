// 彩票玩法
import {defineStore} from "pinia";
import {ApiRequest} from "@/api";

import i18n from "@/config/lang/18n.js";

export const demoStore = defineStore("demoStore", {
    state: () => ({
        category: [],

    }),
    actions: {
        // 异步 action 方法
        all_category_of_brand(brandKey) {
            let games = this.byBrand(brandKey)
            let category_keys = games.map(item => item.categoryKey)
            return this.category.filter(item => category_keys.includes(item.categoryKey));
        },

        async fetchData() {
            await Promise.all([
                    ApiRequest._8uDDbr15(),//  大类+品牌
                    ApiRequest._DzvQ6e7M(),//  所有品牌
                    ApiRequest._WX35wiOt(),// 所有游戏
                ]
            )
                .then(([category, brands, allgame]) => {
                    this.category = category;
                    this.brands = brands;
                    // 先翻译游戏名称，方便搜索时直接搜索到
                    this.gamesNotTranslated = allgame;
                    this.games = allgame.map(g => ({
                        ...g,
                        name: i18n.global.t(g.name)// 先翻译游戏名称
                    }));
                    this.game_hot = this.games.filter(g => g.hot).sort((a, b) => {
                        if (b.weightHot !== a.weightHot) {
                            return b.weightHot - a.weightHot; // 先按 value 降序
                        }
                        return a.name.localeCompare(b.name); // value 相同，再按 name 升序
                    });
                })
        },
        // 初始化应用数据
        async init() {
            if (!this.category) {
                await this.fetchData();
            } else {
                setTimeout(() => {
                    this.fetchData()
                }, 300)
            }
        },
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
