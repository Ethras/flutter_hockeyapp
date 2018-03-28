import 'dart:async';

import 'package:flutter/services.dart';

class FlutterHockeyapp {
  static const MethodChannel _channel =
      const MethodChannel('flutter_hockeyapp');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> start() async {
    final bool res = await _channel.invokeMethod('start');
    return res;
  }

  static Future<bool> configure(String token) async {
    final bool res = await _channel.invokeMethod('configure', {"token": token});
    return res;
  }

  static Future<bool> checkForUpdates() async {
    final bool res = await _channel.invokeMethod("checkForUpdates");
    return res;
  }

  static Future<bool> showFeedback() async {
    final bool res = await _channel.invokeMethod('showFeedback');
    return res;
  }

  static Future<bool> trackEvent(String eventName) async {
    final bool res =
        await _channel.invokeMethod("trackEvent", {"eventName": eventName});
    return res;
  }
}
