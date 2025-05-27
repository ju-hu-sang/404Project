import 'package:flutter/material.dart';
import 'package:pf/screens/home_connected_page.dart'; // HomeConnectedPage import

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  static const List<Map<String, String>> alerts = [
    {'message': '이상행동이 감지되었습니다.', 'time': '오후 1:14'},
    {'message': '이상행동이 감지되었습니다.', 'time': '오전 9:32'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '알림',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.black),
          SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.pets, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alerts[index]['message']!,
                              style: const TextStyle(
                                fontFamily: 'LGSmartUI',
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              alerts[index]['time']!,
                              style: const TextStyle(
                                fontFamily: 'LGSmartUI',
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Center(
            child: IgnorePointer(
              child: Icon(
                Icons.notifications_none_outlined,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
