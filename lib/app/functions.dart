import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:test_app/domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  DeviceInfo _deviceInfo = DeviceInfo("Unknown", "Unknown", "Unknown");
  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var info = await _deviceInfoPlugin.androidInfo;
      _deviceInfo.name = info.board + " " + info.model;
      _deviceInfo.identifire = info.androidId;
      _deviceInfo.version = info.version.toString();
    }
    if (Platform.isIOS) {
      var info = await _deviceInfoPlugin.iosInfo;
      _deviceInfo.name = info.name + " " + info.model;
      _deviceInfo.identifire = info.identifierForVendor;
      _deviceInfo.version = info.systemVersion;
    }
  } on PlatformException {
    return _deviceInfo;
  }
  return _deviceInfo;
}
