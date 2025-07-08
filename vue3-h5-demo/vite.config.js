import {fileURLToPath, URL} from 'node:url'

import {defineConfig, loadEnv} from 'vite'
import vue from '@vitejs/plugin-vue'
import AutoImport from 'unplugin-auto-import/vite';
import Components from 'unplugin-vue-components/vite';
import {VantResolver} from '@vant/auto-import-resolver';
import postCssPxToRem from 'postcss-pxtorem'
import autoprefixer from 'autoprefixer'

// https://cn.vite.dev/config/
export default defineConfig(({mode}) => {
    // ✅ 加载 .env 文件中的变量
    const env = loadEnv(mode, process.cwd());
    return {
        base: mode === 'development' ? '/' : 'https://cdn.example.com/', // ✅ 替换为你自己的域名或路径
        plugins: [
            vue(),
            AutoImport({
                imports: ["vue"], // ✅ 让 `ref`、`beforeMount` 等 Vue API 自动导入
                resolvers: [VantResolver()],
            }),
            Components({
                resolvers: [VantResolver()],
            }),
        ],
        resolve: {
            alias: {
                '@': fileURLToPath(new URL('./src', import.meta.url)),
                'vue': 'vue/dist/vue.esm-bundler.js'
            },
        },
        css: {
            postcss: {
                plugins: [
                    postCssPxToRem({ // 自适应，px>rem转换
                        rootValue({file}) {
                            // vant 37.5 默认75 对应750设计稿
                            // vant 14px 要变成 .24rem 需要58.33333
                            return file.indexOf('vant') !== -1 ? 58.33333 : 75;
                        },
                        propList: ['*'], // 需要转换的属性，这里选择全部都进行转换
                        //exclude: /node_modules/i,//不处理node_modules文件下的css
                    }),
                    autoprefixer({ // 自动添加前缀
                        overrideBrowserslist: [
                            "Android 4.1",
                            "iOS 7.1",
                            "Chrome > 31",
                            "ff > 31",
                            "ie >= 8"
                        ],
                    })
                ]
            },
            preprocessorOptions: {
                scss: {
                    //additionalData: '@use "@/assets/style/mixin.scss" as *;'
                }
            }

        },
        server: {
            host: '0.0.0.0',
            port: '8092',
            open: true,
            proxy: {
                // 选项写法
                '/api': {
                    // target: 'http://client.dev.biyingbaowang.co',
                    target: 'http://localhost:8089',
                    changeOrigin: true,
                    // rewrite: (path) => path.replace(/^\/api/, '')//移除/api前缀
                },
            }
        }
    }
})
