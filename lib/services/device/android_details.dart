import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class AndroidDetails {
  static final AndroidDetails _instance = AndroidDetails._internal();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = {};
  bool isInitialized = false;

  factory AndroidDetails() => _instance;

  AndroidDetails._internal() {
    _init();
  }

  _init() async {
    try {
      AndroidDeviceInfo _deviceInfo = await deviceInfoPlugin.androidInfo;
      _deviceData = _getDeviceData(_deviceInfo);
      isInitialized = true;
    } on PlatformException {
      _deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.',
      };
    }
  }

  Map<String, dynamic> _getDeviceData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.sdkInt': build.version.sdkInt,
    };
  }

  // is above android 7
  bool isAboveNougat() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] > 24;
    }
    return null;
  }

  // has exactly android 7
  bool hasNougat() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] == 24;
    }
    return null;
  }

  // android 5
  bool atleastHasLollipop() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] >= 21;
    }
    return null;
  }

  bool canChangeNavbarIconColor() {
    if (_deviceData.isNotEmpty) {
      return _deviceData['version.sdkInt'] >= 27;
    }
    return null;
  }
}
