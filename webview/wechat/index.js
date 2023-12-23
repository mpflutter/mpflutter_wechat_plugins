const { MPFlutter_Wechat_WebView } = require("./main");

Page({
  data: {
    pvid: "",
    src: "",
  },
  onLoad: function (query) {
    this.setData({
      pvid: query.pvid,
      src: query.src,
    });
  },
  onwebviewmessage: function (detail) {
    const cbs = MPFlutter_Wechat_WebView.callbacks[this.data.pvid];
    if (cbs && cbs.onMessage) {
      cbs.onMessage(detail);
    }
  },
  onwebviewload: function (detail) {
    const cbs = MPFlutter_Wechat_WebView.callbacks[this.data.pvid];
    if (cbs && cbs.onLoad) {
      cbs.onLoad(detail);
    }
  },
  onwebviewerror: function (detail) {
    const cbs = MPFlutter_Wechat_WebView.callbacks[this.data.pvid];
    if (cbs && cbs.onMessage) {
      cbs.onError(detail);
    }
  },
});
