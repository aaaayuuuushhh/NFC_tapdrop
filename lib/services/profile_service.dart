import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileService {

  static Future<void> saveProfile(ProfileModel profile) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", profile.name);
    await prefs.setString("instagram", profile.instagram);
    await prefs.setString("linkedin", profile.linkedin);
    await prefs.setString("upi", profile.upi);
    await prefs.setString("email", profile.email);
    await prefs.setString("phone", profile.phone);

  }

  static Future<ProfileModel> getProfile() async {

    final prefs = await SharedPreferences.getInstance();

    return ProfileModel(
      name: prefs.getString("name") ?? "",
      instagram: prefs.getString("instagram") ?? "",
      linkedin: prefs.getString("linkedin") ?? "",
      upi: prefs.getString("upi") ?? "",
      email: prefs.getString("email") ?? "",
      phone: prefs.getString("phone") ?? "",
    );

  }

}