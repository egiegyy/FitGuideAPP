import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitguide/model/progress_model.dart';
import 'package:intl/intl.dart';

class ProgressChart extends StatelessWidget {
  final List<ProgressModel> data;

  const ProgressChart({super.key, required this.data});

  DateTime parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (_) {
      try {
        return DateFormat("d MMMM yyyy", "en_US").parse(date);
      } catch (_) {
        return DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox();
    }

    final sortedData = [...data];
    sortedData.sort((a, b) => parseDate(a.date).compareTo(parseDate(b.date)));

    final weights = sortedData
        .map((e) => double.tryParse(e.weight) ?? 0)
        .toList();
    final reps = sortedData.map((e) => double.tryParse(e.reps) ?? 0).toList();
    final useWeight = weights.any((value) => value > 0);
    final chartValues = useWeight ? weights : reps;
    final pr = chartValues.reduce((a, b) => a > b ? a : b);
    final maxValue = chartValues.reduce((a, b) => a > b ? a : b);
    final yInterval = maxValue <= 5 ? 1.0 : (maxValue / 4).ceilToDouble();

    List<FlSpot> spots = [];
    for (int i = 0; i < sortedData.length; i++) {
      spots.add(FlSpot(i.toDouble(), chartValues[i]));
    }

    final labelStep = sortedData.length <= 4
        ? 1
        : (sortedData.length / 4).ceil();

    final dateFormat = DateFormat('dd/MM');

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
            horizontalInterval: yInterval,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.white.withAlpha(20), strokeWidth: 1);
            },
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: yInterval,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (value != index.toDouble() || index >= sortedData.length) {
                    return const SizedBox();
                  }

                  final shouldShow =
                      index == 0 ||
                      index == sortedData.length - 1 ||
                      index % labelStep == 0;

                  if (!shouldShow) {
                    return const SizedBox();
                  }

                  final parsedDate = parseDate(sortedData[index].date);

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      dateFormat.format(parsedDate),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
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
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  final value = chartValues[index];

                  if (value == pr) {
                    return FlDotCirclePainter(
                      radius: 3,
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
