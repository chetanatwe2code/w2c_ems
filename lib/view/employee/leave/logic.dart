import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../repository/leaves_repository.dart';
import '../../../utils/toast.dart';
import '../leaves/logic.dart';

class LeaveLogic extends GetxController {
  final LeavesRepository repository;
  LeaveLogic({required this.repository});

  String? leaveType;
  String? leaveTime;

  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController reasonController = TextEditingController();

  bool isSubmitting = false;
  addLeave(){
    if(!isValid()) return;
    dynamic body = {
      "leave_type" : leaveType,
      "leave_time" : leaveTime,
      "reason" : reasonController.text,
      "start_date" : "${startDate!.year}-${startDate!.month}-${startDate!.day}",
      "end_date" : endDate == null ? null : "${endDate!.year}-${endDate!.month}-${endDate!.day}",
    };
    isSubmitting = true;
    update();

    repository.leaveAdd(body: body).then((value) => {
      print("addLeave ${value.body}"),
      if(value.body['success'] == true){
        if(Get.isRegistered<LeavesLogic>()){
          Get.find<LeavesLogic>().getLeaves()
        },
        Get.back(),
      },
      Toast.show(toastMessage: value.body['message'],isError: value.body['success'] == false)
    }).whenComplete(() => {
      isSubmitting = false,
      update()
    });
  }

  isValid(){
    if(leaveType?.isNotEmpty??false)
      if(reasonController.text.isNotEmpty)
        if(leaveTime?.isNotEmpty??false)
          if(startDate != null)
            return true;
          else
            Toast.show(toastMessage: "pick Leave Date", isError: true);
        else
          Toast.show(toastMessage: "Select Leave Time", isError: true);
      else
        Toast.show(toastMessage: "Enter Leave Reason", isError: true);
    else
      Toast.show(toastMessage: "Select Leave Type", isError: true);

    return false;
  }

}
