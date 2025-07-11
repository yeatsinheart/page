// hash-cdn-replace.js
import fs from 'fs';
import path from 'path';

const cdnList = [
    'https://cdn1.example.com/',
    'https://cdn2.example.com/',
    'https://cdn3.example.com/',
];

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
    let tag = 'return"https://cdn.example.com/"+e';
    if(content.indexOf(tag) > -1){
        // 要注入CDN替换方法
        // return cdn(e);

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
        } else if (/\.(html|js|css)$/.test(file)) {
            replaceInFile(fullPath);
        }
    });
}

walk('./dist');
