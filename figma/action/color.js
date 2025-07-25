import {defineStore} from "pinia";

export const colorStore = defineStore("colorStore", {
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



/*
* 目标支持格式：
#000（简写 3 位，表示 #000000）
#000000（6 位 RGB）
#000000FF（8 位 RGBA，忽略透明度或将其保留）
* */
function normalizeHex(hex) {
    hex = hex.trim().replace(/^#/, '');
    if (hex.length === 3) {
        // #abc => #aabbcc
        hex = hex.split('').map(x => x + x).join('');
    } else if (hex.length === 8) {
        // 忽略 alpha 通道（后两位）
        hex = hex.substring(0, 6);
    } else if (hex.length !== 6) {
        throw new Error('不支持的颜色格式: ' + hex);
    }

    return '#' + hex;
}

export function isWhite(hex) {
    hex = normalizeHex(hex).slice(1);
    const r = parseInt(hex.substr(0, 2), 16);
    const g = parseInt(hex.substr(2, 2), 16);
    const b = parseInt(hex.substr(4, 2), 16);
    // YIQ 亮度公式
    const yiq = (r * 299 + g * 587 + b * 114) / 1000;
    return yiq >= 128 ; // 浅背景用黑字，深背景用白字
}
export function fontColor(hex) {
    return isWhite(hex) ? '#000000' : '#ffffff'; // 浅背景用黑字，深背景用白字
}

function hexToRgb(hex) {
    hex = normalizeHex(hex);
    const bigint = parseInt(hex.slice(1), 16);
    return [ (bigint >> 16) & 255, (bigint >> 8) & 255, bigint & 255 ];
}

function rgbToHex([r, g, b]) {
    return '#' + [r, g, b].map(x => x.toString(16).padStart(2, '0')).join('');
}
export function invertColor(hex) {
    hex = normalizeHex(hex).slice(1);
    // 取反每个颜色通道
    const r = (255 - parseInt(hex.slice(0, 2), 16)).toString(16).padStart(2, '0')
    const g = (255 - parseInt(hex.slice(2, 4), 16)).toString(16).padStart(2, '0')
    const b = (255 - parseInt(hex.slice(4, 6), 16)).toString(16).padStart(2, '0')
    return `#${r}${g}${b}`
}
function mixColors(c1, c2, ratio = 0.5) {
    const rgb1 = hexToRgb(c1)
    const rgb2 = hexToRgb(c2)
    const r = Math.round(rgb1.r * (1 - ratio) + rgb2.r * ratio)
    const g = Math.round(rgb1.g * (1 - ratio) + rgb2.g * ratio)
    const b = Math.round(rgb1.b * (1 - ratio) + rgb2.b * ratio)
    return rgbToHex(r, g, b)
}
export function blendColors(start, end, steps) {
    const [r1, g1, b1] = hexToRgb(start);
    const [r2, g2, b2] = hexToRgb(end);
    const result = [];
    for (let i = 0; i < steps; i++) {
        const ratio = i / (steps - 1);
        const r = Math.round(r1 + (r2 - r1) * ratio);
        const g = Math.round(g1 + (g2 - g1) * ratio);
        const b = Math.round(b1 + (b2 - b1) * ratio);
        result.push(rgbToHex([r, g, b]));
    }
    return result;
}

//调整亮度（变浅/变深）
function adjustBrightness(hex, amount) {
    const { r, g, b } = hexToRgb(hex)
    const clamp = val => Math.max(0, Math.min(255, val))
    return rgbToHex(
        clamp(r + amount),
        clamp(g + amount),
        clamp(b + amount)
    )
}
// 示例：
//console.log(blendColors('#000000', '#ffffff', 50));
