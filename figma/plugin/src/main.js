import { createApp } from 'vue'

import {routerInit} from "@/init/router.js";
import {piniaInit} from "@/init/pinia.js";
import {elementPlusInit} from "@/init/element-plus.js";
import i18n from "@/init/i18n.js";

console.log("加载main.js")
const app = createApp(defineAsyncComponent(() => import('./App.vue')));
console.log("加载main.js",app)
elementPlusInit(app)
piniaInit(app)
routerInit(app)

window.parent.postMessage({ pluginMessage: { type: 'close' } }, '*');
app.use(i18n)
app.mount('#app')
