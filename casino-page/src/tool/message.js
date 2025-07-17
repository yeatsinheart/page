
class MessageHandler {
    constructor(wsService) {
        this.wsService = wsService;
        this.messageQueue = this._loadMessageQueue();
        this.wsService.on("open", () => setTimeout(() => {this._flushMessageQueue()},100));
        this.wsService.on("message", (data) => this._handleMessage(data));
    }
    sendMessage(message) {
        if (this.wsService.socket && this.wsService.socket.readyState === WebSocket.OPEN) {
            this.wsService.sendMessage(message);
        } else {
            this.messageQueue.push(message);
            this._saveMessageQueue();
        }
    }
    _flushMessageQueue() {
        while (this.messageQueue.length > 0) {
            this.wsService.sendMessage(this.messageQueue.shift());
        }
        this._saveMessageQueue();
    }
    _handleMessage(data) {
        try {
            const parsedData = JSON.parse(data);
            if (parsedData.type === "error" && parsedData.code === 401) {
                this._refreshTokenAndReconnect();
            }
        } catch (error) {
            console.error("消息解析失败", error);
        }
    }


    _saveMessageQueue() {
        localStorage.setItem("ws_message_queue", JSON.stringify(this.messageQueue));
    }

    _loadMessageQueue() {
        return JSON.parse(localStorage.getItem("ws_message_queue")) || [];
    }
}
