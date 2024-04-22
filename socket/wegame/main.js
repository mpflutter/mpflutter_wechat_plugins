export class MPFlutter_Wechat_Socket {
  constructor() {
    this.socket = wx.createTCPSocket();
  }

  connect(host, port, timeout) {
    return new Promise((resolve, reject) => {
      this.socket.onConnect(function () {
        resolve(null);
      });
      this.socket.onError(function (res) {
        reject(res.errMsg);
      });
      this.socket.connect({
        address: host,
        port: port,
        timeout: timeout ?? 2,
      });
    });
  }

  listen(callback) {
    this.socket.onMessage(function (res) {
      callback(res.message);
    });
  }

  listenClose(callback) {
    this.socket.onClose(function () {
      callback();
    });
  }

  listenError(callback) {
    this.socket.onError(function (res) {
      callback(res.errMsg);
    });
  }

  write(data) {
    this.socket.write(data);
  }

  destroy() {
    this.socket.close();
    this.socket = undefined;
  }

  close() {
    this.socket?.close();
  }
}

wx.MPFlutter_Wechat_Socket = MPFlutter_Wechat_Socket;
