import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';
import '../widgets/app_colors.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {

  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() {
    profile = ProfileService.getProfile(); // ✅ FIXED (no await)
    setState(() {});
  }

  // 🔥 OPEN URL
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  // 🔥 BUTTON BUILDER
  Widget buildButton(String title, IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () => openUrl(url),
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (profile == null) {
      return const Scaffold(
        body: Center(child: Text("No profile found")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Profile Card"),
        centerTitle: true,
      ),

      body: SingleChildScrollView( // ✅ FIX OVERFLOW
        padding: const EdgeInsets.all(25),

        child: Column(
          children: [

            // 🔹 NAME
            Text(
              profile!.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 INSTAGRAM
            if (profile!.instagram != null &&
                profile!.instagram!.isNotEmpty)
              buildButton(
                "Instagram",
                Icons.camera_alt,
                "https://instagram.com/${profile!.instagram}",
              ),

            // 🔹 LINKEDIN
            if (profile!.linkedin != null &&
                profile!.linkedin!.isNotEmpty)
              buildButton(
                "LinkedIn",
                Icons.work,
                "https://linkedin.com/in/${profile!.linkedin}",
              ),

            // 🔹 UPI
            if (profile!.upi != null &&
                profile!.upi!.isNotEmpty)
              buildButton(
                "UPI Pay",
                Icons.account_balance_wallet,
                "upi://pay?pa=${profile!.upi}&pn=${profile!.name}",
              ),

            // 🔹 EMAIL
            if (profile!.email != null &&
                profile!.email!.isNotEmpty)
              buildButton(
                "Email",
                Icons.email,
                "mailto:${profile!.email}",
              ),

            // 🔹 PHONE
            if (profile!.phone != null &&
                profile!.phone!.isNotEmpty)
              buildButton(
                "Call",
                Icons.phone,
                "tel:${profile!.phone}",
              ),
          ],
        ),
      ),
    );
  }
}