import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  Widget buildCard(String title, IconData icon) {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {

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

            buildCard("Photos", Icons.photo),
            buildCard("Files", Icons.folder),
            buildCard("Profiles", Icons.person),
            buildCard("Payment", Icons.payments),

          ],
        ),
      ),
    );
  }
}