import 'package:flutter/material.dart';
import 'login_page.dart'; // 로그인 페이지 임포트

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // 3초 후 페이지 전환
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500), // Duration 500ms
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut), // Ease In Out
            );
            final slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut), // Ease In Out
            );
            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/start.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'LG  PetFeel',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'LGSmartUI',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}