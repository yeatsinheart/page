
// 如果这个方法来自后端：：
import {canvas_device_id} from "@/tool/canvas.js";

export function get_device_id() {
    return canvas_device_id();
}
console.log(get_device_id());