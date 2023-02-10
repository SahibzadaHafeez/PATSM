import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScoreChart extends StatefulWidget {
  ScoreChart(
      {Key? key, required this.data, required this.max, required this.mob})
      : super(key: key);

  List<String> data;
  double max;
  bool mob;

  @override
  State<ScoreChart> createState() => _ScoreChartState();
}

class _ScoreChartState extends State<ScoreChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: widget.max + (20 - (widget.max % 10)),
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: double.parse(widget.data[5]),
                color: Colors.purpleAccent,
                width: MediaQuery.of(context).size.width * 0.03,
                borderRadius: BorderRadius.circular(0),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: double.parse(widget.data[6]),
                color: Colors.cyanAccent,
                width: MediaQuery.of(context).size.width * 0.03,
                borderRadius: BorderRadius.circular(0),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: double.parse(widget.data[7]),
                color: Colors.yellowAccent,
                width: MediaQuery.of(context).size.width * 0.03,
                borderRadius: BorderRadius.circular(0),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: double.parse(widget.data[8]),
                color: Colors.redAccent,
                width: MediaQuery.of(context).size.width * 0.03,
                borderRadius: BorderRadius.circular(0),
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                toY: double.parse(widget.data[9]),
                color: Colors.greenAccent,
                width: MediaQuery.of(context).size.width * 0.03,
                borderRadius: BorderRadius.circular(0),
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, meta) {
                return Text(
                  // widget.mob == true
                  //     ? val == 0
                  //     ? 'N'
                  //     : val == 1
                  //     ? 'E'
                  //     : val == 2
                  //     ? 'O'
                  //     : val == 3
                  //     ? 'A'
                  //     : 'C.'
                  //     :
                val == 0
                      ? widget.data[0]
                      : val == 1
                      ? widget.data[1]
                      : val == 2
                      ? widget.data[2]
                      : val == 3
                      ? widget.data[3]
                      : widget.data[4]
                  ,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, meta) {
                return Text(
                  widget.mob == true
                      ? val == 0
                          ? 'N'
                          : val == 1
                              ? 'E'
                              : val == 2
                                  ? 'O'
                                  : val == 3
                                      ? 'A'
                                      : 'C.'
                      : val == 0
                          ? 'Neuroticism'
                          : val == 1
                              ? 'Extraversion'
                              : val == 2
                                  ? 'Openness'
                                  : val == 3
                                      ? 'Agreeableness'
                                      : 'Consc.',
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
