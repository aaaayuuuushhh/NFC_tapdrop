import 'package:shared_preferences/shared_preferences.dart';

class TrustService {
  static const String _key = "trusted_devices";

  // 🔥 Trust a device
  static Future<void> trustDevice(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    final devices = prefs.getStringList(_key) ?? [];

    if (!devices.contains(deviceId)) {
      devices.add(deviceId);
      await prefs.setStringList(_key, devices);
    }
  }

  // 🔥 Check if trusted
  static Future<bool> isTrusted(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    final devices = prefs.getStringList(_key) ?? [];

    return devices.contains(deviceId);
  }

  // 🔥 Get all trusted devices
  static Future<List<String>> getTrustedDevices() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_key) ?? [];
  }

  // 🔥 Remove a trusted device
  static Future<void> removeTrustedDevice(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    final devices = prefs.getStringList(_key) ?? [];

    devices.remove(deviceId);

    await prefs.setStringList(_key, devices);
  }

  // 🔥 Clear all trusted devices (reset)
  static Future<void> clearAllTrustedDevices() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}