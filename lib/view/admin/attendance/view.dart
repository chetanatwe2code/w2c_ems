import 'package:attendance/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../calendar/new_calendar.dart';
import '../../common/punching/view.dart';
import '../home/widget/users_view.dart';
import 'logic.dart';

class AttendancePage extends GetView<AttendanceLogic> {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUsers();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Attendance")),
      body: SingleChildScrollView(
        child: GetBuilder<AttendanceLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: NewCalendar(
                    selectedDate: (dateTime){
                      controller.dateTime = dateTime;
                      controller.getUsers();
                    },
                    holidays: logic.holiday,
                    lastDay: DateTime.now(),
                  ),
                ),

                ListView.builder(
                  itemCount: logic.list.length,
                  padding: EdgeInsets.only(
                      top: 20, left: hPadding, right: hPadding),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return UsersView(list: logic.list[index],
                      dateTime: logic.dateTime,);
                  },),
              ],
            );
          },
        ),
      ),
    );
  }
}
