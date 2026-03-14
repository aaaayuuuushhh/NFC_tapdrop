import 'package:flutter/material.dart';
import 'screens/connection_screen.dart';
import 'screens/home_screen.dart';
import 'screens/trust_screen.dart';
import 'screens/exchange_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(const TapDropApp());
}

class TapDropApp extends StatelessWidget {
  const TapDropApp({super.key});

  @override
  Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,

  routes: {
  "/": (context) => const HomeScreen(),
  "/connect": (context) => const ConnectionScreen(),
  "/trust": (context) => const TrustScreen(),
  "/exchange": (context) => const ExchangeScreen(),
},
);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String message = "Tap phones to connect";

  Future<void> startNFC() async {

    bool available = await NfcManager.instance.isAvailable();

    if (!available) {
      setState(() {
        message = "NFC is not available on this device";
      });
      return;
    }

   NfcManager.instance.startSession(
  pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
  onDiscovered: (NfcTag tag) async {

  await NfcManager.instance.stopSession();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ConnectionScreen(),
    ),
  );

});

  }

  @override
  void initState() {
    super.initState();
    startNFC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TapDrop"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}