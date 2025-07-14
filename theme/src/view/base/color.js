/*
* 目标支持格式：
#000（简写 3 位，表示 #000000）
#000000（6 位 RGB）
#000000FF（8 位 RGBA，忽略透明度或将其保留）
* */
function normalizeHex(hex) {
    hex = hex.trim().replace(/^#/, '');
    if (hex.length === 3) {
        // #abc => #aabbcc
        hex = hex.split('').map(x => x + x).join('');
    } else if (hex.length === 8) {
        // 忽略 alpha 通道（后两位）
        hex = hex.substring(0, 6);
    } else if (hex.length !== 6) {
        throw new Error('不支持的颜色格式: ' + hex);
    }

    return '#' + hex;
}
function hexToRgb(hex) {
    hex = normalizeHex(hex);
    const bigint = parseInt(hex.slice(1), 16);
    return [ (bigint >> 16) & 255, (bigint >> 8) & 255, bigint & 255 ];
}

function rgbToHex([r, g, b]) {
    return '#' + [r, g, b].map(x => x.toString(16).padStart(2, '0')).join('');
}

export function blendColors(start, end, steps) {
    const [r1, g1, b1] = hexToRgb(start);
    const [r2, g2, b2] = hexToRgb(end);
    const result = [];
    for (let i = 0; i < steps; i++) {
        const ratio = i / (steps - 1);
        const r = Math.round(r1 + (r2 - r1) * ratio);
        const g = Math.round(g1 + (g2 - g1) * ratio);
        const b = Math.round(b1 + (b2 - b1) * ratio);
        result.push(rgbToHex([r, g, b]));
    }
    return result;
}

// 示例：
//console.log(blendColors('#000000', '#ffffff', 50));
