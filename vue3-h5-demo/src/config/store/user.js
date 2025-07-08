import {defineStore} from "pinia";
import {ApiRequest} from "@/api";
import {appStore} from "@/config/store/app.js";
import {CurrencyUtil} from "@/tool/currency.js";
import {paymentAccountStore} from "@/config/store/paymentAccount.js";

export const userStore = defineStore("userStore", {
    state: () => ({
        inviteCode: null,
        account:null,
        token:null,
        loginConfig:null,
        loginType:null,
        vips:[],
        listen:{message:0,rechargeMaxBonus:0,},
    }),
    getters: {
        isLoggedIn(){return this.token},
        balanceStr(){
            let coin = appStore().app?.coin;
            return CurrencyUtil.roundToScale(this.account.balance, coin?.scale, coin?.denomination);},
    },
    actions: {
        how2Login(){
            ApiRequest._djTNv129().then(res => {
                this.loginConfig = res;
                if(!this.loginType){
                    this.loginType = res?.howToLogin?.activeForm?.[0];
                }
                if(res?.howToLogin?.activeForm.length===1){
                    this.loginType = res?.howToLogin?.activeForm?.[0];
                }
                if(!this.inviteCode){
                    this.inviteCode = res?.defaultInvite
                }
            })
        },
        login_success(res){
            this.token = res.token
            this.account = res.account
            this.account.balance=CurrencyUtil.roundToScale(res.account.balance,appStore().app.coin.scale,appStore().app.coin.denomination);
        },
        refreshBalance(){
            ApiRequest._B7vKm2x5().then(res=>{
                this.account.balance=CurrencyUtil.roundToScale(res,appStore().app.coin.scale,appStore().app.coin.denomination);
            })
        },
        refreshAccount(){
            paymentAccountStore().init()
            ApiRequest._DYN7TM69().then(res=>{
                this.account = res
                this.account.balance=CurrencyUtil.roundToScale(res.balance,appStore().app.coin.scale,appStore().app.coin.denomination);
            })
        },
        toLogin(){
            this.token = null;
            this.account = null;
            view_route_by_key(ViewKeyDict.auth, { action: 'login' })
        },
        toRegister(){
            this.token = null;
            this.account = null;
            view_route_by_key(ViewKeyDict.auth, { action: 'register' })
        },
        logout(){
            ApiRequest._logout().then(res=>{
                if(res){
                    this.token = null;
                    this.account = null;
                }
            })
        },

    },

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
