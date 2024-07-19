import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart' as wechat_api;
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;
export './mpflutter_text_field.dart';
export './mpflutter_text_form_field.dart';

class MPFlutter_Wechat_EditableInput extends StatefulWidget {
  static final bool runOnDevtools = (() {
    try {
      return mpjs.context["platformViewManager"]['devtools'];
    } catch (e) {
      return false;
    }
  })();

  static final bool runOnAndroid = (() {
    try {
      return wechat_api.wx.getSystemInfoSync().platform == "android";
    } catch (e) {
      return false;
    }
  })();

  static bool shouldUseWechatComponent() {
    if (!kIsMPFlutter) return false;
    if (runOnDevtools) {
      return false;
    } else if (kIsMPFlutterDevmode) {
      return false;
    } else {
      if (runOnAndroid) {
        return false;
      }
      return true;
    }
  }

  final TextEditingController? controller;
  final bool forceShowHintText;
  final String? hintText;
  final FocusNode? focusNode;
  final TextStyle? style;
  final Color? cursorColor;
  final Color? backgroundCursorColor;
  final bool obscureText;
  final TextAlign textAlign;
  final bool autofocus;
  final bool? keyboardTypeIDCard;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final bool disabled;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  MPFlutter_Wechat_EditableInput({
    Key? key,
    this.controller,
    this.forceShowHintText = false,
    this.hintText,
    this.focusNode,
    this.style,
    this.cursorColor,
    this.backgroundCursorColor,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.autofocus = false,
    this.keyboardTypeIDCard,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
    this.maxLength,
    this.disabled = false,
    this.inputFormatters = const [],
    this.onFocus,
    this.onBlur,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<MPFlutter_Wechat_EditableInput> createState() =>
      _MPFlutter_Wechat_EditableInputState();
}

class _MPFlutter_Wechat_EditableInputState
    extends State<MPFlutter_Wechat_EditableInput> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focused = widget.autofocus;
    controller = widget.controller ?? TextEditingController(text: "");
    focusNode = widget.focusNode ?? FocusNode();
    if (!MPFlutter_Wechat_EditableInput.shouldUseWechatComponent()) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          widget.onFocus?.call();
        } else {
          widget.onBlur?.call();
        }
      });
    } else {
      controller.addListener(() {
        setState(() {});
      });
      focusNode.addListener(() {
        if (focusNode.hasFocus && !_focused) {
          setState(() {
            _focused = true;
          });
        } else {
          setState(() {
            _focused = false;
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant MPFlutter_Wechat_EditableInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller = widget.controller ?? TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    if (!MPFlutter_Wechat_EditableInput.shouldUseWechatComponent()) {
      return Align(
        alignment: Alignment.centerLeft,
        child: EditableText(
          key: widget.key,
          controller: controller,
          focusNode: focusNode,
          style: widget.style ?? TextStyle(),
          cursorColor: widget.cursorColor ?? Colors.black,
          backgroundCursorColor: widget.backgroundCursorColor ?? Colors.black,
          obscureText: widget.obscureText,
          textAlign: widget.textAlign,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
        ),
      );
    }
    final fontSize = widget.style?.fontSize ?? 12;
    final maxLines = widget.maxLines ?? 1;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: (fontSize * 1.25) * min(10, maxLines),
      ),
      child: MPFlutterPlatformView(
        viewClazz: "MPFlutter_Wechat_EditableInput",
        viewProps: {
          "textarea": maxLines > 1,
          "maxLength": widget.maxLength ?? -1,
          "defaultText": controller.text,
          "hintText": widget.forceShowHintText
              ? widget.hintText
              : (focusNode.hasFocus ? widget.hintText : ""),
          "obscureText": widget.obscureText,
          "cursorColor": _colorToHex(widget.cursorColor, "#000000"),
          "fontSize": fontSize,
          "textColor": _colorToHex(widget.style?.color, "#000000"),
          "textAlign": (() {
            final name = widget.textAlign.name;
            final textDirection = Directionality.of(context);
            if (name == "end") {
              if (textDirection == TextDirection.ltr)
                return "right";
              else
                return "left";
            } else if (name == "start") {
              if (textDirection == TextDirection.ltr)
                return "left";
              else
                return "right";
            }
            return name;
          })(),
          "autofocus": _focused,
          "keyboardType": (() {
            if (widget.keyboardTypeIDCard == true) {
              return "idcard";
            }
            final keyboardType = widget.keyboardType;
            if (keyboardType == null) return "text";
            if (keyboardType == TextInputType.number) {
              if (keyboardType.decimal == true) {
                return "digit";
              }
              return "number";
            }
            if (keyboardType == TextInputType.phone) {
              return "number";
            }
            if (keyboardType == TextInputType.name) {
              return "nickname";
            }
            return "text";
          })(),
          "textInputAction": widget.textInputAction?.name ?? "done",
          "disabled": widget.disabled,
        },
        eventCallback: (originEvent, detail) {
          final event = originEvent.toLowerCase();
          switch (event) {
            case "input":
              final value = detail["value"];
              final oldValue = TextEditingValue(text: this.controller.text);
              var newValue = TextEditingValue(text: value);
              widget.inputFormatters.forEach((element) {
                newValue = element.formatEditUpdate(oldValue, newValue);
              });
              if (newValue.text != oldValue.text) {
                this.controller.text = newValue.text;
                widget.onChanged?.call(newValue.text);
              }
              return newValue.text;
            case "focus":
              _focused = true;
              widget.onFocus?.call();
              if (widget.maxLines != null && widget.maxLines! > 1) {
                mpjs.context["FlutterHostView"]['shared']['textareaHasFocus'] =
                    true;
              }
              break;
            case "blur":
              setState(() {
                _focused = false;
              });
              widget.onBlur?.call();
              widget.onEditingComplete?.call();
              focusNode.unfocus();
              if (widget.maxLines != null && widget.maxLines! > 1) {
                mpjs.context["FlutterHostView"]['shared']['textareaHasFocus'] =
                    false;
              }
              break;
            case "confirm":
              final value = detail["value"];
              final oldValue = TextEditingValue(text: this.controller.text);
              var newValue = TextEditingValue(text: value);
              widget.inputFormatters.forEach((element) {
                newValue = element.formatEditUpdate(oldValue, newValue);
              });
              if (newValue.text != oldValue.text) {
                this.controller.text = newValue.text;
              }
              widget.onSubmitted?.call(newValue.text);
              break;
            default:
              break;
          }
        },
        placeholder: IgnorePointer(
          ignoring: true,
          child: Transform.translate(
            offset: Offset(
              (widget.maxLines ?? 1) > 1 ? 4 : 0,
              (widget.maxLines ?? 1) > 1 ? 4 : -1,
            ),
            child: EditableText(
              controller: controller,
              focusNode: FocusNode(),
              style: widget.style ?? TextStyle(),
              cursorColor: Colors.transparent,
              backgroundCursorColor:
                  widget.backgroundCursorColor ?? Colors.black,
              obscureText: widget.obscureText,
              textAlign: widget.textAlign,
              autofocus: false,
              maxLines: widget.maxLines,
            ),
          ),
        ),
      ),
    );
  }
}

String _colorToHex(Color? color, String defaultValue) {
  if (color == null) {
    return defaultValue;
  }
  return '#${color.value.toRadixString(16).padLeft(6, '0').substring(2)}';
}
