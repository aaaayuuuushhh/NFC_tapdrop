import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen>
    with TickerProviderStateMixin {

  late AnimationController rippleController;
  late AnimationController circleController;

  late Animation<double> ripple;
  late Animation<double> leftMove;
  late Animation<double> rightMove;

  bool connected = false;
  String deviceId = "unknown";

  @override
  void initState() {
    super.initState();

    // 🔥 GET DEVICE ID FROM NFC (IMPORTANT)
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        deviceId = args;
      }
    });

    rippleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    circleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    ripple = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(parent: rippleController, curve: Curves.easeOut),
    );

    leftMove = Tween<double>(begin: -120, end: -10).animate(
      CurvedAnimation(parent: circleController, curve: Curves.easeInOut),
    );

    rightMove = Tween<double>(begin: 120, end: 10).animate(
      CurvedAnimation(parent: circleController, curve: Curves.easeInOut),
    );

    startAnimation();
  }

  void startAnimation() async {

    rippleController.repeat();

    await Future.delayed(const Duration(seconds: 1));

    circleController.forward();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      connected = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 🔥 PASS DEVICE ID FOR TRUST SYSTEM
    Navigator.pushReplacementNamed(
      context,
      "/trust",
      arguments: deviceId,
    );
  }

  @override
  void dispose() {
    rippleController.dispose();
    circleController.dispose();
    super.dispose();
  }

  Widget buildCircle() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.7),
            blurRadius: 30,
            spreadRadius: 10,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: connected

            // ✅ SHOW CONNECTED DEVICE
            ? Text(
                "Connected to device",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              )

            // 🔥 ANIMATION
            : Stack(
                alignment: Alignment.center,
                children: [

                  AnimatedBuilder(
                    animation: ripple,
                    builder: (context, child) {
                      return Container(
                        width: ripple.value,
                        height: ripple.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondary.withOpacity(0.4),
                            width: 4,
                          ),
                        ),
                      );
                    },
                  ),

                  AnimatedBuilder(
                    animation: leftMove,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(leftMove.value, 0),
                        child: buildCircle(),
                      );
                    },
                  ),

                  AnimatedBuilder(
                    animation: rightMove,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(rightMove.value, 0),
                        child: buildCircle(),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}