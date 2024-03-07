import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_Button extends StatelessWidget {
  final Widget child;
  final String size;
  final String type;
  final bool plain;
  final bool disabled;
  final bool loading;
  final String formType;
  final String openType;
  final String hoverClass;
  final bool hoverStopPropagation;
  final int hoverStartTime;
  final int hoverStayTime;
  final String lang;
  final String sessionFrom;
  final String sendMessageTitle;
  final String sendMessagePath;
  final String sendMessageImg;
  final String appParameter;
  final bool showMessageCard;
  final bool phoneNumberNoQuotaToast;

  final Function(mpjs.JSObject)? onTap;
  final Function(mpjs.JSObject)? onGetUserInfo;
  final Function(mpjs.JSObject)? onContact;
  final Function(mpjs.JSObject)? onGetPhoneNumber;
  final Function(mpjs.JSObject)? onGetRealtimePhoneNumber;
  final Function(mpjs.JSObject)? onError;
  final Function(mpjs.JSObject)? onOpenSetting;
  final Function(mpjs.JSObject)? onLaunchApp;
  final Function(mpjs.JSObject)? onChooseAvatar;
  final Function(mpjs.JSObject)? onAgreePrivacyAuthorization;

  MPFlutter_Wechat_Button({
    required this.child,
    this.size = "default",
    this.type = "default",
    this.plain = false,
    this.disabled = false,
    this.loading = false,
    this.formType = '',
    this.openType = '',
    this.hoverClass = 'button-hover',
    this.hoverStopPropagation = false,
    this.hoverStartTime = 20,
    this.hoverStayTime = 70,
    this.lang = 'en',
    this.sessionFrom = '',
    this.sendMessageTitle = '',
    this.sendMessagePath = '',
    this.sendMessageImg = '',
    this.appParameter = '',
    this.showMessageCard = false,
    this.phoneNumberNoQuotaToast = true,
    this.onTap,
    this.onGetUserInfo,
    this.onContact,
    this.onGetPhoneNumber,
    this.onGetRealtimePhoneNumber,
    this.onError,
    this.onOpenSetting,
    this.onLaunchApp,
    this.onChooseAvatar,
    this.onAgreePrivacyAuthorization,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsMPFlutterDevmode) return child;
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: MPFlutterPlatformView(
            viewClazz: "MPFlutter_Wechat_Button",
            transparent: true,
            delayUpdate: true,
            viewProps: {
              "size": size,
              "type": type,
              "plain": plain,
              "disabled": disabled,
              "loading": loading,
              "formType": formType,
              "openType": openType,
              "hoverClass": hoverClass,
              "hoverStopPropagation": hoverStopPropagation,
              "hoverStartTime": hoverStartTime,
              "hoverStayTime": hoverStayTime,
              "lang": lang,
              "sessionFrom": sessionFrom,
              "sendMessageTitle": sendMessageTitle,
              "sendMessagePath": sendMessagePath,
              "sendMessageImg": sendMessageImg,
              "appParameter": appParameter,
              "showMessageCard": showMessageCard,
              "phoneNumberNoQuotaToast": phoneNumberNoQuotaToast,
            },
            eventCallback: (originEvent, detail) {
              final event = originEvent.toLowerCase();
              switch (event) {
                case "tap":
                  onTap?.call(detail);
                  break;
                case "getuserinfo":
                  onGetUserInfo?.call(detail);
                  break;
                case "contact":
                  onContact?.call(detail);
                  break;
                case "getphonenumber":
                  onGetPhoneNumber?.call(detail);
                  break;
                case "getrealtimephonenumber":
                  onGetRealtimePhoneNumber?.call(detail);
                  break;
                case "error":
                  onError?.call(detail);
                  break;
                case "opensetting":
                  onOpenSetting?.call(detail);
                  break;
                case "launchapp":
                  onLaunchApp?.call(detail);
                  break;
                case "chooseavatar":
                  onChooseAvatar?.call(detail);
                  break;
                case "agreeprivacyauthorization":
                  onAgreePrivacyAuthorization?.call(detail);
                  break;
                default:
                  break;
              }
            },
          ),
        ),
      ],
    );
  }
}
