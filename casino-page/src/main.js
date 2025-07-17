import { createApp } from 'vue'

import {routerInit} from "@/init/router.js";
import {piniaInit} from "@/init/pinia.js";
import {elementPlusInit} from "@/init/element-plus.js";

const app = createApp(defineAsyncComponent(() => import('./App.vue')));
elementPlusInit(app)
piniaInit(app)
routerInit(app)
app.mount('#app')
