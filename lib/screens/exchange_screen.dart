import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import '../services/profile_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  // 🔥 OPEN URL (for payment etc.)
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  Widget buildCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withOpacity(0.6),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                icon,
                size: 40,
                color: Colors.black,
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final profile = ProfileService.getProfile();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Share With Device"),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,

          children: [

            // 📸 PHOTOS (future)
            buildCard(
              context,
              "Photos",
              Icons.photo,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Coming Soon 🚀")),
                );
              },
            ),

            // 📁 FILES (future)
            buildCard(
              context,
              "Files",
              Icons.folder,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Coming Soon 🚀")),
                );
              },
            ),

            // 👤 PROFILE CARD
            buildCard(
              context,
              "Profiles",
              Icons.person,
              () {
                Navigator.pushNamed(context, "/profile_card");
              },
            ),

            // 💸 PAYMENT
            buildCard(
              context,
              "Payment",
              Icons.payments,
              () {
                if (profile != null &&
                    profile.upi != null &&
                    profile.upi!.isNotEmpty) {

                  openUrl("upi://pay?pa=${profile.upi}&pn=${profile.name}");

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No UPI ID found")),
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}