import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {

  final nameController = TextEditingController();
  final instaController = TextEditingController();
  final linkedinController = TextEditingController();
  final upiController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void saveProfile() async {

    ProfileModel profile = ProfileModel(
      name: nameController.text,
      instagram: instaController.text,
      linkedin: linkedinController.text,
      upi: upiController.text,
      email: emailController.text,
      phone: phoneController.text,
    );

    await ProfileService.saveProfile(profile);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Saved")),
    );

    Navigator.pop(context);
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Setup Profile"),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            buildField("Name", nameController),

            buildField("Instagram", instaController),

            buildField("LinkedIn", linkedinController),

            buildField("UPI ID", upiController),

            buildField("Email", emailController),

            buildField("Phone", phoneController),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: saveProfile,
              child: const Text(
                "Save Profile",
                style: TextStyle(fontSize: 18),
              ),
            )

          ],
        ),
      ),
    );
  }
}