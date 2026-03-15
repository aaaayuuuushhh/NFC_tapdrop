import 'package:flutter/material.dart';
import '../services/nfc_service.dart';
import '../widgets/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("TapDrop"),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.nfc,
              size: 120,
            ),

            const SizedBox(height: 20),

            const Text(
              "Tap phones to share",
              style: TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {

                NfcService.startListening(

                  // Trusted device
                  () {
                    Navigator.pushNamed(context, "/exchange");
                  },

                  // New device
                  () {
                    Navigator.pushNamed(context, "/trust");
                  },

                );

              },

              child: const Text(
                "Tap to Connect",
                style: TextStyle(fontSize: 18),
              ),
            ),

          ],
        ),
      ),
    );
  }
}