import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {

  final nameController = TextEditingController();
  final instagramController = TextEditingController();
  final linkedinController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final upiController = TextEditingController();

  // 🔥 SAVE PROFILE
  Future<void> saveProfile() async {

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name is required")),
      );
      return;
    }

    final profile = ProfileModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      instagram: instagramController.text.trim(),
      linkedin: linkedinController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      upi: upiController.text.trim(),
    );

    await ProfileService.saveProfile(profile);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  void dispose() {
    nameController.dispose();
    instagramController.dispose();
    linkedinController.dispose();
    emailController.dispose();
    phoneController.dispose();
    upiController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setup Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            buildTextField("Name", nameController),
            buildTextField("Instagram", instagramController),
            buildTextField("LinkedIn", linkedinController),
            buildTextField("Email", emailController),
            buildTextField("Phone", phoneController),
            buildTextField("UPI", upiController),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Save Profile",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}