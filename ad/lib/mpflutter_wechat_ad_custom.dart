import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_AdCustom extends StatefulWidget {
  final String unitId;
  final int adIntervals;
  final Function(mpjs.JSObject)? onError;
  final Function(mpjs.JSObject)? onLoad;
  final Function(mpjs.JSObject)? onClose;

  MPFlutter_Wechat_AdCustom({
    required this.unitId,
    this.adIntervals = 30,
    this.onError,
    this.onLoad,
    this.onClose,
  });

  @override
  State<MPFlutter_Wechat_AdCustom> createState() =>
      _MPFlutter_Wechat_AdCustomState();
}

class _MPFlutter_Wechat_AdCustomState extends State<MPFlutter_Wechat_AdCustom> {
  double bannerHeight = 0;
  final platformViewController = MPFlutterPlatformViewController();

  void updateBannerHeight() {
    if (platformViewController.pvid == null) return;
    final query = (mpjs.context["wx"] as mpjs.JSObject)
        .callMethod("createSelectorQuery") as mpjs.JSObject;
    final obj = query.callMethod("select", ["#" + platformViewController.pvid!])
        as mpjs.JSObject;
    (obj.callMethod("boundingClientRect", [
      (mpjs.JSObject rect) {
        final bannerHeight = (rect["height"] as num).toDouble();
        if ((this.bannerHeight - bannerHeight).abs() > 0.01) {
          setState(() {
            this.bannerHeight = bannerHeight;
          });
        }
      }
    ]) as mpjs.JSObject)
        .callMethod("exec", []);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bannerHeight,
      child: MPFlutterPlatformView(
        controller: platformViewController,
        viewClazz: "MPFlutter_Wechat_AdCustom",
        viewProps: {
          "unitId": widget.unitId,
          "adIntervals": widget.adIntervals,
        },
        eventCallback: (originEvent, detail) {
          final event = originEvent.toLowerCase();
          switch (event) {
            case "error":
              updateBannerHeight();
              widget.onError?.call(detail);
              break;
            case "load":
              updateBannerHeight();
              widget.onLoad?.call(detail);
              break;
            case "close":
              updateBannerHeight();
              widget.onClose?.call(detail);
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
