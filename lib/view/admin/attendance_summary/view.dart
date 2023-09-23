import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../common/punching/view.dart';
import '../../other/widget/custom_dropdown.dart';
import '../project/widget/task_view.dart';
import 'logic.dart';

class AttendanceSummaryPage extends StatelessWidget {
  const AttendanceSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AttendanceSummaryLogic>().initYear();
    Get.find<AttendanceSummaryLogic>().getUsersList();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Attendance")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GetBuilder<AttendanceSummaryLogic>(
              assignId: true,
              builder: (logic) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        CustomDropDown(
                          width: 90,
                          height: 25,
                          hint: "Month",
                          list: [
                            DropDownModel(value: logic.months[0], id: '1'),
                            DropDownModel(value: logic.months[1], id: '2'),
                            DropDownModel(value: logic.months[2], id: '3'),
                            DropDownModel(value: logic.months[3], id: '4'),
                            DropDownModel(value: logic.months[4] , id: '5'),
                            DropDownModel(value: logic.months[5], id: '6'),
                            DropDownModel(value: logic.months[6], id: '7'),
                            DropDownModel(value: logic.months[7], id: '8'),
                            DropDownModel(value: logic.months[8], id: '9'),
                            DropDownModel(value: logic.months[9], id: '10'),
                            DropDownModel(value: logic.months[10], id: '11'),
                            DropDownModel(value: logic.months[11], id: '12'),
                          ],
                          selectValue: '${logic.selectMonth}',
                          hintStyle: TextStyle(
                              fontSize: 9,
                              color: AppColors.textColor()
                          ),
                          textStyle: TextStyle(
                              fontSize: 9,
                              color: AppColors.textColor()
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.textColor(), width: 0.2),
                              borderRadius: const BorderRadius.all(Radius.circular(
                                  20)),
                            color: AppColors.whiteColor()
                          ),
                          onChanged: (String? model) {
                            if(model != null){
                              int? m = int.tryParse(model);
                              if(m != null){
                                logic.selectMonth = m;
                                logic.getUsersList();
                              }
                            }
                          },
                        ),

                        const SizedBox(width: 5,),

                        CustomDropDown(
                          width: 90,
                          height: 25,
                          hint: "Year",
                          list: logic.year,
                          selectValue: '${logic.selectYear}',
                          hintStyle: TextStyle(
                              fontSize: 9,
                              color: AppColors.textColor()
                          ),
                          textStyle: TextStyle(
                              fontSize: 9,
                              color: AppColors.textColor()
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.textColor(), width: 0.2),
                              borderRadius: const BorderRadius.all(Radius.circular(
                                  20)),
                              color: AppColors.whiteColor()
                          ),
                          onChanged: (String? model) {
                            if(model != null){
                              int? m = int.tryParse(model);
                              if(m != null){
                                logic.selectYear = m;
                                logic.getUsersList();
                              }
                            }
                          },
                        ),
                      ],
                    ),

                   if(logic.workingDays != null)
                    Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text("${logic.workingDays} Working Days", style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),)),
                  ],
                );
              },
            ),

            const SizedBox(height: 20,),

            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  const Expanded(
                      flex: 4,
                      child: Text("Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),)),

                  Expanded(
                      flex: 1,
                      child: Text("P",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greenColor()
                        ),)),
                  Expanded(
                      flex: 1,
                      child: Text("A",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.redColor()
                        ),)),
                  Expanded(
                      flex: 1,
                      child: Text("EL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.redColor()
                        ),)),
                  Expanded(
                      flex: 1,
                      child: Text("CL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.redColor()
                        ),)),
                  Expanded(
                      flex: 1,
                      child: Text("HD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orangeColor()
                        ),)),
                  Expanded(
                      flex: 1,
                      child: Text("L",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.orangeColor()
                        ),)),
                ],
              ),
            ),

            GetBuilder<AttendanceSummaryLogic>(
              assignId: true,
              builder: (logic) {
                return Column(
                  children: [
                    if(logic.attendanceSummaryModel.isNotEmpty)...[
                      for(int i = 0; i < logic.attendanceSummaryModel.length; i++ )...[
                        Container(
                          decoration: getDecoration(borderRadius: 50),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                            color: generateDarkColor(
                                                logic.attendanceSummaryModel[i].name ?? ""),
                                            shape: BoxShape.circle
                                        ),
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Center(child: Text(
                                          (logic.attendanceSummaryModel[i].name ?? "")
                                              .toImageName(),
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: AppColors.whiteColor(),
                                              fontWeight: FontWeight.bold
                                          ),)),
                                      ),
                                      Flexible(
                                        child: Text(logic.attendanceSummaryModel[i].name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(

                                          ),),
                                      ),
                                    ],
                                  )),

                              Expanded(
                                  flex: 1,
                                  child: Text("${logic.attendanceSummaryModel[i].present??"-"}",
                                    style: TextStyle(
                                        color: logic.attendanceSummaryModel[i].present == null ? null : AppColors.greenColor()
                                    ),)),

                              Expanded(
                                  flex: 1,
                                  child: Text("${logic.attendanceSummaryModel[i].absent??"-"}",
                                    style: TextStyle(
                                        color: logic.attendanceSummaryModel[i].absent == null ? null : AppColors.redColor()
                                    ),)),

                              Expanded(
                                  flex: 1,
                                  child: Text("${logic.attendanceSummaryModel[i].elLeave??"-"}",
                                    style: TextStyle(
                                        color: logic.attendanceSummaryModel[i].elLeave == null ? null : AppColors.redColor()
                                    ),)),

                              Expanded(
                                  flex: 1,
                                  child: Text("${logic.attendanceSummaryModel[i].clLeave??"-"}",
                                    style: TextStyle(
                                        color: logic.attendanceSummaryModel[i].clLeave == null ? null : AppColors.redColor()
                                    ),)),

                              Expanded(
                                  flex: 1,
                                  child: Text("${logic.attendanceSummaryModel[i].halfDay??"-"}",
                                    style: TextStyle(
                                        color: logic.attendanceSummaryModel[i].halfDay == null ? null : AppColors.orangeColor()
                                    ),)),


                              Expanded(
                                  flex: 1,
                                  child: Text("${logic.attendanceSummaryModel[i].late??"-"}",
                                    style: TextStyle(
                                        color: logic.attendanceSummaryModel[i].late == null ? null : AppColors.orangeColor()
                                    ),)),
                            ],
                          ),
                        ),
                      ]
                    ]else...[
                      if(logic.gatingSummary == false)...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text("Not found",style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        )
                      ]
                    ]

                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
