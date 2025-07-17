import {canvas_device_id} from "@/tool/canvas.js";
import mitt from "@/config/mitt";

class WebSocketClient {
    constructor(url, options = {}) {
        this.defaultUrl = url;
        this.url = url;
        this.socket = null;
        this.heart =  options.heart||"HEART";
        this.reconnectInterval = options.reconnectInterval || 5000;
        this.heartbeatInterval = options.heartbeatInterval || 30000;
        this.connectTimeout = options.connectTimeout || 10000;
        this.reconnectAttempts = 0;
        this.maxReconnectAttempts = options.maxReconnectAttempts || Infinity;
        this.isManualClose = false;
        this.isConnecting = false;
        this.isReconnecting = false;
        this._setupEventListeners();
    }

    async _fetchWebSocketURL() {
        /*try {
            const response = await fetch("/api/get-ws-url");
            const data = await response.json();
            console.info("🌐 获取 WebSocket 地址:", data.wsUrl);
            return data.wsUrl || this.defaultUrl;
        } catch (error) {
            console.error("❌ 获取 WebSocket 地址失败，使用默认地址:", error);
            return this.defaultUrl;
        }*/
        return this.defaultUrl;
    }

    async connect() {
        if (!navigator.onLine || this.isConnecting) return;
        this.isConnecting = true;
        this.url = await this._fetchWebSocketURL();
        //console.info(`🔌 开始连接 WebSocket: ${this.url}`,new Date());
        this.socket = new WebSocket(this.url);
        // 超时异常检测 open后取消
        this.connectTimeoutTimer = setTimeout(() => {
            if (this._status_un_open()) {
                console.warn("❌ WebSocket 连接超时，尝试重连...");
                this._reconnect();
            }
        }, this.connectTimeout);

        this.socket.onopen = () => {
            //console.info("✅ WebSocket 连接成功");
            this.isReconnecting = false;
            this.reconnectAttempts = 0;
            clearTimeout(this.connectTimeoutTimer);
            // **延迟100ms启动心跳，确保连接稳定**
            setTimeout(() => {this._startHeartbeat();}, 500);
            mitt.emit("ws:open");
        };

        this.socket.onmessage = (event) => {
            let data = null;
            this._isPongReceived = true;
            // 收到消息 后重置心跳 因为已经接受到消息，代表连接暂时是正常的。
            this._startHeartbeat();
            if (typeof event.data === "string") {
                //console.log("收到文本消息:", event.data);
                if(event.data.startsWith("connectId:")){
                    localStorage.setItem("connectId", event.data.substring("connectId:".length));
                    return;
                }
            } else if (event.data instanceof Blob) {
                event.data.arrayBuffer().then(arr => {
                    let string = decode(arr)
                    let parse ={};
                    try{parse = JSON.parse(string);}catch(e){}
                    if(string.startsWith("connectId:")){
                        localStorage.setItem("connectId", string.substring("connectId:".length));
                    }else if(this.heart===string){
                    }else if(parse.topic && parse.action){
                        mitt.emit("ws:topic:"+parse.topic+":action:"+parse.action,parse);
                    }else {
                        console.log(string);
                    }
                })
            } else if (event.data instanceof ArrayBuffer) {
                //console.log("收到 ArrayBuffer 数据:", event.data);
                //this.handleArrayBuffer(event.data);
            } else {
                //console.warn("未知数据类型:", event.data);
            }
            mitt.emit("ws:message",data);
            // **只分发给监听该类型的事件**
            /*if (data?.type) {
                mitt.emit(data?.type, data);
            }*/
        };

        this.socket.onerror = (error) => {
            console.error("❌ WebSocket 错误:", error);
            mitt.emit("ws:error",error);
        };

        this.socket.onclose = () => {
            console.warn("⚠️ WebSocket 连接已关闭");
            mitt.emit("ws:closed");
            this.isReconnecting = false;
            this._reconnect();
        };
    }

    sendMessage(message) {
        return new Promise((resolve, reject) => {
            if (!this.socket || this.socket.readyState !== WebSocket.OPEN) {
                console.warn("⚠️ WebSocket 未连接，消息未发送", message);
                if(this._status_un_open()){
                    this._reconnect();
                }
                return reject(new Error("WebSocket 未连接，消息未发送"));
            }
            try {
                this.socket.send(message);
                resolve(true);
            } catch (error) {
                console.error("❌ 发送消息失败:", error);
                reject(error);
            }
        });
    }


    _reconnect() {
        if (this.isManualClose)return;
        if (this.isReconnecting || this.reconnectAttempts >= this.maxReconnectAttempts) return;
        // **避免并发重连**
        this.isReconnecting = true;
        // **先关闭旧的 WebSocket，确保新连接不会冲突**
        this._close();
        const delay = Math.min(this.reconnectInterval * (2 ** this.reconnectAttempts), 10000);
        console.warn(`🔄 断开 WebSocket ，${delay / 1000}s 后重连...`);
        setTimeout(() => {
            this.reconnectAttempts++;
            this.connect();
        }, delay);
    }

    _startHeartbeat() {
        if (this.heartbeatTimer) {
            clearInterval(this.heartbeatTimer);
        }
        this.heartbeatTimer = setInterval(() => {
            //console.log("💗 发送 Ping...",this._isPongReceived );
            if (!this.socket || this.socket.readyState !== WebSocket.OPEN) {
                console.warn("⚠️ WebSocket 未连接，跳过 Ping 发送");
                return;
            }
            this._isPongReceived = false;
            this.sendMessage(encodeAndReverse(this.heart))
                .catch((err) => {
                    console.warn("⚠️ 发送 Ping 失败，可能已断开", err);
                });
            // **清除之前的 pong 超时检测** 3秒内要有pong
            clearTimeout(this.pongTimeout);
            this.pongTimeout = setTimeout(() => {
                if (!this._isPongReceived && this.socket && this.socket.readyState === WebSocket.OPEN) {
                    console.warn("⏳ 未收到 Pong，重连 WebSocket");// 应该是重连吧
                    this._reconnect();
                }
            }, 3000);
        }, this.heartbeatInterval);
    }

    _stopHeartbeat() {
        clearInterval(this.heartbeatTimer);
    }

    close_forever() {
        this.isManualClose = true;
        this._close();
    }
    _close(){
        this.isConnecting = false;
        this._stopHeartbeat();
        clearTimeout(this.connectTimeoutTimer);
        if (this.socket) {
            this.socket.onopen = null;
            this.socket.onmessage = null;
            this.socket.onerror = null;
            this.socket.onclose = null;
            this.socket.close();
            this.socket = null;
        }
    }
    _status_un_open() {
        return !this.socket || [WebSocket.CLOSING, WebSocket.CLOSED].includes(this.socket.readyState);
    }
    _setupEventListeners() {
        window.addEventListener("online", () => this._reconnectIfNeeded());
        window.addEventListener("focus", () => this._reconnectIfNeeded());
        document.addEventListener("visibilitychange", () => {
            if (!document.hidden) this._reconnectIfNeeded();
        });
        // 后台定时检测状态
       setInterval(() => {
            if (this._status_un_open()) {
                console.warn("😔 WebSocket 后台定时检测，连接未成功...");
                this._reconnect();
            }
        }, 5000);
    }

    _reconnectIfNeeded() {
        if (this._status_un_open()) {
            this._reconnect();
        }
    }
}
// websocket.js
let websocket = null;

export function getWebsocket() {
    if (!websocket) {
        const protocol = window.location.protocol === "https:" ? "wss" : "ws";
        let host = window.location.hostname === "localhost" ? "localhost:8089" : window.location.host+"/wss"; // 生产环境域名
        websocket = new WebSocketClient(`${protocol}://${host}/${canvas_device_id()}`, {
            reconnectInterval: 3*1000,// 异常重连时间
            heartbeatInterval: 30*1000,// 心跳30秒
            connectTimeout: 10*1000, // 连接超时 10 秒
        });
        websocket.connect();
    }
    return websocket;
}
function safeStringify(data) {
    return typeof data === "string" ? data : JSON.stringify(data);
}
export function websocket_send(topic,action,msg){
    let request = JSON.stringify({topic:topic,action:action,"msg":safeStringify(msg)});
    websocket?.sendMessage(encodeAndReverse(request))
        .then(() => {})
        .catch(err => console.error("消息发送失败:", err));
}

export function websocket_api(api,msg){
    let request = JSON.stringify({topic:"api",action:api,"data":safeStringify(msg||{}),"time":new Date().getTime()});
    websocket?.sendMessage(encodeAndReverse(request))
        .then(() => {})
        .catch(err => console.error("消息发送失败:", err));
}
function decode(arraybuffer){
    let int8Array = reverseInt8Array(new Int8Array(arraybuffer));
    let string = new TextDecoder().decode(int8Array)
    return string;
}

function reverseInt8Array(int8Array){
    for(let i=int8Array.length-1;i>=0;i--){
        int8Array[i]=~int8Array[i];
    }
    return int8Array
}

function encodeAndReverse(str) {
    let encoder = new TextEncoder();
    let uint8Array = encoder.encode(str); // 转成二进制
    let int8Array = new Int8Array(uint8Array); // 转 Int8Array
    reverseInt8Array(int8Array); // 取反
    return int8Array.buffer;
}

