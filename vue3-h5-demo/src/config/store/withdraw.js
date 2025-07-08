import {defineStore} from "pinia";
import {ApiRequest} from "@/api/index.js";
import {showToast} from "vant";
import i18n from "@/lang/18n.js";
import {paymentAccountStore} from "@/store/paymentAccount.js";
import {CurrencyUtil} from "@/tool/currency.js";
import {userStore} from "@/config/store/user.js";

export const withdrawStore = defineStore("withdrawStore", {
    state: () => ({

        limit:{},// 提现约束信息

        methods: [],
        paymentMethod:  {},
        canWithdrawAmount:  0,

        creating: false,

        amount_order: null,
        amount_coin: null,

    }),
    getters: {
        canCreateOrder() {
            return this.amount_order && CurrencyUtil.isStrictNumber(this.amount_order) &&
                (this.amount_order >= this.paymentMethod.withdrawMin && this.amount_order <= this.paymentMethod.withdrawMax);
        }
    },
    actions: {
        refreshLimit(){
            Promise.all([
                ApiRequest._ZCYJhIUT(),// 提现约束 余额，可提，手续费
            ]).then(([limit_res]) => {
                this.limit = limit_res;
                if(limit_res.balance){
                    userStore().account.balance = limit_res.balance;
                }
            })
        },
        withdrawInit() {
            this.refreshLimit()
            Promise.all([
                ApiRequest._dY8WrE6x(),//所有提现支付方式
            ]).then(([res]) => {
                this.methods = res || [];
                this.paymentMethod = this.methods.find(v => "on" === v.status) || {}
            })
        },

        coinToCurrency(amount){
            return CurrencyUtil.coinToCurrency(amount,this.paymentMethod.exchangeRate,this.paymentMethod.scale,this.paymentMethod.denomination);
        },
        currencyToCoin(amount){
            return CurrencyUtil.currencyToCoin(amount,this.paymentMethod.exchangeRate,this.paymentMethod.denomination);
        },
        createOrder() {
            let msg = i18n.global.t("收款方式") +  `：${i18n.global.t(this.paymentMethod.name)}`;
            let withdrawAccount = paymentAccountStore().byId(paymentAccountStore().chosenId);
            if (withdrawAccount) {
                msg += "\n" + i18n.global.t("收款账号") + `:` + "(" + withdrawAccount.maskNumber + ")";
            }
            showDialog({
                title: i18n.global.t("订单确认"),
                message: msg,
                showCancelButton: true, // 只有确认按钮
                confirmButtonText: i18n.global.t("确认提现"), // 自定义确认按钮文字
                cancelButtonText: i18n.global.t("再想想"), // 自定义确认按钮文字
            }).then(() => {
                withdrawStore().creating = true;
                if (this.amount_order) {
                    ApiRequest._ebE6GldI({paymentMethodKey:this.paymentMethod.paymentMethodKey,amountOrder:this.amount_order,linkedId:withdrawAccount?.linkedId}).then((res) => {
                        if (res.success) {
                            showToast(i18n.global.t("提交成功，等待处理"))
                        }
                    }).catch((err) => {
                        console.log(err);
                    }).finally(() => {
                        this.creating = false;
                    })
                }
            }).catch((err) => {
                console.log(err);
            });
        },
    },
});
