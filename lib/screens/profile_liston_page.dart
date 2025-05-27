import 'package:flutter/material.dart';
import 'package:pf/screens/profile_register_page.dart'; // ProfileRegisterPage import

class ProfileListOnPage extends StatelessWidget {
  const ProfileListOnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
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
        ),
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
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildProfileCard(
              imagePath: 'assets/dog1.png',
              name: '가나디',
              breed: '포메라니안',
              gender: '남',
              birth: '2022/04/01',
              age: '3세',
              weight: '3.5 kg',
            ),
            const SizedBox(height: 12),
            _buildProfileCard(
              imagePath: 'assets/dog2.png',
              name: '아리',
              breed: '푸들',
              gender: '여',
              birth: '2024/01/15',
              age: '1세',
              weight: '2.7 kg',
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

  Widget _buildProfileCard({
    required String imagePath,
    required String name,
    required String breed,
    required String gender,
    required String birth,
    required String age,
    required String weight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imagePath,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'LGSmartUI',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        gender == '남' ? '♂' : '♀',
                        style: TextStyle(
                          fontSize: 16,
                          color: gender == '남' ? Colors.blue : Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '종 : $breed',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'LGSmartUI',
                    ),
                  ),
                  Text(
                    '생년월일 : $birth ($age)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'LGSmartUI',
                    ),
                  ),
                  Text(
                    '몸무게 : $weight',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'LGSmartUI',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
