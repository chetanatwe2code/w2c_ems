import 'package:attendance/model/ApplicationModel.dart';
import 'package:attendance/model/BirthdayModel.dart';
import 'package:attendance/repository/home_repository.dart';
import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/EventModel.dart';
import '../../../model/UserTaskCountModel.dart';
import '../../../model/UsersModel.dart';

class Holiday{
  final DateTime? dateTime;
  final String? name;
  final bool? isHalfDay;
  Holiday({ this.dateTime,this.name,this.isHalfDay });
}

// class AttendanceCount{
//   final int presentCount;
//   final int absentCount;
//   final int letComing;
//   final int workHomeCount;
//   final int halfDayCount;
//   AttendanceCount({ this.absentCount = 0,this.letComing=0,this.presentCount=0,this.halfDayCount=0,this.workHomeCount=0 });
// }

class AttendanceCount{
  final int count;
  final String shortName;
  final String name;
  final Color? color;
  final bool isPresentType;
  AttendanceCount({ this.count = 0,this.shortName = "", this.name="",this.color,required this.isPresentType });
}

List<Holiday> updateHolidays(dynamic value) {
  List<Holiday> holiday = [];

  value.forEach((v) {
    DateTime? start = "${v['start_date']}".toDateTime();
    DateTime? end = "${v['end_date']}".toDateTime();
    if (start != null && end != null) {
      // Loop through the range of dates and add them to the holiday list
      for (DateTime date = start; date.isBefore(end.add(const Duration(days: 1))); date = date.add(const Duration(days: 1))) {
        holiday.add(Holiday(dateTime: date, name: v['event'], isHalfDay: v['event'] == "Half Day"));
      }
    }
  });
  return holiday;
}

Holiday? isHolidayEvent(dynamic value,{ DateTime? currentDateTime }) {
  DateTime dateTime = currentDateTime ?? DateTime.now();
  Holiday? holiday;
  value.forEach((v) {
    DateTime? start = "${v['start_date']}".toDateTime();
    DateTime? end = "${v['end_date']}".toDateTime();

    if (start != null && end != null) {
      // Loop through the range of dates and add them to the holiday list
      for (DateTime date = start; date.isBefore(end.add(const Duration(days: 1))); date = date.add(const Duration(days: 1))) {

        if(isSameDay(dateTime, date)){
          print("value_PPP ${start} / $end");
          holiday = Holiday(dateTime: date, name: v['event'], isHalfDay: v['event'] == "Half Day");
        }
      }
    }
  });
  return holiday;
}

class HomeLogic extends GetxController implements GetxService {
  final HomeRepository repository;
  HomeLogic({required this.repository});

  //List<UsersModel> list = [];
  DateTime? dateTime = DateTime.now();

  //AttendanceCount attendanceCount = AttendanceCount();

  List<AttendanceCount> count = [];
  List<AttendanceCount> getAtCount(dynamic value){
    print("value___ $value");
    List<AttendanceCount> count = [];
    if((int.tryParse(value['present_count'].toString())??0) > 0){
      count.add(AttendanceCount(
        count: int.tryParse(value['present_count'].toString())??0,
        name: "Present",
        shortName: "P",
        color: AppColors.presentColor,
        isPresentType: true,
      ));
    }
    if((int.tryParse(value['absent_count'].toString())??0) > 0){
      count.add(AttendanceCount(
          count: int.tryParse(value['absent_count'].toString())??0,
          name: "Absent",
          shortName: "A",
          isPresentType: false,
          color: AppColors.absentColor));
    }

    if((int.tryParse(value['el_ml_ol_leave'].toString())??0) > 0){
      count.add(AttendanceCount(
          count: int.tryParse(value['el_ml_ol_leave'].toString())??0,
          name: "EL/ML",
          shortName: "EL/ML",
          isPresentType: false,
          color: AppColors.leaveColor));
    }

    if((int.tryParse(value['cl_leave'].toString())??0) > 0){
      count.add(AttendanceCount(
          count: int.tryParse(value['cl_leave'].toString())??0,
          name: "CL",
          shortName: "CL",
          isPresentType: false,
          color: AppColors.leaveColor));
    }

    if((int.tryParse(value['let_coming'].toString())??0) > 0){
      count.add(AttendanceCount(count: int.tryParse(value['let_coming'].toString())??0,
          name: "Late",
          shortName: "L",
          isPresentType: true,
          color: AppColors.lateColor
      ));
    }

    if((int.tryParse(value['half_day_count'].toString())??0) > 0){
      count.add(AttendanceCount(
        count: int.tryParse(value['half_day_count'].toString())??0,
        name: "Half Day",
        shortName: "HD",
        color: AppColors.halfDayColor,
        isPresentType: true,
      ));
    }

    if((int.tryParse(value['work_home_count'].toString())??0) > 0){
      count.add(AttendanceCount(
          count: int.tryParse(value['work_home_count'].toString())??0,
          name: "WFH",
          shortName: "WFH",
          isPresentType: true,
          color: AppColors.wfhColor));
    }

    if((int.tryParse(value['punch_in_count'].toString())??0) > 0){
      count.add(AttendanceCount(count: int.tryParse(value['punch_in_count'].toString())??0,
          name: "Punch In",
          shortName: "PI",
          isPresentType: true,
          color: AppColors.greenColor()
      ));
    }

    if((int.tryParse(value['not_punch_in_count'].toString())??0) > 0){
      count.add(AttendanceCount(count: int.tryParse(value['not_punch_in_count'].toString())??0,
          name: "Not Punch In",
          shortName: "NPI",
          isPresentType: true,
          color: AppColors.redColor()
      ));
    }

    return count;
  }

  clearData(){
    //list.clear();
    count.clear();
    dateTime = DateTime.now();
    update();
  }

  List<Holiday> holiday = [];

 // bool getUsersProcess = false;
  Holiday? isHoliday;
  // getUsers(){
  //   list.clear();
  //   count.clear();
  //   isHoliday = null;
  //   attendanceType = 1;
  //   dynamic body = {};
  //   if(dateTime != null){
  //     body = {
  //       "date" : "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}"
  //     };
  //   }
  //
  //   getUsersProcess = true;
  //   update();
  //
  //   repository.getUsers(body: body).then((value) => {
  //     if(value.body['success']){
  //       value.body['users'].forEach((v) {
  //         list.add(UsersModel.fromJson(v));
  //       }),
  //
  //       count.addAll(getAtCount(value.body['count'])),
  //
  //       holiday.clear(),
  //       holiday.addAll(updateHolidays(value.body['event'])),
  //       isHoliday = isHolidayEvent(value.body['event'],currentDateTime: dateTime),
  //     }
  //   }).whenComplete(() => {
  //     getUsersProcess = false,
  //     update()
  //   });
  //
  // }

  bool getAttendanceByMonth = false;
  int? activeEmployee;
  int attendanceType = 1;
  attendanceByDate(){
    if(dateTime == null && attendanceType == 1) return;
    attendanceType = 2;
    activeEmployee = null;
    count.clear();
    getAttendanceByMonth = true;
    update();
    repository.attendanceByDate(date: "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}").then((value) => {
      if(value.body['success']){
        count.addAll(getAtCount(value.body['count'])),
        activeEmployee = int.tryParse(value.body['users_count'].toString())
      }
    }).whenComplete(() => {
      getAttendanceByMonth = false,
      update()
    });
  }

  List<EventModel> thisMonthEvent = [];
  List<BirthdayModel> thisMonthBirthday = [];

  getHolidayByMonth(){
    thisMonthEvent.clear();
    thisMonthBirthday.clear();
    repository.getHolidayByMonth(date: "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}").then((value) => {
      if(value.body['success']){
        value.body['events'].forEach((v) {
          thisMonthEvent.add(EventModel.fromJson(v));
        }),

        value.body['upcoming_birthdays'].forEach((v) {
          thisMonthBirthday.add(BirthdayModel.fromJson(v));
        }),
      }
    }).whenComplete(() => update()
    );
  }

  List<ApplicationModel> thisMonthLeaves = [];
  getLeavesByMonth(){
    thisMonthLeaves.clear();
    repository.getLeavesByMonth(date: "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}").then((value) => {
      if(value.body['success']){
        value.body['leaves'].forEach((v) {
          thisMonthLeaves.add(ApplicationModel.fromJson(v));
        }),
      }
    }).whenComplete(() => update()
    );
  }

  List<UserTaskCountModel> userTaskCountModel = [];
  getUserWithTasksCount(){
    userTaskCountModel.clear();
    repository.userWithTasksCount().then((value) => {
      if(value.body['success']){
        value.body['users'].forEach((v) {
          if(!(v['total_task'] == 0 || v['total_task'] == '0')){
            userTaskCountModel.add(UserTaskCountModel.fromJson(v));
          }
        }),
      }
    }).whenComplete(() => update()
    );
  }
}
