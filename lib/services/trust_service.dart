import 'package:shared_preferences/shared_preferences.dart';

class TrustService {

  static const String trustedDevicesKey = "trusted_devices";

  static Future<void> trustDevice(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> devices = prefs.getStringList(trustedDevicesKey) ?? [];

    if (!devices.contains(deviceId)) {
      devices.add(deviceId);
    }

    await prefs.setStringList(trustedDevicesKey, devices);
  }

  static Future<bool> isTrusted(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> devices = prefs.getStringList(trustedDevicesKey) ?? [];

    return devices.contains(deviceId);
  }

}