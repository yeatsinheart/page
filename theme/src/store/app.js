import {defineStore} from "pinia";

export const appStore = defineStore("appStore", {
    state: () => ({
        /*底色方案*/
        container: {
            font:{title:'#323233',sub_title:'#646566',normal:'#737272',placeholder:'#969799',disabled:'#BBBBBB'},
            browser:'#9195a3', page:'#f7f8ff', border:'#e3e3e31a',shadow:'#41454940',mask:'#0000001f',
            gap:{bg:'#d7dae0ff',font:'#adb6c4'},
            notify:{bg:'#d7dae0ff',font:'#adb6c4'},
            reverse:{bg:'#0e131b',font:'#adb6c4'},
            card:{bg:'#ffffff',border:'rgba(227, 227, 227, .1)',shadow:'#41454940'},
            div1:{bg:'#f6f6f6'},
            div2:{bg:'#E4E4E4'},
            bar:{bg:'#ffffff',font:'#768096'},
            bar_top:{bg:'#ffffff',font:'#768096'},
            bar_bottom:{bg:'#ffffff',font:'#768096'},
            grid:{shadow:'#41454940'},
            input:{shadow:'#41454940'},
        },
        /*主色方案*/
        colors:{
            theme: {color:'red',font:'#fff'},
            color1:{color:'#4169e1',font:'#ffffff'},
            color2:{color:'#00fe00',font:'#ffffff'},
            color3:{color:'#ffde53',font:'#ffffff'},
            danger:{color:'#D23838',font:'#ffffff'},
        }

    }),
    actions: {
        // 异步方法
        async init() {

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
