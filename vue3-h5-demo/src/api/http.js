import axios from "axios";
import router from "@/config/router";
import dayjs from "dayjs"
import {userStore} from "@/config/store/user.js";
import {canvas_device_id, getOS} from "@/tool/canvas.js";

const devHost = 'http://localhost:8089';

const service = axios.create({
    baseURL: import.meta.env.DEV?devHost:'',
    withCredentials: false,
    timeout: 1000 * 10 // 请求超时
})
service.defaults.headers.post['Content-Type'] = 'application/json;charset=UTF-8';



// 请求拦截器
service.interceptors.request.use(
    config => {
        let userState = userStore();
        if (config.Api) config.headers.Api = config.Api;
        config.headers.language = localStorage.getItem('Language');
        config.headers.connectId = localStorage.getItem('connectId');
        config.headers.system =getOS()
        config.headers.code ='h5'
        config.headers.deviceId =canvas_device_id()
        config.headers.token =userState.token
        config.headers.time = dayjs().valueOf()
        return config
    },
    error => {
        return Promise.reject(error)
    }
)

// 响应拦截器
service.interceptors.response.use(
    response => {
        if (response.status === 200) {
            if (response.data.code === 1) {
                return Promise.resolve(response.data.data);
            } else if (response.data.code === -6) {
                userStore().toLogin()
                return Promise.reject(response);
            } else {
                showToast({ message: response.data.msg,duration: 1500, forbidClick: true});
                return Promise.reject(response);
            }
        } else {
            return Promise.reject(response);
        }

    },
    error => {
        if(error.code==="ERR_NETWORK"){
            showToast({ message: '当前网络异常',duration: 3500, forbidClick: true});
            return Promise.reject(error)
        }
        console.error(error)
        if (error.response.status) {
            switch (error.response.status) {
                // 401: 未登录       
                case 401:
                    router.replace({
                        path: '/login',
                        query: {
                            redirect: router.currentRoute.fullPath
                        }
                    });
                    break;
                // 403 token过期
                case 403:
                    showToast({
                        message: '登录过期，请重新登录',
                        duration: 1000,
                        forbidClick: true
                    });
                    // 清除token
                    store.dispatch('FedLogOut').then(() => {
                        router.replace({
                            path: '/login',
                            query: {
                                redirect: router.currentRoute.fullPath
                            }
                        })
                    })
                    break;
                // 404请求不存在
                case 404:
                    showToast({
                        message: '网络请求不存在',
                        duration: 1500,
                        forbidClick: true
                    });
                    break;
                // 其他错误，直接抛出错误提示
                default:
                    showToast({
                        message: error.response.data.message,
                        duration: 1500,
                        forbidClick: true
                    });
            }
            return Promise.reject(error.response);
        } else {
            // 处理断网的情况
            //store.commit('changeNetwork', false);
        }
    });

export default service;


