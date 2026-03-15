import 'dart:math';
import 'dart:convert';

class DeviceService {

  static String deviceId = generateDeviceId();

  static String generateDeviceId() {
    final random = Random();
    return List.generate(6, (_) => random.nextInt(9)).join();
  }

  static String getDeviceName() {
    return "TapDrop Device";
  }

  static String createHandshake() {

    return jsonEncode({
      "deviceId": deviceId,
      "deviceName": getDeviceName()
    });

  }
}