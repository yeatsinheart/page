// hash-cdn-replace.js
import fs from 'fs';
import path from 'path';

const map = {}
function getCDNByHash(hash) {
    // 简单 hash 映射：最后一位字符作为选择器
    const index = parseInt(hash[hash.length - 1], 16) % cdnList.length;
    return cdnList[index];
}

function replaceInFile(filePath) {
    let content = fs.readFileSync(filePath, 'utf-8');
    /*
  <script type="module" crossorigin src="https://cdn.example.com/assets/index-d6cY2r7d.js"></script>
  <link rel="stylesheet" crossorigin href="https://cdn.example.com/assets/index-CEyqj2cM.css">
    * */
    // 网页发布到CDN上，租户网页服务反代CDN进行修改
    // 首页走本身服务器  -> 获取到CDN列表
    // 其它内页走公共CDN
    let tag = 'figma.showUI(__html__,';
    if(content.indexOf(tag) > -1){


    }
    // 匹配类似 /assets/index.abc123.js
  /*  content = content.replace(/(["'`])\/assets\/([a-zA-Z0-9_-]+)\.([a-f0-9]{6,})\.(js|css|png|jpg|svg)\1/g, (match, quote, name, hash, ext) => {
        const cdn = getCDNByHash(hash);
        return `${quote}${cdn}assets/${name}.${hash}.${ext}${quote}`;
    });
*/
    fs.writeFileSync(filePath, content);
}

function walk(dir) {
    fs.readdirSync(dir).forEach(file => {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            walk(fullPath);
        } else if (/index\.(html)$/.test(file)) {
            //replaceInFile(fullPath);
            console.log(fullPath);
            let content = fs.readFileSync(fullPath, 'utf-8');
            map["html"]=content;
        }
         else if (/code\.(js)$/.test(file)) {
                    //replaceInFile(fullPath);
                    console.log(fullPath);
                    let content = fs.readFileSync(fullPath, 'utf-8');
                    map["code"]=fullPath;
                }
    });
}

walk('./dist');
console.log(map)
let content = fs.readFileSync(map["code"], 'utf-8');
content = content.replace("__html__","pluginhtml")
content='const pluginhtml=`'+map["html"]+'`;'+content;
fs.writeFileSync(map["code"], content);
