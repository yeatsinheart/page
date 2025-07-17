import {defineStore} from "pinia";

export const menuTabStore = defineStore("menuTabStore", {
    state: () => ({
        show_menu: true,
        show_setting_menu: false,
        iframe_times: 10,
        tabs: [],
        select_index: 0,
        tab_dropdown: false,
    }),

    actions: {
        open(title, url) {
            //iframe中 更新时 通知顶层 self=top说明就是最外层
            if (window.top !== window.self) {
                // 通过window事件来传递新窗口
                new_tab(title,url);
                return;
            }
            this.iframe_times = this.iframe_times + 1;
            this.tabs.push({'id': this.iframe_times, 'title': title, "url": url});
            this.activeTab(this.tabs.length - 1);
        },

        activeTab(index) {
            this.select_index = index;
            this.right_place();
        },

        isActive(index) {
            return index === this.select_index;
        },

        // 关闭其他
        onlyKeepThis(index) {
            this.tab_dropdown = !this.tab_dropdown;
            if (index !== 0) {
                this.tabs.splice(0, index);
            }
            if (this.tabs.length > 1) {
                this.tabs.splice(1);
            }
            this.activeTab(0)
        },

        closeTabs(index, direction) {
            // 关闭所有 或者 关闭指定
            if (direction) {
                if (1 === direction) {
                    this.tabs.splice(index + 1);
                    this.activeTab(index);
                }
                if (-1 === direction) {
                    this.tabs.splice(0, index);
                    this.activeTab(0);
                }
                return;
            }
            let nowActiveIndex = this.select_index;
            //关闭所有 总保留一个？
            if (index === -1) {
                this.tab_dropdown = !this.tab_dropdown;
                this.tabs.splice(0);
                this.activeTab(0)
                return;
            }

            //关闭指定的位置
            // 操作后会导致所有的tags重新刷一遍
            // 剩下的tab
            this.tabs.splice(index, 1);
            let total = this.tabs.length;
            if (total === 0) {
                this.activeTab(0)
                return;
            }
            // 非当前激活tab 因为少了一位，所以要往前移动咯
            if (!this.isActive(index) && index < nowActiveIndex) {
                this.activeTab(this.select_index - 1)
                return;
            }
            if (index >= total) {
                //this.activeTab(index)
                this.activeTab(total - 1)
            }
        },
        right_place() {
            // 居中
            let that = this;
            setTimeout(function () {
                if (!that.tabs[that.select_index]) return;
                let click = document.querySelector('#tab_' + that.tabs[that.select_index].id);
                let div = document.querySelector('#tab_scroller');
                let click_scroll = click.getBoundingClientRect().x + div.scrollLeft - div.getBoundingClientRect().x;
                let can_see_width = div.getBoundingClientRect().width;
                let max_x = Math.round(div.scrollWidth - can_see_width);
                if (click_scroll - div.scrollLeft > 1) {
                    //console.log("在右边",click_scroll-div.scrollLeft,Math.abs(click_scroll-div.scrollWidth),"最远",can_see_width)
                    // 往左移动
                    let add = div.scrollLeft + (click_scroll - div.scrollLeft - can_see_width / 2 - 100);
                    if (add > max_x) {
                        add = max_x;
                    }
                    div.scrollTo(add, div.getBoundingClientRect().y);
                } else {
                    let add = div.scrollLeft - (div.scrollLeft - click_scroll) - can_see_width / 2 - 100;
                    if (add < 0) {
                        add = 0;
                    }
                    div.scrollTo(add, div.getBoundingClientRect().y);
                }
            }, 30);
        },
        reload(index) {
            let el = document.querySelector('#' + 'iframe_' + this.tabs[index].id)
            let tmpUrl = el.src;
            el.src = "about:blank";
            setTimeout(function () {
                el.src = tmpUrl;
            }, 30);
        }

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


export const scroll_tab = (distance) => {
    let div = document.querySelector('#tab_scroller');
    let can_see_width = div.getBoundingClientRect().width;
    let raw = div.scrollLeft + distance;
    let max = div.scrollWidth - can_see_width;
    let x = raw < 0 ? 0 : raw > max ? max : raw;
    div.scrollTo(x, 0)
}

const handleMessage = (event) => {
    if (window.top === window.self) {
        if (event.data.type && event.data.type === "OPENTAB") {
            menuTabStore().open(event.data.title, event.data.url);
        }
    }
}

export const new_tab=(name,url)=>{
    if (window.top !== window.self) {
        // IFRAME 通过window事件来传递新窗口
        window.top.postMessage({"type": "OPENTAB", "title": name, "url": url}, '*')
        return;
    }
    // 首页直接打开
    if (window.top === window.self) {
       menuTabStore().open(name, url);
    }
}
if (window.top === window.self) {
    window.addEventListener('message', handleMessage)
}
