export function getOS() {
    const userAgent = navigator.userAgent.toLowerCase();

    if (userAgent.includes("win")) return "Windows";
    if (userAgent.includes("mac")) return "MacOS";
    if (userAgent.includes("linux")) return "Linux";
    if (userAgent.includes("android")) return "Android";
    if (userAgent.includes("iphone") || userAgent.includes("ipad")) return "iOS";

    return "Unknown OS";
}

export function canvas_device_id() {
    // 创建一个不可见的canvas元素
    const canvas = document.createElement('canvas');
    const context = canvas.getContext('2d');

    // 设置canvas宽高
    canvas.width = 200;
    canvas.height = 50;

    // 绘制文本
    context.textBaseline = 'top';
    context.font = "14px 'Arial'";
    context.textBaseline = "alphabetic";
    context.fillStyle = "#f60";
    context.fillRect(125, 1, 62, 20);
    context.fillStyle = "#069";
    context.fillText("Canvas Fingerprint", 2, 15);
    context.fillStyle = "rgba(102, 204, 0, 0.7)";
    context.fillText("Browser Fingerprint", 4, 17);

    // 绘制图形
    context.strokeStyle = "rgba(102, 204, 0, 0.7)";
    context.beginPath();
    context.arc(50, 50, 50, 0, Math.PI * 2, true);
    context.stroke();

    // 将canvas内容转换为base64编码的Data URL
    const dataUrl = canvas.toDataURL();

    // 打印Data URL
    //console.log("Canvas Data URL:", dataUrl);

    // 对Data URL进行简单的哈希运算生成指纹
    return hashString(dataUrl);
}

// 简单的哈希函数（可以替换为更复杂的算法如SHA256）
function hashString(str) {
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
        const char = str.charCodeAt(i);
        hash = (hash << 5) - hash + char;
        hash |= 0; // 强制转换为32位整数
    }
    return hash;
}