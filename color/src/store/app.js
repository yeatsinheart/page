import {defineStore} from "pinia";

export const appStore = defineStore("appStore", {
    state: () => ({
        /*底色方案*/
        container: {
            font:{title:'#323233',sub_title:'#646566',normal:'#737272',placeholder:'#969799',disabled:'#BBBBBB'},
            browser:'#9195a3', page:'#f7f8ff', border:'#e3e3e31a',shadow:'#41454940',mask:'#0000001f',
            gap:{bg:'#d7dae0ff',font:'#adb6c4'},
            notify:{bg:'#d7dae0ff',font:'#adb6c4'},
            recommend:{bg:'#d7dae0ff',font:'#adb6c4'},
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
        /*配色*/
        colors:{
            theme: {color:'red',font:'#fff'},

            color1:{color:'#4169e1',font:'#ffffff'},
            color2:{color:'#00fe00',font:'#ffffff'},
            color3:{color:'#ffde53',font:'#ffffff'},
            color4:{color:'#571cb6',font:'#ffffff'},
            color5:{color:'#a60000',font:'#ffffff'},
            color6:{color:'#a60000',font:'#ffffff'},
            color7:{color:'#a60000',font:'#ffffff'},

            danger:{color:'#D23838',font:'#ffffff'},
            草绿:{color:'#0D8D42',font:'#ffffff'},//草绿
            blue:{color:'#005DFE',font:'#ffffff'},
            皇家蓝:{color:'rgb(28, 87, 203)',font:'#ffffff'},//皇家蓝
            高贵蓝:{color:'rgb(20, 34, 60)',font:'#ffffff'},//高贵蓝
            金麒麟:{color:'rgb(191, 131, 1)',font:'#ffffff'},//金麒麟
            紫罗兰:{color:'rgb(136, 18, 190)',font:'#ffffff'},//紫罗兰
            pink:{color:'#f95959',font:'#ffffff'},
            珊瑚:{color:'rgb(238, 79, 23)',font:'#ffffff'},//珊瑚
            红橙:{color:'rgb(200, 52, 6)',font:'#ffffff'},//红橙
            酒红:{color:'rgb(222, 47, 4)',font:'#ffffff'},//酒红
            罂粟红:{color:'rgb(184, 1, 1)',font:'#ffffff'},//罂粟红
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
