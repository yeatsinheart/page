/*
* 目标支持格式：
#000（简写 3 位，表示 #000000）
#000000（6 位 RGB）
#000000FF（8 位 RGBA，忽略透明度或将其保留）
* */
function normalizeHexTo6(hex) {
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

function normalizeHexTo8(hex) {
  hex = hex.trim().replace(/^#/, '');
  if (hex.length === 3) {
    // #abc => #aabbccff
    hex = hex.split('').map(x => x + x).join('') + 'FF';
  } else if (hex.length === 6) {
    // 补上不透明 alpha
    hex = hex + 'FF';
  } else if (hex.length === 8) {
    // 保留 alpha，不变
    // 可根据需要对 alpha 做统一处理（比如四舍五入到整档）
  } else {
    throw new Error('不支持的颜色格式: ' + hex);
  }

  return '#' + hex.toUpperCase();
}

export function isWhite(hex) {
  hex = normalizeHexTo6(hex).slice(1);
  const r = parseInt(hex.substr(0, 2), 16);
  const g = parseInt(hex.substr(2, 2), 16);
  const b = parseInt(hex.substr(4, 2), 16);
  // YIQ 亮度公式
  const yiq = (r * 299 + g * 587 + b * 114) / 1000;
  return yiq >= 128; // 浅背景用黑字，深背景用白字
}

export function fontColor(hex) {
  return isWhite(hex) ? '#000000' : '#ffffff'; // 浅背景用黑字，深背景用白字
}

export function hexToRgb(hex) {
  hex = normalizeHexTo6(hex);
  const bigint = parseInt(hex.slice(1), 16);
  return [(bigint >> 16) & 255, (bigint >> 8) & 255, bigint & 255];
}

export function hexToRgba(hex) {
  hex = normalizeHexTo8(hex); // 保证是 8 位格式: #RRGGBBAA
  const bigint = parseInt(hex.slice(1), 16);
  const r = (bigint >> 24) & 255;
  const g = (bigint >> 16) & 255;
  const b = (bigint >> 8) & 255;
  const a = bigint & 255;
  return {r: r, g: g, b: b, a: +(a / 255).toFixed(3)}; // 可返回小数形式 alpha
}

export function rgbaToHex([r, g, b, a = 1]) {
  const alpha = Math.round(a * 255);
  return (
    '#' +
    [r, g, b, alpha]
      .map(x => x.toString(16).padStart(2, '0'))
      .join('')
      .toUpperCase()
  );
}

export function rgbToHex([r, g, b]) {
  return '#' + [r, g, b].map(x => x.toString(16).padStart(2, '0')).join('');
}

export function parseRgbLike(str) {
  const nums = str.match(/[\d.]+/g);
  if (!nums || nums.length < 3) throw new Error('Invalid RGB string');
  const arr = nums.slice(0, 3).map(Number); // 只取 R G B，忽略 alpha
  return {r: arr[0], g: arr[1], b: arr[2], a: null}
}

export function parseRgbaLike(str) {
  const nums = str.match(/[\d.]+/g);
  if (!nums || nums.length < 4) throw new Error('Invalid RGBA string');
  const arr = nums.slice(0, 4).map(Number); // 只取 R G B，忽略 alpha
  return {r: arr[0], g: arr[1], b: arr[2], a: arr[3].toFixed(3)}
}

export function invertColor(hex) {
  hex = normalizeHexTo6(hex).slice(1);
  // 取反每个颜色通道
  const r = (255 - parseInt(hex.slice(0, 2), 16)).toString(16).padStart(2, '0')
  const g = (255 - parseInt(hex.slice(2, 4), 16)).toString(16).padStart(2, '0')
  const b = (255 - parseInt(hex.slice(4, 6), 16)).toString(16).padStart(2, '0')
  return `#${r}${g}${b}`
}

function mixColors(c1, c2, ratio = 0.5) {
  const rgb1 = hexToRgb(c1)
  const rgb2 = hexToRgb(c2)
  const r = Math.round(rgb1.r * (1 - ratio) + rgb2.r * ratio)
  const g = Math.round(rgb1.g * (1 - ratio) + rgb2.g * ratio)
  const b = Math.round(rgb1.b * (1 - ratio) + rgb2.b * ratio)
  return rgbToHex(r, g, b)
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

//调整亮度（变浅/变深）
function adjustBrightness(hex, amount) {
  const {r, g, b} = hexToRgb(hex)
  const clamp = val => Math.max(0, Math.min(255, val))
  return rgbToHex(
    clamp(r + amount),
    clamp(g + amount),
    clamp(b + amount)
  )
}