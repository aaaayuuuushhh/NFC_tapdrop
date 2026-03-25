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

  void saveProfile() {
    final profile = ProfileModel(
      id: DateTime.now().toString(),
      name: nameController.text,
      instagram: instagramController.text,
      linkedin: linkedinController.text,
      email: emailController.text,
      phone: phoneController.text,
      upi: upiController.text,
    );

    ProfileService.saveProfile(profile);

    Navigator.pushReplacementNamed(context, "/"); // go back to home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setup Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: instagramController,
              decoration: const InputDecoration(labelText: "Instagram"),
            ),

            TextField(
              controller: linkedinController,
              decoration: const InputDecoration(labelText: "LinkedIn"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            TextField(
              controller: upiController,
              decoration: const InputDecoration(labelText: "UPI"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: saveProfile,
              child: const Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }
}