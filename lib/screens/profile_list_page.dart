import 'package:flutter/material.dart';
import 'package:pf/screens/profile_register_page.dart'; // ProfileRegisterPage import 추가

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 반려동물',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/paw_placeholder.png',
                      width: 180, // 크기 확대
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '등록된 반려동물이 없습니다',
                    style: TextStyle(
                      fontFamily: 'LGSmartUI',
                      fontSize: 15,
                      color: Color(0xFF7D7D7D),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => const ProfileRegisterPage(),
                        transitionsBuilder: (_, animation, __, child) {
                          final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
                          final scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(curved);

                          return FadeTransition(
                            opacity: fadeAnimation,
                            child: ScaleTransition(
                              scale: scaleAnimation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(
                    '프로필 추가',
                    style: TextStyle(fontFamily: 'LGSmartUI'),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}