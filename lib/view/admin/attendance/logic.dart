import 'package:get/get.dart';

import '../../../model/UsersModel.dart';
import '../../../repository/attendance_repository.dart';
import '../home/logic.dart';

class AttendanceLogic extends GetxController implements GetxService {
  final AttendanceRepository repository;
  AttendanceLogic({required this.repository});

  List<Holiday> holiday = [];

  List<UsersModel> list = [];
  DateTime? dateTime = DateTime.now();
  bool getUsersProcess = false;
  getUsers(){
    list.clear();
    dynamic body = {};
    if(dateTime != null){
      body = {
        "date" : "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}"
      };
    }

    getUsersProcess = true;
    update();

    repository.getUsers(body: body).then((value) => {
      if(value.body['success']){
        value.body['users'].forEach((v) {
          list.add(UsersModel.fromJson(v));
        }),
        holiday.clear(),
        holiday.addAll(updateHolidays(value.body['event'])),
      }
    }).whenComplete(() => {
      getUsersProcess = false,
      update()
    });
  }
}
