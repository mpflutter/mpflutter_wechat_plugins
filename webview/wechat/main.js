export class MPFlutter_Wechat_WebView {
  static callbacks = {};

  static open(src, onMessage, onLoad, onError) {
    const pvid = Math.random().toString();
    this.callbacks[pvid] = { onMessage, onLoad, onError };
    wx.navigateTo({
      url: `/mpflutter_wechat_webview/pages/index?pvid=${pvid}&src=${encodeURIComponent(
        src
      )}`,
    });
    return pvid;
  }

  static close(pvid) {
    const lastPage = getCurrentPages().pop();
    if (
      lastPage.route === "mpflutter_wechat_webview/pages/index" &&
      lastPage.options.pvid === pvid
    ) {
      wx.navigateBack({});
    }
  }
}

wx.MPFlutter_Wechat_WebView = MPFlutter_Wechat_WebView;
