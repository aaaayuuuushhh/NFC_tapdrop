import 'package:flutter/material.dart';

void main() {
  runApp(const TapDropApp());
}

class TapDropApp extends StatelessWidget {
  const TapDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapDrop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TapDrop"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Tap phones to connect",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}