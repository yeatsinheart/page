// 彩票玩法
import {defineStore} from "pinia";
import {ApiRequest} from "@/api";

import i18n from "@/config/lang/18n.js";

export const gameStore = defineStore("gameStore", {
    state: () => ({
        category: [],
        game_hot: [],
        game_of_category: [],
        game_of_category_and_brand: [],
        game_of_brand: [],
        brands: [],
        games: [],
        gamesNotTranslated: [],
        login_game_res: {},
        games_search: [],
    }),
    actions: {
        translate(){
            this.games = this.gamesNotTranslated.map(g => ({
                ...g,
                name: i18n.global.t(g.name)// 先翻译游戏名称
            }));
        },
        login(gameKey) {
            this.login_game_res = {};
            ApiRequest._5gIU0LQv({gameKey: gameKey}).then(res => {
                //router.push({ path: "/game-login" , params: res });
                if (res) {
                    this.login_game_res = res;
                    view_route_by_key('game-login')
                }

            })
        },
        search(words) {
            // 搜索翻译后的数据，
            if (words) {
                const cleanedWords = words.trim().toLowerCase().replace(/\s+/g, '');
                // 确保搜索词非空
                if (!cleanedWords) return;
                let result = this.games.filter(g => g.name.toLowerCase().replace(/\s+/g, '').includes(cleanedWords))
                this.games_search=result;
            }
        },
        // 异步 action 方法
        all_category_of_brand(brandKey) {
            let games = this.byBrand(brandKey)
            let category_keys = games.map(item => item.categoryKey)
            return this.category.filter(item => category_keys.includes(item.categoryKey));
        },
        byBrand(brandKey) {
            return this.games.filter(g => g.brandKey === brandKey).sort((a, b) => {
                if (b.weightBrand !== a.weightBrand) {
                    return b.weightBrand - a.weightBrand; // 先按 value 降序
                }
                return a.name.localeCompare(b.name); // value 相同，再按 name 升序
            })
        },
        byCategory(categoryKey) {
            return this.games.filter(g => g.categoryKey === categoryKey).sort((a, b) => {
                if (b.weightCategory !== a.weightCategory) {
                    return b.weightCategory - a.weightCategory; // 先按 value 降序
                }
                return a.name.localeCompare(b.name); // value 相同，再按 name 升序
            })
        },
        byCategoryAndBrand(categoryKey, brandKey) {
            return this.games.filter(g => g.categoryKey === categoryKey && g.brandKey === brandKey).sort((a, b) => {
                if (b.weightBrandCategory !== a.weightBrandCategory) {
                    return b.weightBrandCategory - a.weightBrandCategory; // 先按 value 降序
                }
                return a.name.localeCompare(b.name); // value 相同，再按 name 升序
            })
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
