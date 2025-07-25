import {fileURLToPath, URL} from 'node:url'

import {defineConfig, loadEnv} from 'vite'
import vue from '@vitejs/plugin-vue'
import AutoImport from 'unplugin-auto-import/vite';
import Components from 'unplugin-vue-components/vite';
import autoprefixer from 'autoprefixer'

import { resolve } from 'path';

// https://cn.vite.dev/config/
export default defineConfig(({mode}) => {
  // ✅ 加载 .env 文件中的变量
  const env = loadEnv(mode, process.cwd());
  return {
    //base: mode === 'development' ? '/' : 'https://cdn.example.com/', // ✅ 替换为你自己的域名或路径
    plugins: [
      vue(),
      AutoImport({
        imports: ["vue"], // ✅ 让 `ref`、`beforeMount` 等 Vue API 自动导入
      }),
      //Components({}),
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
    terserOptions: {
      format: {
        comments: false, // 去除注释
      },
      compress: {
        pure_funcs: ['console.log'], // 更暴力地移除 console.log
      },
    },
    build: {
      minify: 'terser', // ✅ 默认，可选 'esbuild' 或 false
       rollupOptions: {
          input: {
                ui: resolve(__dirname, 'index.html'),  // Vue 入口
                code: resolve(__dirname, 'src/code.ts')     // 插件主逻辑
              },
              output: {
                dir: 'dist',
                entryFileNames: assetInfo => assetInfo.name === 'code' ? 'code.js' : '[name].js',
              },
          },
     outDir: 'dist',
    emptyOutDir: true             // 清空 dist
    },

    server: {
      //allowedHosts: ['s1.cdn.com','s2.cdn.com','s3.cdn.com','s4.cdn.com','s5.cdn.com'], // ⚠️ 放开域名
      host: '0.0.0.0',
      port: '8093',
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
