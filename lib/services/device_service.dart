import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device_model.dart';

class DeviceService {
  static const String deviceIdKey = "device_id";

  static DeviceModel? _connectedDevice;

  // 🔥 Get current device name
  static Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? "Android Device";
    }

    return "TapDrop Device";
  }

  // 🔥 Generate random device ID
  static String generateDeviceId() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random rand = Random();

    return List.generate(
      6,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  // 🔥 Get or create device ID
  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(deviceIdKey);

    if (id == null) {
      id = generateDeviceId();
      await prefs.setString(deviceIdKey, id);
    }

    return id;
  }

  // ===========================
  // 🔥 CONNECTION LOGIC
  // ===========================

  // Set connected device
  static void setConnectedDevice(DeviceModel device) {
    _connectedDevice = device;
  }

  // Get connected device
  static DeviceModel? getConnectedDevice() {
    return _connectedDevice;
  }

  // Get connected device name
  static String getConnectedDeviceName() {
    return _connectedDevice?.deviceName ?? "Unknown Device";
  }

  // Check if connected
  static bool hasConnectedDevice() {
    return _connectedDevice != null;
  }

  // Clear after session
  static void clearConnectedDevice() {
    _connectedDevice = null;
  }
}