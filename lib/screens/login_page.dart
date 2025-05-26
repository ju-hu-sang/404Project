import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'camera_connect_page.dart'; // 로그인 성공 시 이동할 페이지

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          '로그인',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 64, 24, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputField(Icons.email, '이메일', '이메일을 입력하세요', _emailController),
                const SizedBox(height: 24),
                _buildInputField(Icons.vpn_key, '비밀번호', '비밀번호를 입력하세요', _passwordController, obscureText: true),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton(
                  'LG 계정으로 로그인',
                  onPressed: () {},
                  color: const Color(0xFFa50034),
                  withLGIcon: true,
                ),
                const SizedBox(height: 12),
                _buildButton(
                  '로그인',
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();

                    final url = Uri.parse('http://10.0.2.2:8000/auth/login');
                    final headers = {'Content-Type': 'application/json'};
                    final body = jsonEncode({'email': email, 'password': password});

                    try {
                      final response = await http.post(url, headers: headers, body: body);
                      if (response.statusCode == 200) {
                        final data = jsonDecode(response.body);
                        final token = data['access_token'];

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              '로그인 성공',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            duration: const Duration(milliseconds: 700),
                          ),
                        );

                        await Future.delayed(const Duration(milliseconds: 700));

                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => const CameraConnectPage(),
                            transitionsBuilder: (_, animation, __, child) {
                              final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
                              final fadeAnimation = Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(curved);
                              final slideAnimation = Tween<Offset>(
                                begin: const Offset(1.0, 0.0), // 오른쪽에서 시작
                                end: Offset.zero,
                              ).animate(curved);

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
                      } else {
                        String errorMessage = '로그인에 실패했습니다. 이메일 또는 비밀번호를 확인해주세요.';
                        try {
                          final decoded = jsonDecode(utf8.decode(response.bodyBytes));
                          if (decoded is Map && decoded['detail'] is String) {
                            errorMessage = decoded['detail'];
                          }
                        } catch (_) {}

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage, style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('에러 발생: $e', style: const TextStyle(color: Colors.white)),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                _buildOutlineButton('회원가입', onPressed: () {
                  // 회원가입 페이지 연결 가능
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      IconData icon,
      String label,
      String hint,
      TextEditingController controller, {
        bool obscureText = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'LGSmartUI',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: 'LGSmartUI',
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          style: const TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
      String text, {
        required VoidCallback onPressed,
        Color color = Colors.black,
        bool withLGIcon = false,
      }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: onPressed,
        child: withLGIcon
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/lg_icon.png', height: 20, width: 20),
            const SizedBox(width: 8),
            const Text(
              'LG 계정으로 로그인',
              style: TextStyle(
                fontFamily: 'LGSmartUI',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        )
            : Text(
          text,
          style: const TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}