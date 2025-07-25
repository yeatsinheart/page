import {defineStore} from "pinia";

export const colorModeStore = defineStore("colorModeStore", {
    state: () => ({
        dark: false,
    }),
    actions: {
        mode_change() {
            this.dark=!this.dark
            localStorage.setItem('dark-mode',this.dark)
            document.querySelectorAll("iframe").forEach(iframe => {
                iframe.contentWindow.postMessage({"type": "COLOR-MODE-CHANGE"}, "*");
            });
            this.now_mode();
        },
        now_mode() {
            /*颜色模式选择*/
            if(localStorage.getItem('dark-mode')==='true'){
                this.dark=true;
                document.getElementById('color-version').setAttribute('href', '/css/color-dark.css')
                document.documentElement.classList.add('dark'); // 开启夜间模式
            }else {
                this.dark=false;
                document.getElementById('color-version').setAttribute('href', '/css/color.css')
                document.documentElement.classList.remove('dark'); // 关闭夜间模式
            }
        },
    },
    getters: {},
    // 配置持久化选项
    /*persist: {
        enabled: true,  // 开启持久化
        strategies: [
            {
                storage: sessionStorage,//localStorage,  // 存储方式，可以是 localStorage 或 sessionStorage
            },
        ],
    },*/
});

const handleColorChange = (event) => {
    if (event.data.type && event.data.type === "COLOR-MODE-CHANGE") {
        colorModeStore().now_mode();
    }
}
window.addEventListener('message', handleColorChange)

