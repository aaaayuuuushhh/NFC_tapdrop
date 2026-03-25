import '../models/profile_model.dart';

class ProfileService {
  static ProfileModel? _currentProfile;

  /// Save profile
  static void saveProfile(ProfileModel profile) {
    _currentProfile = profile;
  }

  /// Get current profile
  static ProfileModel? getProfile() {
    return _currentProfile;
  }

  /// Check if profile exists
  static bool hasProfile() {
    return _currentProfile != null;
  }

  /// Clear profile (for logout / reset)
  static void clearProfile() {
    _currentProfile = null;
  }
}