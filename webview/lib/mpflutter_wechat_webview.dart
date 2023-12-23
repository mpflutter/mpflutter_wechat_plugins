import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_WebView {
  static String open(
    String src, {
    Function(mpjs.JSObject)? onMessage,
    Function(mpjs.JSObject)? onLoad,
    Function(mpjs.JSObject)? onError,
  }) {
    final pvid =
        (mpjs.context["wx"]["MPFlutter_Wechat_WebView"] as mpjs.JSObject)
            .callMethod(
      "open",
      [
        src,
        onMessage,
        onLoad,
        onError,
      ],
    );
    return pvid;
  }

  static void close(String pvid) {
    (mpjs.context["wx"]["MPFlutter_Wechat_WebView"] as mpjs.JSObject)
        .callMethod(
      "close",
      [pvid],
    );
  }
}
