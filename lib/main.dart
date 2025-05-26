import 'package:flutter/material.dart';
import 'package:pf/screens/profile_register_page.dart';
import 'package:pf/screens/profile_list_page.dart';
import 'package:pf/screens/profile_edit_page.dart';
import 'package:pf/screens/login_page.dart';
import 'package:pf/screens/signup_page.dart';
import 'package:pf/screens/camera_connect_page.dart';
import 'package:pf/screens/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '프로필 등록',
      theme: ThemeData(
        fontFamily: 'LGSmartUI',
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}
