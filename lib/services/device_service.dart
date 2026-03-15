import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {

  static Future<String> getDeviceName() async {

    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? "Android Device";
    }

    return "TapDrop Device";
  }

}