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

    List<FlSpot> spots = [];

    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), double.tryParse(data[i].weight) ?? 0));
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
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
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();

                  if (index >= data.length) {
                    return const Text("");
                  }

                  return Text(
                    data[index].date.substring(5),
                    style: const TextStyle(fontSize: 10, color: Colors.black),
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

              color: const Color(0xff6C9E56),

              barWidth: 4,

              dotData: FlDotData(show: true),

              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xff6C9E56).withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
