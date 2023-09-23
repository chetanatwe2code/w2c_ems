import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/admin/project/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/ProjectModel.dart';
import '../../../repository/project_repository.dart';
import '../../../utils/toast.dart';

class CreateProjectLogic extends GetxController {
  final ProjectRepository repository;
  CreateProjectLogic({required this.repository});

  ProjectModel? model;

  dynamic argumentData = Get.arguments;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  initValue(){
    if(argumentData?['project'] != null){
      model = ProjectModel.fromJson(argumentData?['project']??{});
      nameController.text = model?.projectName??"";
      descriptionController.text = model?.description??"";
      startDate = "${model?.startDate}".toDateTime();
      endDate = "${model?.endDate}".toDateTime();
      leader = model?.teamLeaderId?.id != null ? "${model?.teamLeaderId?.id}" : null;
    }
    update();
  }

  bool toCreateProject = false;
  createProject(){
    if(!isValid()) return;

    dynamic body = {
      "project_name" : nameController.text,
      "description" : descriptionController.text,
      "start_date" : "${startDate!.year}-${startDate!.month}-${startDate!.day}",
      "end_date" : "${endDate!.year}-${endDate!.month}-${endDate!.day}",
      "team_leader_id" : "$leader",
      "status" :"progress"
    };
    toCreateProject = true;
    update();
    repository.createProject(body: body).then((value) => {
      print("value_value ${value.body}"),
      if(value.body['success']){
        if(Get.isRegistered<ProjectLogic>()){
          Get.find<ProjectLogic>().getProject()
        },
        Get.back(),
        Toast.show(toastMessage: value.body['message']??"Successfully Added"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
      }
    }).whenComplete(() => {
      toCreateProject = false,
      update()
    });
  }

  bool deleteProjectProcess = false;
  deleteProject(){
    dynamic body = {
      "id" : "${model?.id}",
    };
    print("MKT__ $body");

    deleteProjectProcess = true;
    update();

    repository.deleteProject(body: body).then((value) => {
      if(value.body['success']){
        Get.back(),
        Toast.show(toastMessage: "Delete Success"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
      }
    }).whenComplete(() => {
      Get.find<ProjectLogic>().getProject(),
      deleteProjectProcess = false,
      update()
    });
  }


  isValid(){
      if(nameController.text.isNotEmpty)
        if(descriptionController.text.isNotEmpty)
          if(startDate != null)
            if(endDate != null)
              if(leader?.isNotEmpty??false)
                    return true;
                  else
                    Toast.show(toastMessage: "select leader", isError: true);
                else
                  Toast.show(toastMessage: "select End Date", isError: true);
              else
            Toast.show(toastMessage: "select Start Date", isError: true);
            else
              Toast.show(toastMessage: "Enter description", isError: true);
          else
            Toast.show(toastMessage: "Enter name", isError: true);

    return false;
  }


  String? leader;
  List<DropdownMenuItem<String>> userItems = [];
  getUsersList(){
    userItems.clear();
    leader = null;
    repository.getUsersList().then((value) => {
      if(value.body['success']){
        value.body['users'].forEach((v) {
          userItems.add(DropdownMenuItem(value: "${v['id']??0}", child: Text("${v['name']??""}",
          style: const TextStyle(
              fontSize: 14
          ),)),);
        }),
      },
    }).whenComplete(() => {
      initValue(),
    });
  }

  bool toUpdateProject = false;
  updateProject(){
    if(!isValid()) return;

    dynamic body = {
      "id" : model?.id,
      "project_name" : nameController.text,
      "description" : descriptionController.text,
      "start_date" : "${startDate!.year}-${startDate!.month}-${startDate!.day}",
      "end_date" : "${endDate!.year}-${endDate!.month}-${endDate!.day}",
      "team_leader_id" : "$leader",
      "status" :"progress"
    };

    toUpdateProject = true;

    repository.updateProject(body: body).then((value) => {
      if(value.body['success']){
        Get.back(),
        Toast.show(toastMessage: "Updated Success"),
      }
    }).whenComplete(() => {
      Get.find<ProjectLogic>().getProject(),
      toUpdateProject = false,
      update()
    });
  }
}
