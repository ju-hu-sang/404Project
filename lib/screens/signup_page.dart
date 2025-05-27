import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500), // 500ms
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, animation, __, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          final fadeAnimation = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(curvedAnimation);
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, -0.1), // 위에서 아래로 (Slide Down)
            end: Offset.zero,
          ).animate(curvedAnimation);

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
  }

  void _showSnackBar(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 이전 페이지로 돌아가기
          },
        ),
        title: const Text('회원가입'),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
              child: Column(
                children: [
                  _buildInputField(
                    icon: Icons.person,
                    label: '이름',
                    hint: '이름을 입력하세요',
                    controller: _nameController,
                    inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[ㄱ-ㅎ가-힣0-9]')),
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    icon: Icons.email,
                    label: '이메일',
                    hint: '이메일을 입력하세요',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    icon: Icons.vpn_key,
                    label: '비밀번호',
                    hint: '비밀번호를 입력하세요',
                    controller: _passwordController,
                    obscureText: true,
                    inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._!#\$%&*\-]')),
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    icon: Icons.verified_user,
                    label: '비밀번호 확인',
                    hint: '비밀번호를 입력하세요',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._!#\$%&*\-]')),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  final confirmPassword = _confirmPasswordController.text.trim();

                  if (password != confirmPassword) {
                    _showSnackBar('비밀번호가 일치하지 않습니다');
                    return;
                  }

                  final url = Uri.parse('http://10.0.2.2:8000/auth/signup');
                  final headers = {'Content-Type': 'application/json'};
                  final body = jsonEncode({
                    'username': name,
                    'email': email,
                    'password': password,
                  });

                  try {
                    final response = await http.post(url, headers: headers, body: body);
                    if (response.statusCode == 201) {
                      _showSnackBar('회원가입 성공', success: true);
                      _navigateToLoginPage(context);
                    } else {
                      String errorMessage = '유효한 이메일 형식을 입력해주세요.';
                      try {
                        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
                        if (decoded is Map && decoded['detail'] is String) {
                          errorMessage = decoded['detail'];
                        }
                      } catch (_) {}
                      _showSnackBar(errorMessage);
                    }
                  } catch (e) {
                    _showSnackBar('에러 발생: $e');
                  }
                },
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputFormatter? inputFormatter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter != null ? [inputFormatter] : [],
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}