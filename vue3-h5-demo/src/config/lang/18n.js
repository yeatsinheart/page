import {createI18n} from 'vue-i18n'
import {ApiRequest} from '@/api'
import { websocket_api} from "@/tool/websocket.js";

// 本地没有语言包
const missed_keys ={};
setInterval(()=>{
    if(Object.keys(missed_keys).length > 0){
        let data = {};
        Object.keys(missed_keys).forEach((locale)=>{
            data[locale]=[]
            Object.keys(missed_keys[locale]).forEach((word_key)=>{
                data[locale].push(word_key);
            })
        })
        websocket_api("i18nMiss",{miss:data})
    }
},30*1000);
//mitt.on("ws:topic:api:action:i18nMiss",(call)=>{console.log(call);});
const i18n = createI18n({
    legacy: false,
    locale: localStorage.getItem('Language') || "zh_CN",
    messages: {"zh_CN":{"首页":"home"},"en_US":{"首页":"home"}},
    globalInjection: true, // 如果设置true, $t() 函数将注册到全局
    silentTranslationWarn: true,
    fallbackLocale: false, // 禁用回退，直接用key
/*
    missingWarn: false, // 🚀 关闭缺失翻译的警告
    fallbackWarn: false, // 🚀 关闭回退语言的警告
    */
    missing: async (locale, key, vm, values) => {
        if(missed_keys[locale]?.[key])return ;// 防止一直调用
        (missed_keys[locale] ??= {})[key] ??= "x";
        /*try {
            let old = i18n.global.getLocaleMessage(locale);
            if (old[key]) {
                return old[key];
            }
            const response = await ApiRequest._R097w25d({key: key})
            i18n.global.setLocaleMessage(locale, {
                ...i18n.global.getLocaleMessage(locale),
                [key]: response[key] || key
            });
            return response[key];
        } catch (error) {
            return key;
        }*/
        return key;
    }
})
export const changeLanguage = async (lang) => {
    // 模拟从 API 获取语言包
// 确保 i18n 正确初始化
    if (!i18n || !i18n.global) {
        console.error("i18n 未初始化");
        return;
    }
    // 记住选择
    localStorage.setItem("Language", lang);
    let response = await ApiRequest._R097w25d();
    // 更新 i18n 语言包
    i18n.global.setLocaleMessage(lang, response);
    // 切换语言
    i18n.global.locale.value = lang;
    gameStore().translate();
    //console.log(`语言切换至: ${lang}`, i18n.global.getLocaleMessage(lang));
};
export default i18n
