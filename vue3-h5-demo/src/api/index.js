import request from "@/api/http";
import {userStore} from "@/config/store/user.js";
/** 调用时直接引用 ApiRequest._某个KEY(参数) **/
export const ApiRequest = {
  /**接口Start**/
  views:(data)=>post_json({api:'views',data:data}),//页面组合
  layoutItems:(data)=>post_json({api:'layoutItems',data:data}),//布局元素

  _XuhIjT6s:(data)=>post_json({api:'XuhIjT6s',data:data}),//初始化集成
  _DYN7TM69:(data)=>post_json({api:'DYN7TM69',data:data},1),//刷新账号信息
  _B7vKm2x5:(data)=>post_json({api:'B7vKm2x5',data:data},1),//刷新余额
  _L6lduTB9:(data)=>upload({api:'L6lduTB9',data:data},1),//上传
  _djTNv129:(data)=>post_json({api:'djTNv129',data:data}),//登录注册配置
  _logout:(data)=>post_json({api:'logout',data:data},1),//退出登录
  _oauthCheck:(data)=>post_json({api:'oauthCheck',data:data}),//授权登录
  _oauth:(data)=>post_json({api:'oauth',data:data}),//获取授权链接
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
