import {createPinia} from "pinia";
const pinia = createPinia();
export function piniaInit(app) {
    app.use(pinia)
}



