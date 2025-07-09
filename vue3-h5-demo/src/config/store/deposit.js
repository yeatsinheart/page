import {defineStore} from "pinia";
import _ from "lodash";
import {ApiRequest} from "@/api/index.js";
import {showToast} from "vant";

import i18n from '@/config/lang/18n.js';
import {paymentAccountStore} from "@/config/store/paymentAccount.js";
import {appStore} from "@/config/store/app.js";
import { CurrencyUtil} from "@/tool/currency.js"; // 确保 i18n 实例已在 main.ts 里创建

export const depositStore = defineStore("depositStore", {
    state: () => ({

        categories: [],

        category: {children: []},
        paymentMethod: {children: []},
        channel: {uiDepositNewOrder: ''},

        creating: false,
        amount_order: null,
        amount_coin: null,
    }),
    getters: {
        canCreateOrder() {
            return this.amount_order && CurrencyUtil.isStrictNumber(this.amount_order) &&
                (this.amount_order >= this.channel.min && this.amount_order <= this.channel.max);
        }
    },
    actions: {
        depositInit() {
            Promise.all([
                ApiRequest._dU9ZjE5o(),
            ]).then(([res]) => {
                this.categories = res;
                this.chooseCategory(res?.[0]);
            })
        },
        chooseCategory(category) {
            this.category = category||{children:[]};
            // 默认选中一个状态为 on的支付方式 跳过维护中的
            let default_payment_method = this.category.children.find(v=>"on"===v.status)||{children:[]}
            this.choosePaymentMethod(default_payment_method)
        },
        choosePaymentMethod(payment) {
            this.paymentMethod = payment||{children:[]}
            let default_channel = payment?.children?.[0]||{};
            this.chooseChannel(default_channel)
        },

        coinToCurrency(amount){
            return CurrencyUtil.coinToCurrency(amount,this.channel.exchangeRate,this.channel.scale,this.channel.denomination);
        },
        currencyToCoin(amount){
            return CurrencyUtil.currencyToCoin(amount,this.channel.exchangeRate,this.channel.denomination);
        },

        chooseChannel(channel) {
            depositStore().amount_order=null;
            // 默认设置chanel信息
            let data = {...channel}
           /* data.exchangeRate ??= 1.1;//??= 只在属性 null 或 undefined 时才赋值
            if (!_.has(data, "orderConfig.choices")) {
                _.set(data, "orderConfig.choices", "10,20,50,100,200,500,1000,2000,5000,10000,20000,50000");
            }
            if (!_.has(data, "orderConfig.min")) {
                _.set(data, "orderConfig.min", 1);
            }
            if (!_.has(data, "orderConfig.max")) {
                _.set(data, "orderConfig.max", 50000);
            }*/
            this.channel = data;
            // this.depositOrder.channelId = data.channelId;
            // this.depositOrder.exchangeRate = data.exchangeRate;
            // this.depositOrder.amountOrder = null;
        },

        createOrder() {
            let msg = i18n.global.t("支付方式") + `：${i18n.global.t(depositStore().paymentMethod.name)}`;
            let payAccount = paymentAccountStore().byId(paymentAccountStore().chosenId);
            if (payAccount) {
                msg += "\n" + i18n.global.t("支付账号") + `:` + "(" + payAccount.maskNumber + ")";
            } else if (depositStore().channel?.linkedRequired) {
                showToast(i18n.global.t("请选择支付账号"))
                return;
            }
            showDialog({
                title: i18n.global.t("订单确认"),
                message: msg,
                showCancelButton: true, // 只有确认按钮
                confirmButtonText: i18n.global.t('确认提交'), // 自定义确认按钮文字
                cancelButtonText: i18n.global.t('暂时不提交'), // 自定义确认按钮文字
            }).then(() => {
                depositStore().creating = true;
                if (this.amount_order) {
                    ApiRequest._gd82vM3R({channelId:this.channel.channelId,amountOrder:this.amount_order,linkedId:payAccount?.linkedId}).then((res) => {
                        if (res.success) {
                            // 跳转类型：TOAST/ROUTE/GET/POST-FORM/POST-JSON
                            if ("TOAST" === res.type) {
                                showToast({message: i18n.global.t(res.msg), duration: 1500});
                            } else if ("GET" === res.type) {
                                window.open(res.url, "_blank");
                            } else if ("POST-JSON" === res.type) {
                                fetch(res.url, {
                                    method: 'POST',
                                    headers: {'Content-Type': 'application/json',},
                                    body: res.params,
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        console.log('Form 请求成功:', data);
                                        // 在此处打开界面，或跳转到另一个页面
                                    })
                                    .catch(error => console.error('Form 请求失败:', error));
                            } else if ("POST-FORM" === res.type) {
                                fetch(res.url, {method: 'POST', body: res.params,})
                                    .then(response => response.json())
                                    .then(data => {
                                        console.log('Form 请求成功:', data);
                                        // 在此处打开界面，或跳转到另一个页面
                                    })
                                    .catch(error => console.error('Form 请求失败:', error));
                            }
                        } else {
                            showToast({message: res.message, duration: 1500});
                        }
                    }).catch((err) => {
                        console.log(err);
                        showToast({message: i18n.global.t("下单失败"), duration: 1500});
                    }).finally(() => {
                        this.creating = false;
                    })
                }
            }).catch((error) => {
                depositStore().creating = false;
                console.log(error);
            });
        },
        accountList() {
        }
    },
});
