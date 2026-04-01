import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileService {
  static const String _key = "user_profile";

  static ProfileModel? _currentProfile;

  // 🔥 Load profile when app starts
  static Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data != null) {
      final jsonData = jsonDecode(data);
      _currentProfile = ProfileModel.fromJson(jsonData);
    }
  }

  // 🔥 Save profile permanently
  static Future<void> saveProfile(ProfileModel profile) async {
    final prefs = await SharedPreferences.getInstance();

    _currentProfile = profile;

    await prefs.setString(_key, jsonEncode(profile.toJson()));
  }

  // 🔥 Get profile anytime
  static ProfileModel? getProfile() {
    return _currentProfile;
  }

  // 🔥 Check if profile exists
  static bool hasProfile() {
    return _currentProfile != null;
  }

  // 🔥 Delete profile manually
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();

    _currentProfile = null;

    await prefs.remove(_key);
  }
}