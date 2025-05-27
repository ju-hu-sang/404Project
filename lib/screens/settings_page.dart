import 'package:flutter/material.dart';
import 'package:pf/screens/login_page.dart'; // LoginPage import
import 'package:pf/screens/home_connected_page.dart'; // HomeConnectedPage import

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '설정',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) => const HomeConnectedPage(),
                transitionsBuilder: (_, animation, __, child) {
                  final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                  final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
                  final slideAnimation = Tween<Offset>(begin: const Offset(-0.1, 0.0), end: Offset.zero).animate(curved);

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
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        children: [
          _buildSectionTitle('연결'),
          _buildSection([
            _buildTile('네트워크', '제품을 연결할 Wi-Fi를 설정할 수 있어요.'),
          ]),
          _buildSectionTitle('알림'),
          _buildSection([
            _buildTile('알림 설정'),
          ]),
          _buildSectionTitle('홈 설정'),
          _buildSection([
            _buildTile('홈 설정'),
            const Divider(height: 0.5, thickness: 0.5, indent: 12, endIndent: 12),
            _buildTile('화면 테마', '시스템 기본 설정'),
          ]),
          _buildSectionTitle('제품 로그인'),
          _buildSection([
            ListTile(
              title: const Text(
                'ThinQ 계정 공유',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'LGSmartUI',
                  fontSize: 13,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  'LG ThinQ 앱 로그인한 사용자와 제품이 표시된 QR 코드를\n스캔하거나 각 코드로 등록하면 계정이 공유돼요.',
                  style: TextStyle(
                    fontFamily: 'LGSmartUI',
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
              trailing: const Icon(Icons.chevron_right, size: 18),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              minVerticalPadding: 0,
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                // 처리
              },
            ),
          ]),
          _buildSectionTitle('일반'),
          _buildSection([
            _buildTile('언어', '한국어'),
            _buildTile('약관 및 정책'),
            _buildTile('LG PetFeel 정보'),
          ]),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'LGSmartUI',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('안전하게 로그아웃 되었습니다', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                      duration: Duration(seconds: 1),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => const LoginPage(),
                        transitionsBuilder: (_, animation, __, child) {
                          final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
                          final slideAnimation = Tween<Offset>(begin: const Offset(0.0, -0.1), end: Offset.zero).animate(curved);

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
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                visualDensity: const VisualDensity(vertical: -4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(List<Widget> tiles) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: tiles),
    );
  }

  Widget _buildTile(String title, [String? subtitle]) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'LGSmartUI',
          fontWeight: FontWeight.w400,
          fontSize: 13.5,
        ),
      ),
      subtitle: subtitle != null
          ? Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w400,
          ),
        ),
      )
          : null,
      trailing: const Icon(Icons.chevron_right, size: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      minVerticalPadding: 0,
      visualDensity: const VisualDensity(vertical: -4),
      onTap: () {
        // 설정 항목 클릭 처리
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12.5,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontFamily: 'LGSmartUI',
        ),
      ),
    );
  }
}
