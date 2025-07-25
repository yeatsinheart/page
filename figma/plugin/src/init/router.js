// 根据不同路径 打开不同的页面。
// 比如iframe 是打开纯
// router-view 指定页面。。 嵌套路由如何动态替换父。
import {createRouter, createWebHistory} from "vue-router";
import {get_file_router, view_get_by_path} from "@/init/file.js";
// 避免多 //// 访问报错问题
if (window.location.pathname.match(/^\/{2,}/)) {
  window.location.replace(window.location.pathname.replace(/^\/+/, "/"));
}

const routes = [
  {path: "/:pathMatch(.*)*", redirect: "/",},
];

if (import.meta.env.DEV) {
  routes.push(...get_file_router());
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
  const cleanedPath = to.path.replace(/\/+/g, "/"); // 替换多个 / 为单个 /
  if (to.path !== cleanedPath) {
    next(cleanedPath); // 重新跳转到去重后的路径
  } else {
    next(); // 继续导航
  }
})

export function routerInit(app) {
  addRoute("", "/view-demo")
  app.use(router)
}

/// view_key 就是浏览器地址呢 /
export function addRoute(view_key, path, name, meta) {
  //console.log( "/" +view_key,view_get(dir))
  // 找不到界面时，就不添加到路由
  let proxy = view_get_by_path(path);
  if (!proxy) {
    return;
  }
  router.addRoute({
    path: "/" + view_key, // 新的路径
    name: view_key.length > 1 ? view_key : "/",   // 使用相同的路由名称
    meta: meta,   // 参数 dir  loggedIn openBy
    props: true,
    component: () => proxy(), // 新的组件
  });
}

export function toRouteKey(view_key, params) {
  // params 只有在 name 跳转时才生效。
  // 路由传参数，必须暴露在URL中，导致如果传递富文本，可能会出问题。
  router.push({name: view_key, query: params});
}

