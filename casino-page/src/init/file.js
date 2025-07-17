/** 编译时生成文件映射 Vite 提供的动态导入功能，它返回的是一个 对象（Object），其key 是文件路径，value 是懒加载的导入函数（函数返回 Promise）。*/
export const fileMap = import.meta.glob("@/view/**/*.vue");

/**
 * 只查找/src/view下的文件 对应view——key的dir 懒加载的导入函数（函数返回 Promise）
 * 可能是单文件.vue
 * 可能是符合文件夹/index.vue
 * path 是 / 开头
 * */
export function view_get_by_path(path) {
    return fileMap["/src/view" + path + ".vue"] || //简单页面
        fileMap["/src/view" + path + "/index.vue"] || //复杂页面，多个子组件构成
        fileMap["/src/view" + path + "/demo.vue"] || //默认版本
        fileMap[path] ||
        fileMap["/src/view/app/nomore/demo.vue"] // nomore
}

export function get_file_router() {
    let list = [];
    for (let file_path in fileMap) {
        let dir = file_path.substring(5);
        let path = dir.substring(0, dir.length - 4)// 移除.vue
        list.push({
            path: "/" + path, // 新的路径
            name: "/" + path,   // 使用相同的路由名称
            meta: {},   // 参数 dir  loggedIn openBy
            component: () => fileMap[file_path](), // 新的组件
        })
    }
    return list;
}
