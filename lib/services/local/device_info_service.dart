import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  String? _deviceId;

  String? get deviceId => _deviceId;

  Future<void> fetchDeviceId(BuildContext context) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceId = androidInfo.id; // * Get Android device ID
        if (_deviceId != null) {
          sharedPrefsService.setString(SharedPrefsKeys.deviceId, _deviceId!);
        }
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceId = iosInfo.identifierForVendor; // * Get iOS device ID
        if (_deviceId != null) {
          sharedPrefsService.setString(SharedPrefsKeys.deviceId, _deviceId!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching device ID: $e');
      _deviceId = 'Error fetching device ID';
    }
  }
}
