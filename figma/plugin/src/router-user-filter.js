import router from "@/init/router.js";
import {is_pop_view} from "@/view.js";
// 打开路由
//      是否要求登录
//      是否弹出界面
router.beforeEach((to, from, next) => {
    const cleanedPath = to.path.replace(/\/+/g, "/"); // 替换多个 / 为单个 /
    if(is_pop_view(cleanedPath,to.query)){
        next("/")
    }
    if (to.path !== cleanedPath) {
        next(cleanedPath); // 重新跳转到去重后的路径
    } else {
        next(); // 继续导航
    }
})

