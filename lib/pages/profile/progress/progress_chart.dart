import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitguide/model/progress_model.dart';

class ProgressChart extends StatelessWidget {
  final List<ProgressModel> data;

  const ProgressChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox();
    }

    /// SORT DATA BY DATE (OLD → NEW)
    final sortedData = [...data];
    sortedData.sort((a, b) => a.date.compareTo(b.date));

    /// convert weight ke double
    List<double> weights = sortedData
        .map((e) => double.tryParse(e.weight) ?? 0)
        .toList();

    /// cari personal record
    double pr = weights.reduce((a, b) => a > b ? a : b);

    /// generate chart spots
    List<FlSpot> spots = [];
    for (int i = 0; i < sortedData.length; i++) {
      spots.add(
        FlSpot(i.toDouble(), double.tryParse(sortedData[i].weight) ?? 0),
      );
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF0A0F0A),
            Color(0xFF101810),
            Color(0xFF000000),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.white.withAlpha(20), strokeWidth: 1);
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white70),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= sortedData.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      sortedData[index].date.substring(5),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: const LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
              ),
              barWidth: 4,

              /// DOT STYLE
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  double weight =
                      double.tryParse(sortedData[index].weight) ?? 0;

                  /// highlight PR
                  if (weight == pr) {
                    return FlDotCirclePainter(
                      radius: 5,
                      color: const Color(0xFF66BB6A),
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  }

                  return FlDotCirclePainter(
                    radius: 4,
                    color: const Color(0xFF2E7D32),
                    strokeWidth: 1,
                    strokeColor: Colors.white24,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2E7D32).withAlpha(90),
                    const Color(0xFF66BB6A).withAlpha(13),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
