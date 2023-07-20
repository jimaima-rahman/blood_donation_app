import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcdfafa),
      body: Center(
        child: Lottie.asset("assets/animation/animation_lkb1uu0d.json"),
      ),
    );
  }
}
