import 'package:flutter/material.dart';
import 'package:pf/screens/settings_page.dart';
import 'package:pf/screens/streaming_page.dart';
import 'package:pf/screens/summary_page.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _onItemTapped(int index) {
    if (index == 0) {
      // 캘린더: Fade + Scale
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const CalendarPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final scale = Tween<double>(begin: 0.9, end: 1.0).animate(curved);
            return FadeTransition(
              opacity: fade,
              child: ScaleTransition(scale: scale, child: child),
            );
          },
        ),
      );
    } else if (index == 1) {
      // 요약: Fade + 아래에서 슬라이드 (Smooth)
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const SummaryPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(curved);
            return FadeTransition(
              opacity: fade,
              child: SlideTransition(position: slide, child: child),
            );
          },
        ),
      );
    } else if (index == 2) {
      // Live: Fade + 아래에서 슬라이드 (EaseOutBack)
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const StreamingPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(curved);
            return FadeTransition(
              opacity: fade,
              child: SlideTransition(position: slide, child: child),
            );
          },
        ),
      );
    } else if (index == 3) {
      // 설정: Fade + 오른쪽에서 슬라이드 (EaseInOut)
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const SettingsPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
            final slide = Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(curved);
            return FadeTransition(
              opacity: fade,
              child: SlideTransition(position: slide, child: child),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          '건강 관리',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: 'LGSmartUI',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontFamily: 'LGSmartUI',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'LGSmartUI',
              ),
              defaultTextStyle: TextStyle(
                fontFamily: 'LGSmartUI',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  _recordCard('영양제', '관절약 복용하기'),
                  _recordCard('식사량', '120g'),
                  _recordCard('산책 시간', '30분'),
                  _recordCard('건강검진', '동물 병원 방문하기'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(fontFamily: 'LGSmartUI', fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'LGSmartUI', fontSize: 12),
        backgroundColor: Colors.white,
        elevation: 1,
        currentIndex: 0,
        onTap: _onItemTapped,
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

  Widget _recordCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'LGSmartUI',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'LGSmartUI',
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}