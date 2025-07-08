import {createRouter, createWebHashHistory,createWebHistory} from "vue-router";
import {destroy_pop} from "@/tool/pop.js";
import {is_pop_view, view_get_by_path, ViewKeyPathMap} from "@/view.js";

// 避免多 //// 访问报错问题
if (window.location.pathname.match(/^\/{2,}/)) {
    window.location.replace(window.location.pathname.replace(/^\/+/, "/"));
}

const routes = [{
    path: "/:pathMatch(.*)*",
    redirect: "/",
},
];

/** 本地所有页面文件 localhost:8092/view/xxx 访问*/
const fileMap = import.meta.glob("@/view/**/*.vue");
if (import.meta.env.DEV) {
    for (let file_path in fileMap) {
        let dir = file_path.substring(5);
        // 移除.vue
        let url = dir.substring(0, dir.length - 4)

        routes.push({
            path: "/" + url, // 新的路径
            name: "/" + url,   // 使用相同的路由名称
            meta: {},   // 参数 dir  loggedIn openBy
            component: () => view_get_by_path(file_path)(), // 新的组件
        })
    }
}


const router = createRouter({
    //history: createWebHashHistory(style_var("--base")),createWebHashHistory
    history: createWebHistory(),
    routes,
    scrollBehavior() {
        return {top: 0, left: 0};
    },
});


router.beforeEach((to, from, next) => {
    destroy_pop();

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

export function addRoute(view_key,path,meta) {
    //console.log( "/" +view_key,view_get(dir))
    // 找不到界面时，就不添加到路由
    let proxy = view_get_by_path(path);
    if(!proxy){
        return ;
    }
    router.addRoute({
        path: "/" + view_key, // 新的路径
        name: view_key.length>1?view_key:"/",   // 使用相同的路由名称
        meta: meta,   // 参数 dir  loggedIn openBy
        props: true,
        component: () => view_get_by_path(path)(), // 新的组件
    });
}


export default router;


