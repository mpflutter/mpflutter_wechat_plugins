import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

class MPFlutter_Wechat_Socket {
  static Future<MPFlutter_Wechat_Socket> connect(
    host,
    int port, {
    Duration? timeout,
  }) async {
    final impl = await Socket.connect(host, port, timeout: timeout);
    return MPFlutter_Wechat_Socket(impl);
  }

  Socket impl;
  Function? onError;
  Function? onDone;

  MPFlutter_Wechat_Socket(this.impl) {
    impl.listen((event) {
      streamCtl.add(event);
    })
      ..onDone(() {
        this.onDone?.call();
      })
      ..onError((_) {
        this.onError?.call();
      });
  }

  Future<void> write(dynamic data) async {
    impl.write(data);
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
    impl.destroy();
  }

  Future<void> close() async {
    impl.close();
  }
}
