import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'connection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    startNFC();
  }

  void startNFC() async {

    bool isAvailable = await NfcManager.instance.isAvailable();

    if (!isAvailable) {
      print("NFC not available");
      return;
    }

    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {

        await NfcManager.instance.stopSession();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ConnectionScreen(),
          ),
        );

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF6FFF6),
      body: const Center(
        child: Text(
          "Tap phones to connect",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}