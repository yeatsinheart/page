import {defineStore} from "pinia";
import {ApiRequest} from "@/api/index.js";

export const cashierStore = defineStore("cashierStore", {
    state: () => ({
        categories: [],
        paymentMethods: [],
        depositChannels: [],
    }),
    getters: {
        // 计算属性，类似于 computed

    },
    actions: {
        init(){
            Promise.all([
                ApiRequest._dU9ZjE5o(),
            ]).then(([res]) => {
                this.categories = res || [];
                this.paymentMethods = res || [];
                this.depositChannels = res || [];
            })
        }
    },
});
