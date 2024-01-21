import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_Image extends StatelessWidget {
  final String src;
  final String mode;
  final bool showMenuByLongpress;
  final Function(mpjs.JSObject)? onError;
  final Function(mpjs.JSObject)? onLoad;
  final bool webp;
  final bool lazyLoad;

  MPFlutter_Wechat_Image({
    this.src = "",
    this.mode = "scaleToFill",
    this.showMenuByLongpress = false,
    this.onError,
    this.onLoad,
    this.webp = false,
    this.lazyLoad = false,
  });

  @override
  Widget build(BuildContext context) {
    return MPFlutterPlatformView(
      viewClazz: "MPFlutter_Wechat_Image",
      viewProps: {
        "src": src,
        "mode": mode,
        "showMenuByLongpress": showMenuByLongpress,
        "webp": webp,
        "lazyLoad": lazyLoad,
      },
      eventCallback: (originEvent, detail) {
        final event = originEvent.toLowerCase();
        switch (event) {
          case "error":
            onError?.call(detail);
            break;
          case "load":
            onLoad?.call(detail);
            break;
          default:
            break;
        }
      },
    );
  }
}
