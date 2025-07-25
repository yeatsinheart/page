import { createApp } from 'vue'

import {routerInit} from "@/init/router.js";
import {piniaInit} from "@/init/pinia.js";
import {elementPlusInit} from "@/init/element-plus.js";
import i18n from "@/init/i18n.js";

const app = createApp(defineAsyncComponent(() => import('./App.vue')));

elementPlusInit(app)
piniaInit(app)
routerInit(app)

window.parent.postMessage({ pluginMessage: { type: 'close' } }, '*');
app.use(i18n)
app.mount('#app')
