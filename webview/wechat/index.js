const { MPFlutter_Wechat_WebView } = require("./main");

Page({
  data: {
    pvid: "",
    src: "",
  },
  onLoad: function (query) {
    this.setData({
      pvid: query.pvid,
      src: decodeURIComponent(query.src),
    });
  },
  onwebviewmessage: function (detail) {
    const cbs = MPFlutter_Wechat_WebView.callbacks[this.data.pvid];
    if (cbs && cbs.onMessage) {
      const data = detail.detail.data;
      if (data instanceof Array) {
        data.forEach((item) => {
          cbs.onMessage(item);
        });
      } else {
        cbs.onMessage(data);
      }
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
