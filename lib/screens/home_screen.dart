import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../services/profile_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String message = "Tap to connect";

  // ✅ NFC FUNCTION
  Future<void> startNFC() async {
    final available = await NfcManager.instance.isAvailable();

    if (!available) {
      setState(() {
        message = "NFC not available";
      });
      return;
    }

    NfcManager.instance.startSession(
      pollingOptions: {
        NfcPollingOption.iso14443,
        NfcPollingOption.iso15693,
      },
      onDiscovered: (tag) async {
        await NfcManager.instance.stopSession();

        if (!mounted) return;

        Navigator.pushNamed(context, "/connect");
      },
    );
  }

  // ✅ ADD THIS FUNCTION HERE
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print("Could not launch $url");
    }
  }

  // ✅ BUILD METHOD
  @override
  Widget build(BuildContext context) {

    final profile = ProfileService.getProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text("TapDrop"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔹 NFC SECTION
            GestureDetector(
              onTap: startNFC,
              child: Column(
                children: [
                  const Icon(Icons.nfc, size: 100),
                  const SizedBox(height: 10),
                  const Text(
                    "Tap to Connect",
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // 🔹 PROFILE / ADD CARD SECTION
            profile == null

                // ❌ NO PROFILE → SHOW ADD CARD
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.greenAccent,
                      ),
                      child: Column(
                        children: const [
                          Icon(Icons.add, size: 40),
                          SizedBox(height: 10),
                          Text(
                            "Add Card",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  )

                // ✅ PROFILE EXISTS → SHOW CARD
                : Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 15,
          offset: const Offset(0, 5),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 🔹 NAME
        Center(
          child: Text(
            profile.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 🔹 INSTAGRAM
        if (profile.instagram != null && profile.instagram!.isNotEmpty)
          GestureDetector(
            onTap: () {
              openLink("https://instagram.com/${profile.instagram}");
            },
            child: Row(
              children: [
                const Icon(Icons.camera_alt, size: 20, color: Colors.black54),
                const SizedBox(width: 10),
                Text(profile.instagram!),
              ],
            ),
          ),

        const SizedBox(height: 10),

        // 🔹 LINKEDIN
        if (profile.linkedin != null && profile.linkedin!.isNotEmpty)
          GestureDetector(
            onTap: () {
              openLink(profile.linkedin!);
            },
            child: Row(
              children: [
                const Icon(Icons.work, size: 20, color: Colors.black54),
                const SizedBox(width: 10),
                Expanded(child: Text(profile.linkedin!)),
              ],
            ),
          ),

        const SizedBox(height: 10),

        // 🔹 UPI
        if (profile.upi != null && profile.upi!.isNotEmpty)
          GestureDetector(
            onTap: () {
              openLink("upi://pay?pa=${profile.upi}&pn=TapDrop");
            },
            child: Row(
              children: [
                const Icon(Icons.payment, size: 20, color: Colors.black54),
                const SizedBox(width: 10),
                Text(profile.upi!),
              ],
            ),
          ),
      ],
    ),
  ),
          ],
        ),
      ),
    );
  }
}