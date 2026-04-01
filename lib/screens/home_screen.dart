import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/profile_service.dart';
import '../services/nfc_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String message = "Tap to connect";

  // 🔥 START NFC USING SERVICE
  void startNFC() async {

    bool available = await NfcService.isNfcAvailable();

    if (!available) {
      setState(() {
        message = "NFC not available";
      });
      return;
    }

NfcService.startListening(
  (deviceId) {
    // Trusted device
    Navigator.pushNamed(context, "/exchange");
  },
  (deviceId) {
    // New device
    Navigator.pushNamed(
      context,
      "/connect",
      arguments: deviceId, // ✅ now defined
    );
  },
);
  }

  // 🔥 OPEN LINKS
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

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

            // 🔹 PROFILE SECTION
            profile == null

                // ❌ NO PROFILE
                ? GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(context, "/profile");
                      setState(() {}); // 🔥 refresh UI after return
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

                // ✅ PROFILE EXISTS
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
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🔹 INSTAGRAM
                        if (profile.instagram != null &&
                            profile.instagram!.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              openLink("https://instagram.com/${profile.instagram}");
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.camera_alt, size: 20),
                                const SizedBox(width: 10),
                                Text(profile.instagram!),
                              ],
                            ),
                          ),

                        const SizedBox(height: 10),

                        // 🔹 LINKEDIN
                        if (profile.linkedin != null &&
                            profile.linkedin!.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              openLink(profile.linkedin!);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.work, size: 20),
                                const SizedBox(width: 10),
                                Expanded(child: Text(profile.linkedin!)),
                              ],
                            ),
                          ),

                        const SizedBox(height: 10),

                        // 🔹 UPI
                        if (profile.upi != null &&
                            profile.upi!.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              openLink("upi://pay?pa=${profile.upi}&pn=TapDrop");
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.payment, size: 20),
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