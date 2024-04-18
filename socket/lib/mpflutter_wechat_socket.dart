import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_Socket {
  static Future<MPFlutter_Wechat_Socket> connect(
    host,
    int port, {
    Duration? timeout,
  }) async {
    final impl = mpjs.JSObject("MPFlutter_Wechat_Socket");
    await impl.callMethodAwaitPromise(
      "connect",
      [host, port, timeout?.inSeconds ?? 2],
    );
    return MPFlutter_Wechat_Socket(impl);
  }

  mpjs.JSObject impl;
  Function? onError;
  Function? onDone;

  MPFlutter_Wechat_Socket(this.impl) {
    this.impl.callMethod("listen", [
      (dynamic data) {
        final uint8List = mpjs.context.convertArrayBufferToUint8List(data);
        streamCtl.add(uint8List);
      }
    ]);
    this.impl.callMethod("listenClose", [
      () {
        this.onDone?.call();
      }
    ]);
    this.impl.callMethod("listenError", [
      (errMsg) {
        this.onError?.call();
      }
    ]);
  }

  Future<void> write(dynamic data) async {
    if (data is String) {
      impl.callMethod("write", [data]);
    } else if (data is Uint8List) {
      impl.callMethod(
          "write", [mpjs.context.newArrayBufferFromUint8List(data)]);
    }
  }

  final streamCtl = StreamController<Uint8List>();

  StreamSubscription<Uint8List> listen(
    void onData(Uint8List event)?, {
    Function? onError,
    void onDone()?,
    bool? cancelOnError,
  }) {
    this.onError = onError;
    this.onDone = onDone;
    return streamCtl.stream.listen((event) {
      onData?.call(event);
    });
  }

  Future<void> destroy() async {
    impl.callMethod("destroy");
  }

  Future<void> close() async {
    impl.callMethod("close");
  }
}
