import 'package:flutter/material.dart';
import 'package:yt_download_manager/pages/homepage/view/home_page.dart';
import 'package:yt_download_manager/utils/assets_path.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()), // replace with your screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage(AssetPath.appLogo),
          fit: BoxFit.contain,
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
