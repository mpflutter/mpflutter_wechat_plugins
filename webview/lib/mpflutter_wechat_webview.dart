import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_WebView {
  // 注意：onMessage 中的值可能的类型是 String / num / bool / mpjs.JSObject<dynamic, dynamic> / mpjs.JSArray<dynamic, dynamic>，这取决于你在 WebView 中传入的值类型。
  static String open(
    String src, {
    Function(dynamic)? onMessage,
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
