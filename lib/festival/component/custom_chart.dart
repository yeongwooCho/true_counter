import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/util/map_with_index.dart';
import 'package:true_counter/common/util/money_format.dart';
import 'package:true_counter/festival/model/festival_model.dart';

class CustomChart extends StatefulWidget {
  final FestivalModel festivalModel;

  const CustomChart({
    Key? key,
    required this.festivalModel,
  }) : super(key: key);

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  // 그라데이션
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Color(0xff232d37),
      ),
      child: SizedBox(
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: widget.festivalModel.participants.isNotEmpty
              ? LineChart(
                  getLineChardData(),
                  duration: const Duration(seconds: 2), // Optional
                  curve: Curves.linear, // Optional
                )
              : Container(
                  color: Colors.red,
                ),
        ),
      ),
    );
  }

  FlLine getDividerLine(double value) {
    return FlLine(
      color: DARK_GREY_COLOR,
      strokeWidth: 1,
    );
  }

  FlBorderData getFlBorderData() {
    return FlBorderData(
      show: true,
      border: Border.all(
        color: DARK_GREY_COLOR,
        width: 1,
      ),
    );
  }

  SideTitles getLeftSideTitles() {
    int valueLength =
        widget.festivalModel.cumulativeParticipantCount.toString().length;
    int dotLength = valueLength > 3 ? (valueLength > 6 ? 2 : 1) : 0;
    double valueWidth = 9.0; // 숫자 width
    double dotWidth = 6.0; // , 문자 width

    return SideTitles(
      showTitles: true,
      reservedSize: (valueLength * valueWidth) + (dotLength * dotWidth),
      interval: widget.festivalModel.cumulativeParticipantCount / 3,
      getTitlesWidget: (double value, TitleMeta meta) {
        late String title;
        switch (value.toInt()) {
          default:
            title = convertIntToMoneyString(number: value.toInt());
        }
        return Text(
          title,
          style: smallGreyTextStyle,
          textAlign: TextAlign.center,
        );
      },
    );
  }

  SideTitles getBottomSideTitles() {
    Duration duration = widget.festivalModel.endAt.difference(
      widget.festivalModel.startAt,
    );

    return SideTitles(
      showTitles: true,
      reservedSize: 16, // text height
      interval: duration.inHours / 4,
      getTitlesWidget: (double value, TitleMeta meta) {
        late String title;
        switch (value.toInt()) {
          default:
            title = "${value.toInt()}";
        }
        return Text(
          title,
          style: smallGreyTextStyle,
        );
      },
    );
  }

  LineChartData getLineChardData() {
    return LineChartData(
      lineBarsData: getLineBarsData(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: getDividerLine,
        getDrawingVerticalLine: getDividerLine,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: getBottomSideTitles(),
          // drawBelowEverything: true,
          axisNameWidget: Text(
            '시간',
            style: smallGreyTextStyle.copyWith(
              color: WHITE_TEXT_COLOR,
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: getLeftSideTitles(),
          // drawBelowEverything: true,
          axisNameWidget: Text(
            '누적 참여자 수',
            style: smallGreyTextStyle.copyWith(
              color: WHITE_TEXT_COLOR,
            ),
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: getFlBorderData(),
    );
  }

  List<LineChartBarData> getLineBarsData() {
    int startHour = widget.festivalModel.startAt.hour;

    List<String> participants = widget.festivalModel.participants.split('/');

    List<int> refineParticipants = participants.map<int>((String element) {
      int temp = 0;
      try {
        temp = int.parse(element);
      } catch (error) {
        print("참여자수 데이터 에러 : $error");
      }
      return temp;
    }).toList();

    List<FlSpot> flSpotList = refineParticipants
        .mapWithIndex<FlSpot>(
          (element, index) => FlSpot(
            (startHour + 1 + index).toDouble(),
            element.toDouble(),
          ),
        )
        .toList();

    return [
      LineChartBarData(
        spots: flSpotList,
        isCurved: false,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors
                .map(
                  (color) => color.withOpacity(0.3),
                )
                .toList(),
          ),
        ),
      ),
    ];
  }
}
