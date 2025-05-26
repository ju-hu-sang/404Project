import 'package:flutter/material.dart';

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ 배경색 흰색 추가
      appBar: AppBar(
        title: const Text(
          '나의 반려동물',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/paw_placeholder.png', // ✅ 흐리게 표시할 발바닥 이미지
              width: 120,
              height: 120,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '등록된 반려동물이 없습니다',
            style: TextStyle(
              fontFamily: 'LGSmartUI',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFF7D7D7D),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  // 프로필 추가 페이지 이동 등 처리
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '+ 프로필 추가',
                  style: TextStyle(
                    fontFamily: 'LGSmartUI',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}