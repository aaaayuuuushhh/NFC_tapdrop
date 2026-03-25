import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/connection_screen.dart';
import 'screens/trust_screen.dart';
import 'screens/exchange_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/profile_card_screen.dart';

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
        "/profile": (context) => const ProfileSetupScreen(),
        "/profile_card": (context) => const ProfileCardScreen(),
      },
    );
  }
}