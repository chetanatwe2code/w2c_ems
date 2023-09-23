import 'package:attendance/model/AttendanceSummaryModel.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:get/get.dart';

import '../../../core/di/api_client.dart';
import '../../../core/di/api_provider.dart';
import '../../../model/AttendaceModel.dart';
import '../../../model/HolidayByMonth.dart';
import '../../../model/UserModel.dart';
import '../../other/widget/custom_dropdown.dart';

class AttendanceSummaryLogic extends GetxController {
  final ApiClient apiClient;
  AttendanceSummaryLogic({required this.apiClient});

  List<AttendanceSummaryModel> attendanceSummaryModel = [];
  List<HolidayByMonth> holiday = [];
  int? workingDays;

  bool gatingSummary = false;
  getUsersList(){
    gatingSummary = true;
    workingDays = null;
    attendanceSummaryModel.clear();
    holiday.clear();
    dynamic body = {
      'date' : "$selectYear-$selectMonth-01"
    };
    apiClient.postAPI(ApiProvider.attendanceSummary, body).then((value) => {
      if(value.body['success']){
        value.body['result'].forEach((v) {
          attendanceSummaryModel.add(AttendanceSummaryModel.fromJson(v));
        }),
        value.body['holidays'].forEach((v) {
          holiday.add(HolidayByMonth.fromJson(v));
        }),
      },
      gatingSummary = false
    }).whenComplete((){
      initWorkingDays(selectYear,selectMonth);
    });
  }

  initWorkingDays(int year,int month ){
    List<DateTime> holidayAndSundays = [];

    DateTime currentDate = DateTime(year, month, 1);

    while (currentDate.weekday != DateTime.sunday) {
      currentDate = currentDate.add(const Duration(days: 1));
    }

    while (currentDate.month == month) {
      holidayAndSundays.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 7)); // Move to the next Sunday
    }

    for(int i =0; i < holiday.length; i++){
      DateTime? start = (holiday[i].startDate??"").toDateTime();
      DateTime? end = (holiday[i].endDate??"").toDateTime();
      if(start == null){
        continue;
      }
      if(end != null){
        for (DateTime date = start; date.isBefore(end) || date.isAtSameMomentAs(end); date = date.add(const Duration(days: 1))) {
          // add date if this date not exist in holidays array
          if (!holidayAndSundays.contains(date)) {
            holidayAndSundays.add(date);
          }
        }
      }else{
        // add date if this date not exist in holidays array
        if (!holidayAndSundays.contains(start)) {
          holidayAndSundays.add(start);
        }
      }
    }
    workingDays = DateTime(year, month + 1, 0).day - holidayAndSundays.length;
    gatingSummary = false;
    update();
  }

  int countSundaysInMonth(int year, int month) {
    int count = 0;
    final DateTime firstDayOfMonth = DateTime(year, month, 1);
    final DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    for (DateTime date = firstDayOfMonth; date.isBefore(lastDayOfMonth); date = date.add(const Duration(days: 1))) {
      if (date.weekday == DateTime.sunday) {
        count++;
      }
    }

    return count;
  }

  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  int selectMonth = DateTime.now().month;
  int selectYear = DateTime.now().year;

  List<DropDownModel> year = [];
  initYear(){
    year.clear();
    int toYear = DateTime.now().year;
    for(int i = toYear; i > 1974; i--){
      year.add(DropDownModel(value: '$i'));
    }
  }
}
