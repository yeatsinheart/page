import {defineStore} from "pinia";
import {ApiRequest} from "@/api/index.js";
import {openby} from "@/tool/pop.js";

export const paymentAccountStore = defineStore("paymentAccountStore", {
    state: () => ({
        accounts: [],// 已绑定账号
        methods: [],
        chosenId: null,
    }),
    getters: {
        // 计算属性，类似于 computed
        accountsOfMethod: (state) => (paymentMethodKey) => {
            return state.accounts.filter(v => v.paymentMethodKey === paymentMethodKey);
        },
        byId: (state) => (id) => {
            return state.accounts.find(v => v.linkedId === id);
        },
    },
    actions: {
        init() {
            Promise.all([
                ApiRequest._N5D6YWT9(),
                ApiRequest._rQ8ZT6Wy(),
            ]).then(([res1, res2]) => {
                this.accounts = res1 || [];
                this.methods = res2 || [];
            })
        },
        toAdd() {
            open_by_key('payment_account')
        },
        can_add(payment){
            return (this.accountsOfMethod(payment.paymentMethodKey)?.length ?? 0 )< payment.linkedAccountMax
        },
        toAddAccountPage(payment) {
            openby('/ui/popup/close_bottom', payment.uiAddAccount, payment)
        },

    },
});
