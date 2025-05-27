import 'package:flutter/material.dart';
import 'package:pf/screens/alarm_page.dart';
import 'package:pf/screens/profile_register_page.dart';
import 'package:pf/screens/profile_list_page.dart';
import 'package:pf/screens/profile_edit_page.dart';
import 'package:pf/screens/login_page.dart';
import 'package:pf/screens/signup_page.dart';
import 'package:pf/screens/camera_connect_page.dart';
import 'package:pf/screens/start_page.dart';
import 'package:pf/screens/streaming_page.dart';
import 'package:pf/screens/calendar_page.dart';
import 'package:pf/screens/home_connected_page.dart';
import 'package:pf/screens/alarm_page.dart';
import 'package:pf/screens/settings_page.dart';
import 'package:pf/screens/summary_page.dart';
import 'package:pf/screens/streaming_page.dart';
import 'package:pf/screens/profile_liston_page.dart';


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
      home: const ProfileRegisterPage(),
    );
  }
}
