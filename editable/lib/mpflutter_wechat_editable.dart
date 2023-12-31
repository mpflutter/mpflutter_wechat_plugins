import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
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

  static bool shouldUseWechatComponent() {
    return !(runOnDevtools || kIsMPFlutterDevmode || !kIsMPFlutter);
  }

  final TextEditingController? controller;
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
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  MPFlutter_Wechat_EditableInput({
    Key? key,
    this.controller,
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
          "defaultText": controller.text,
          "hintText": widget.hintText,
          "obscureText": widget.obscureText,
          "cursorColor": _colorToHex(widget.cursorColor, "#000000"),
          "fontSize": fontSize,
          "textColor": _colorToHex(widget.style?.color, "#000000"),
          "textAlign": widget.textAlign.name,
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
        },
        eventCallback: (originEvent, detail) {
          final event = originEvent.toLowerCase();
          switch (event) {
            case "input":
              final value = detail["value"];
              this.controller.text = value;
              widget.onChanged?.call(value);
              break;
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
              this.controller.text = value;
              widget.onSubmitted?.call(value);
              break;
            default:
              break;
          }
        },
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
