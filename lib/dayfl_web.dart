/*
 * @Author: your name
 * @Date: 2021-11-18 14:08:22
 * @LastEditTime: 2021-11-18 14:09:16
 * @LastEditors: your name
 * @Description: 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath: \dayfl\lib\dayfl_web.dart
 */
import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the Dayfl plugin.
class DayflWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'dayfl',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = DayflWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'dayfl for web doesn\'t implement \'${call.method}\'',
        );
    }
  }
}
