import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '요약',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'LGSmartUI',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '어제보다 짖음, 하울링 영상의 비율이 12% 감소했어요',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'LGSmartUI',
                ),
              ),
            ),
            _sectionTitle('짖음 및 하울링'),
            _barkGraph(),
            _barkSummary(),
            _sectionTitle('활동량'),
            _activityChartWithText(),
            _sectionTitle('영역 감지'),
            _zoneSection(),
            const SizedBox(height: 24),
            _bottomButton('월별 통계 확인하기'),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'LGSmartUI',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _barkGraph() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 160,
        child: BarChart(
          BarChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text('어제', style: TextStyle(fontSize: 12));
                      case 1:
                        return const Text('오늘', style: TextStyle(fontSize: 12));
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(toY: 260, width: 40, color: Colors.orange),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(toY: 229, width: 40, color: Colors.orangeAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barkSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '주요 시각 : 13시 05분',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'LGSmartUI',
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '총 15회',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'LGSmartUI',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityChartWithText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 7.5, color: Colors.orange, radius: 30),
                    PieChartSectionData(value: 15.5, color: Colors.grey.shade300, radius: 30),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 20,
                ),
              ),
            ),
            const SizedBox(width: 32),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('활동 시간  7시간 34분', style: TextStyle(fontSize: 16, fontFamily: 'LGSmartUI')),
                  SizedBox(height: 4),
                  Text('휴식 시간  15시간 26분', style: TextStyle(fontSize: 16, fontFamily: 'LGSmartUI')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _zoneSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _zoneBox('거실', '15번')),
          const SizedBox(width: 8),
          Expanded(child: _zoneBox('현관', '8번')),
        ],
      ),
    );
  }

  Widget _zoneBox(String title, String count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'LGSmartUI',
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'LGSmartUI',
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'LGSmartUI',
            ),
          ),
        ),
      ),
    );
  }
}
