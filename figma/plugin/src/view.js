export const ViewKeyPathMap = {
  app_layout: "/app/layout/test",

};

export const ViewKeyDict = Object.freeze({
  auth: "auth",
  home: "home",
});


import {toRouteKey} from "@/init/router.js";

/** 防止浏览器直接打开路由，所以只能通过方法，弹出页面的路由就无法访问 */
export function open_by_key(view_key, params) {
  /**最终走路由*/
  toRouteKey(view_key, params)
}


