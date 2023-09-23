import 'package:attendance/model/UserModel.dart';
import 'package:attendance/view/common/punching/view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/AttendaceModel.dart';
import '../../../repository/home_repository.dart';
import '../../../repository/punching_repository.dart';
import '../../../utils/toast.dart';
import '../../admin/home/logic.dart';

// remove LA,WH in next app release
enum PresentStatus {  A,P,L,HD,ML,EL,CL,WH }

StatusModel? getPresentStatus({ String? status }){

  if(status == PresentStatus.P.name){
    return StatusModel(
        color: Colors.green,
        text: "Present",
        shortText: "P",
        iconData: Icons.thumb_up
    );
  }

  if(status == PresentStatus.WH.name){
    return StatusModel(
        color: Colors.green,
        text: "WFH",
        shortText: "WFH",
        iconData: Icons.thumb_up
    );
  }

  if(status == PresentStatus.A.name){
    return StatusModel(
        color: Colors.red,
        text: "Absent",
        shortText: "A",
    );
  }

  if(status == PresentStatus.HD.name){
    return StatusModel(
      color: Colors.blue,
      text: "Half Day",
      shortText: "HD",
    );
  }

  if(status == PresentStatus.L.name){
    return StatusModel(
        color: Colors.orange,
        text: "Late",
        shortText: "L"
    );
  }

  if(status == PresentStatus.ML.name){
    return StatusModel(
        color: Colors.red,
        text: "ML/EL",
        shortText: "ML"
    );
  }

  if(status == PresentStatus.EL.name){
    return StatusModel(
        color: Colors.red,
        text: "ML/EL",
        shortText: "EL"
    );
  }

  if(status == PresentStatus.CL.name){
    return StatusModel(
        color: Colors.red,
        text: "CL",
        shortText: "OL"
    );
  }

  return null;
}

class PunchingLogic extends GetxController implements GetxService {
  final PunchingRepository repository;
  PunchingLogic({required this.repository});

  UserModel? user;
  DateTime? dateTime;

  List<AttendanceModel> list = [];
  int presentCount = 0;
  int absentCount = 0;
  int letComing = 0;
  //Position? position;
  bool punchingIn = false;
  bool punchingOut = false;

  double targetDistanceInMeters = 30.0;
  //double maxDistanceInMeters = kReleaseMode ? 20.0 : 200000000000.0;
  double targetLat = 22.7445344;
  double targetLong = 75.8975222;
  String? lastMonth;


  clearData(){
    user = null;
    dateTime = null;
    lastMonth = null;
  //  position = null;
    punchingIn = false;
    punchingOut = false;
    list.clear();
    presentCount = 0;
    absentCount = 0;
    letComing = 0;
    update();
  }


  initUser(dynamic user,DateTime dateTime){
    this.user = UserModel.fromJson(user);
    this.dateTime = dateTime;
    update();
  }

  isValidInTime(){
    final now = DateTime.now();
    return now.hour >= 9;
  }

  isValidOutTime(){
    final now = DateTime.now();
    return now.hour >= 18;
  }

  AttemptStep? attemptStep;
  AttendanceModel? todayModel;
  checkAttempt(){
    attemptStep = null;
    dynamic body = {
      "user_id" : user?.id,
      "date" : dateTime != null ? "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}" : null,
    };
    print("checkAttempt_body $body");
    repository.getAttemptStatus(body: body).then((value) => {
      if(value.body['success']){
        if(value.body['attendance'] != null){
          todayModel = AttendanceModel.fromJson(value.body['attendance']),
          if(value.body['attendance']['out_time'] != null){
            attemptStep = AttemptStep.isAttemptBoth
          }else if(value.body['attendance']['in_time'] != null){
            attemptStep = AttemptStep.isAttemptIn
          }
        },
      },

    }).whenComplete(() => {
      if(attemptStep == null){
        attemptStep = AttemptStep.none
      },
      update(),
    });
  }

  PresentStatus? isMarkAttendance;

  // Punching

  markAttendance({required PresentStatus status }) {
    isMarkAttendance = status;
    dynamic body = {
      "user_id" : user?.id,
      "mark_as_a" :  isMarkAttendance!.name,
      "date" : dateTime != null ? "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}" : null,
    };
    repository.markAttendance(body: body).then((value) => {
      checkAttempt(),
      getHistory()
    }).whenComplete(() => {
      isMarkAttendance = null,
      update()
    });
  }

  insertAttendance() {
    repository.insertAttendance(body: {}).then((value) => {
      checkAttempt(),
      getHistory()
    }).whenComplete(() => update());
  }

  updateOutTime(){
    // dynamic body = {
    //   "user_id" : user?.id,
    //   "date" : dateTime != null ? "$dateTime" : null,
    // };
    repository.updateOutTime("${todayModel?.id}",body: {}).then((value) => {
      checkAttempt(),
      getHistory()
    });
  }


  bool getHistoryProcess = false;
  Holiday? isHoliday;
  getHistory(){
    list.clear();
    isHoliday = null;
    dynamic body = {
      "user_id" : user?.id,
      "date" : dateTime != null ? "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}" : null,
    };
    getHistoryProcess = true;
    update();
    print("getHistory_body $body");
    repository.getHistory(body: body).then((value) => {
      if(value.body['success']){
        value.body['attendance']['data'].forEach((v){
          list.add(AttendanceModel.fromJson(v));
        }),
        presentCount = int.tryParse(value.body['count']['present_count'].toString())??0,
        absentCount = int.tryParse(value.body['count']['absent_count'].toString())??0,
        letComing = int.tryParse(value.body['count']['let_coming'].toString())??0,
        isHoliday = isHolidayEvent(value.body['event'],currentDateTime: dateTime),
      }
    }).whenComplete(() => {
      getHistoryProcess = false,
      update(),
      // if(Get.isRegistered<HomeLogic>()){
      //   Get.find<HomeLogic>().getUsers(),
      // }
    });
  }

  void askGpsPermission() async {
    PermissionStatus status = await Permission.location.status;

    if(status.isGranted){
      enableGPS();
    }else{
      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        enableGPS();
      } else if (status.isDenied) {
        Toast.show(title: "Permission denied", toastMessage: "GPS permission denied",isError: true);
        punchingIn = false;
        punchingOut = false;
        update();
      } else if (status.isPermanentlyDenied) {
        Toast.show(title: "Permission denied", toastMessage: "Enable GPS permission manually",isError: true);
        punchingIn = false;
        punchingOut = false;
        update();
        openAppSettings();
      }else if(status.isRestricted){
        Toast.show(title: "Enable manually Permission", toastMessage: "GPS permission Restricted",isError: true);
        punchingIn = false;
        punchingOut = false;
        update();
        openAppSettings();
      }
    }
  }

  enableGPS() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings().then((value) => {
        if(value){
          determinePosition()
        }else{
          punchingIn = false,
          punchingOut = false,
          update()
        }
      }).catchError((onError){
        punchingIn = false;
        punchingOut = false;
        update();
      });
    } else {
      determinePosition();
    }
  }

  void determinePosition() async {
    await Geolocator.getCurrentPosition().then((value) => {
      checkRightLocation(value)
    }).catchError((e){
      Toast.show(toastMessage: "Try Again",isError: true,iconData: Icons.refresh);
      punchingIn = false;
      punchingOut = false;
      update();
    });
  }

  checkRightLocation(Position? position) async {
    if (position == null) {
      punchingIn = false;
      punchingOut = false;
      update();
      Toast.show(toastMessage: "Try Again",isError: true,iconData: Icons.refresh);
      return;
    }

    // Calculate the distance between the target location and the current position using the distanceTo method.
    double distanceInMeters = Geolocator.distanceBetween(
      targetLat,
      targetLong,
      position.latitude,
      position.longitude,
    );

    //this.position = position;

    if(distanceInMeters <= targetDistanceInMeters){
      if(attemptStep == AttemptStep.isAttemptIn){
        updateOutTime();
      }else{
        insertAttendance();
      }
    }else{
      Toast.show(toastMessage: "Your Location Not Marched",iconData: Icons.gps_fixed,isError: true);
    }
    punchingIn = false;
    punchingOut = false;
    update();
  }

}
