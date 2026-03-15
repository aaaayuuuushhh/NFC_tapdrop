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

  void loadProfile() async {
    profile = await ProfileService.getProfile();
    setState(() {});
  }

  Future openUrl(String url) async {

    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget buildButton(String title, IconData icon, String url) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        onPressed: () {
          openUrl(url);
        },

        icon: Icon(icon),
        label: Text(title),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      backgroundColor: AppColors.background,

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              profile!.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            buildButton(
              "Instagram",
              Icons.camera_alt,
              "https://instagram.com/${profile!.instagram}",
            ),

            buildButton(
              "LinkedIn",
              Icons.work,
              "https://linkedin.com/in/${profile!.linkedin}",
            ),

            buildButton(
              "UPI Pay",
              Icons.account_balance_wallet,
              "upi://pay?pa=${profile!.upi}",
            ),

            buildButton(
              "Email",
              Icons.email,
              "mailto:${profile!.email}",
            ),

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