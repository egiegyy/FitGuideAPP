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

    /// convert weight ke double
    List<double> weights = data
        .map((e) => double.tryParse(e.weight) ?? 0)
        .toList();

    /// cari personal record
    double pr = weights.reduce((a, b) => a > b ? a : b);
    List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), double.tryParse(data[i].weight) ?? 0));
    }
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(800),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= data.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      data[index].date.substring(5),
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
              color: Colors.blue,
              barWidth: 4,

              /// DOT STYLE
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  double weight = double.tryParse(data[index].weight) ?? 0;

                  /// highlight PR
                  if (weight == pr) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.red,
                      strokeWidth: 1,
                      strokeColor: Colors.black,
                    );
                  }
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.blue,
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withAlpha(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
