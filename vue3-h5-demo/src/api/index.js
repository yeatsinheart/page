import request from "@/api/http";
import {userStore} from "@/config/store/user.js";
/** 调用时直接引用 ApiRequest._某个KEY(参数) **/
export const ApiRequest = {
  /**接口Start**/

  /**接口End**/
}

export const post_json = (data,loginRequired) => {
  if(loginRequired && !userStore().isLoggedIn){userStore().toLogin();return Promise.reject("un-login");}
  return request({
    url: "/api/client",
    method: "POST",
    data: data.data || {},
    Api: data.api,
  });
};

const upload = (data,loginRequired) => {
  if(loginRequired && !userStore().isLoggedIn){userStore().toLogin();return Promise.reject("un-login");}
  const formData = new FormData();
  formData.append('file', data.data);
  return request({
    url: "/api/client",
    method: "POST",
    Api: data.api,
    data:formData,
    headers: {
      'Content-Type': 'multipart/form-data', // 文件上传类型
    },
  })
}
