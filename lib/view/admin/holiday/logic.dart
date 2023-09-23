import 'package:attendance/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/EventModel.dart';
import '../../../repository/holiday_repository.dart';

class HolidayLogic extends GetxController implements GetxService{
  final HolidayRepository repository;
  HolidayLogic({required this.repository});

  bool getHolidaysProcess = false;
  List<EventModel> list = [];
  getHolidays(){
    getHolidaysProcess = true;
    list.clear();
    update();
    repository.getHolidays().then((value) => {
      if(value.body['success']){
        value.body['holiday']['data'].forEach((v) {
          list.add(EventModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      getHolidaysProcess = false,
      update(),
    });
  }



  bool storeHolidayProcess = false;
  storeHoliday({required dynamic body, Function? callback }){
    storeHolidayProcess = true;
    update();
    repository.storeHoliday(body).then((value) => {
      if(value.body['success']){
        Toast.show(toastMessage: "Event Created"),
        if(callback != null){
          callback(),
        }
      }
    }).whenComplete(() => {
      storeHolidayProcess = false,
      update()
    });
  }

  updateHoliday({required dynamic body,required int? id, Function? callback }){
    storeHolidayProcess = true;
    update();
    repository.updateHoliday(body,id).then((value) => {
      if(value.body['success']){
        Toast.show(toastMessage: "Event Updated"),
        if(callback != null){
          callback(),
        }
      }
    }).whenComplete(() => {
      storeHolidayProcess = false,
      update()
    });
  }

  bool deleteHolidayProcess = false;
  destroyHoliday({required int? id, Function? callback }){
    deleteHolidayProcess = true;
    update();
    repository.destroyHoliday(id).then((value) => {
      if(value.body['success']){
        Toast.show(toastMessage: "Event Deleted",iconData: Icons.delete),
        if(callback != null){
          callback(),
        }
      }
    }).whenComplete(() => {
      deleteHolidayProcess = false,
      update()
    });
  }
}
