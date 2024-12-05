import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraphScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'date': DateTime(2023, 9, 15), 'hours': 2},
    {'date': DateTime(2023, 9, 29), 'hours': 1},
    {'date': DateTime(2023, 10, 13), 'hours': 3},
    {'date': DateTime(2023, 10, 27), 'hours': 2},
    {'date': DateTime(2023, 11, 10), 'hours': 4},
    {'date': DateTime(2023, 11, 24), 'hours': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200,
        width: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: _generateBarGroups(),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // Map x-axis titles to your date labels
                    int index = value.toInt();
                    if (index < 0 || index >= data.length)
                      return const SizedBox();
                    DateTime date = data[index]['date'];
                    return Text(
                      '${date.month}/${date.day}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()} hrs',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true, // Enable the border
              border: Border(
                left: BorderSide(
                    color: Colors.white.withOpacity(0.8),
                    width: 1), // Left border
                bottom: BorderSide(
                    color: Colors.white.withOpacity(0.8),
                    width: 1), // Bottom border
                right: BorderSide(color: Colors.transparent), // No right border
                top: BorderSide(color: Colors.transparent), // No top border
              ),
            ),
            gridData: FlGridData(
              // Grid lines for better visualization
              show: true,
              drawVerticalLine: true,
              drawHorizontalLine: true,
              verticalInterval: 1,
              horizontalInterval: 1,
              getDrawingVerticalLine: (value) => FlLine(
                color: Colors.white.withOpacity(0.2),
                strokeWidth: 1,
              ),
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.white.withOpacity(0.2),
                strokeWidth: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(
      data.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(0),
            toY: data[index]['hours'].toDouble(),
            color: Colors.blue,
            width: 16,
          ),
        ],
      ),
    );
  }
}
