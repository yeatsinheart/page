
export function format_str(format, ...args) {
    let i = 0;
    return format.replace(/%[sd]/g, match => {
        const val = args[i++];
        return match === "%d" ? Number(val) : String(val);
    });
}
function simpleHash(str) {
    let hash = 5381;
    for (let i = 0; i < str.length; i++) {
        hash = (hash * 33) ^ str.charCodeAt(i);
    }
    return hash >>> 0; // 保证为正整数（uint32）
}
// 如果这个方法来自后端：：
export function cdn(url) {
    let old = ["http://localhost:8080"];
    let cdnList=["http://s1.cdn.com:8092","http://s2.cdn.com:8092","http://s3.cdn.com:8092","http://s4.cdn.com:8092","http://s5.cdn.com:8092"];
    if(url.startsWith("http")) {
        const from = new URL(url);
        if(old.includes(from.origin)){
            let hash=simpleHash(from.pathname);
            const to = new URL(cdnList[hash%cdnList.length]);
            to.pathname = from.pathname;
            to.search = from.search;
            return to.toString();
        }
    }else {
        let hash=simpleHash(url);
        url = cdnList[hash%cdnList.length]+url;
    }
    return url;
}

cdn("/a/b?x=1",)
cdn("http://localhost:8080/a/b?x=1",)
cdn("/img/un_login_avatar.png")

