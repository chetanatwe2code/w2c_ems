import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../logic.dart';

class HomeChart extends StatefulWidget {
  final List<AttendanceCount>? count;
  final int? activeEmployee;
  const HomeChart({super.key,this.count,this.activeEmployee});

  @override
  State<HomeChart> createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {

  int touchedIndex = -1;

  final List<AttendanceCount> presentList = [];
  final List<AttendanceCount> absentList = [];
  //int total = 0;

  @override
  void initState() {
    super.initState();
    presentList.clear();
    for(int k = 0; k < (widget.count?.length??0);k++){
      //total += widget.count![k].count;
     if(widget.count![k].isPresentType){
       presentList.add(widget.count![k]);
     }else{
       absentList.add(widget.count![k]);
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.activeEmployee??0}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w900
                    ),),
                  const Text("Total",
                  style: TextStyle(
                    fontSize: 12
                  ),),
                ],
              ),
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 2,
                  centerSpaceRadius: 35,
                  sections: showingSections(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(int k = 0; k < presentList.length;k++)...[
                      const SizedBox(height: 5,),
                      Indicator(
                        color: presentList[k].color??Colors.white,
                        text: presentList[k].name,
                        count: "${presentList[k].count}",
                        isSquare: false,
                      ),
                    ],
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(int k = 0; k < absentList.length;k++)...[
                      const SizedBox(height: 5,),
                      Indicator(
                        color: absentList[k].color??Colors.white,
                        text: absentList[k].name,
                        count: "${absentList[k].count}",
                        isSquare: false,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    if(widget.count?.isEmpty??true){
      return list;
    }
    for(int k = 0; k < (widget.count?.length??0);k++){
      final isTouched = k == touchedIndex;
      final fontSize = isTouched ? 12.0 : 10.0;
      final radius = isTouched ? 25.0 : 15.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      list.add(PieChartSectionData(
        color: widget.count![k].color,
        value: double.tryParse("${widget.count![k].count}"),
        title: widget.count![k].shortName,
        radius: radius,
        showTitle: isTouched,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      ));
    }
    return list;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    required this.count,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final String count;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 5,
            height: 17,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(2))
            ),
          ),

          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF8e98a2),
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),

          const SizedBox(
            width: 6,
          ),
          if(count.isNotEmpty)
            Text(count,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                  fontSize: 12
              ),
            ),
        ],
      ),
    );
  }
}