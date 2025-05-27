import 'package:flutter/material.dart';
import 'package:pf/screens/settings_page.dart';
import 'package:pf/screens/calendar_page.dart';
import 'package:pf/screens/streaming_page.dart';
import 'package:pf/screens/summary_page.dart';
import 'package:pf/screens/alarm_page.dart'; // AlarmPage import

class HomeConnectedPage extends StatefulWidget {
  const HomeConnectedPage({super.key});

  @override
  State<HomeConnectedPage> createState() => _HomeConnectedPageState();
}

class _HomeConnectedPageState extends State<HomeConnectedPage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const CalendarPage(),
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
    } else if (index == 1) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const SummaryPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
            final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(curved);
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
    } else if (index == 2) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const StreamingPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
            final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(curved);
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
    } else if (index == 3) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const SettingsPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final slideAnimation = Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(curved);
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
  }

  void _goToAlarmPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const AlarmPage(),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
          final slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(curved);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '가나디 홈',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'LGSmartUI',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: _goToAlarmPage,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/default_profile.png'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '가나디 상태',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'LGSmartUI',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00B300),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('상태', style: TextStyle(fontSize: 14, fontFamily: 'LGSmartUI')),
                            Text('10분 전에 짖었어요 !',
                                style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'LGSmartUI')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    SizedBox(height: 18),
                    Text('마지막 활동:', style: TextStyle(fontSize: 14, fontFamily: 'LGSmartUI')),
                    Text('방금 전', style: TextStyle(fontSize: 14, fontFamily: 'LGSmartUI')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('연결 기기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'LGSmartUI')),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _deviceBox('카메라 연결 상태', 'Smart Camera', '카메라', '연결됨'),
                _deviceBox('마이크 연결 상태', 'Microphone', '마이크', '연결됨'),
                _deviceBox('모션 센서', 'Motion Sensor', '모션 센서', '활성화됨'),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('최근 알림',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'LGSmartUI')),
            ),
            const SizedBox(height: 12),
            _alertItem('May 16, 2:12 PM', '이상행동 감지'),
            _alertItem('May 16, 1:45 PM', '움직임 감지'),
            _alertItem('May 16, 1:30 PM', '오랜시간 조용함'),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(fontFamily: 'LGSmartUI', fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'LGSmartUI', fontSize: 12),
        backgroundColor: Colors.white,
        elevation: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 24),
            label: '캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, size: 24),
            label: '요약',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam, size: 24),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 24),
            label: '설정',
          ),
        ],
      ),
    );
  }

  static Widget _deviceBox(String tag, String title, String label, String status) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.black12,
            child: Center(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: 'LGSmartUI', fontWeight: FontWeight.w600)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 13, fontFamily: 'LGSmartUI')),
                const SizedBox(height: 4),
                Text(status,
                    style: const TextStyle(fontSize: 16, fontFamily: 'LGSmartUI', fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _alertItem(String time, String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.notifications, color: Colors.amber, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(fontSize: 14, fontFamily: 'LGSmartUI')),
              Text(message,
                  style: const TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'LGSmartUI')),
            ],
          ),
        ],
      ),
    );
  }
}
