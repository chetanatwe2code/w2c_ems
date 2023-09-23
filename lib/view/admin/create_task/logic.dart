import 'package:attendance/model/TaskModel.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/admin/task/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/project_repository.dart';
import '../../../utils/toast.dart';

class CreateTaskLogic extends GetxController {
  final ProjectRepository repository;
  CreateTaskLogic({required this.repository});

  dynamic argumentData = Get.arguments;

  int? projectId;
  TaskModel? model;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? dueDate;

  String? priority;
  List<DropdownMenuItem<String>> priorities = [
    const DropdownMenuItem(value: "low", child: Text("Low",
      style: TextStyle(
          fontSize: 14
      ),)),
    const DropdownMenuItem(value: "medium", child: Text("Medium",
      style: TextStyle(
          fontSize: 14
      ),)),
    const DropdownMenuItem(value: "high", child: Text("High",
      style: TextStyle(
          fontSize: 14
      ),)),
  ];


  String? assign;
  List<DropdownMenuItem<String>> userItems = [];
  getUsersList(){
    userItems.clear();
    Get.find<ProjectRepository>().getUsersList().then((value) => {
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


  initValue(){
    if(argumentData?['project_id'] != null){
      projectId = int.tryParse(argumentData!['project_id'].toString());
    }
    if(argumentData?['task'] != null){
      model = TaskModel.fromJson(argumentData!['task']);
      nameController.text = model?.taskName??"";
      descriptionController.text = model?.description??"";
      dueDate = "${model?.dueDate}".toDateTime();
      assign = model?.assign?.id != null ? "${model?.assign?.id}" : null;
      priority = model?.priority != null ? "${model?.priority}" : null;
    }
    update();
  }

  bool toCreateTask = false;
  createTask(){
    if(!isValid()) return;

    dynamic body = {
      "project_id" : "$projectId",
      "task_name" : nameController.text,
      "description" : descriptionController.text,
      "assign" : "$assign",
      "priority" : "$priority",
      "due_date" : "${dueDate!.year}-${dueDate!.month}-${dueDate!.day}",
      "status":"pending",
    };
    print("MKT__ $body");

    toCreateTask = true;
    update();

    repository.createTask(body: body).then((value) => {
      if(value.body['success']){
        if(Get.isRegistered<TaskLogic>()){
          Get.find<TaskLogic>().getTask()
        },
        Get.back(),
        Toast.show(toastMessage: value.body['message']??"Successfully Added"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
      }
    }).whenComplete(() => {
      toCreateTask = false,
      update(),
    });
  }

  updateTask(){
    if(!isValid()) return;

    dynamic body = {
      "id" : "${model?.id}",
      "project_id" : "$projectId",
      "task_name" : nameController.text,
      "description" : descriptionController.text,
      "assign" : "$assign",
      "priority" : "$priority",
      "due_date" : "${dueDate!.year}-${dueDate!.month}-${dueDate!.day}",
      "status": "${model?.status}",
    };
    print("MKT__ $body");

    toCreateTask = true;
    update();

    repository.updateTask(body: body).then((value) => {
      if(value.body['success']){
        if(Get.isRegistered<TaskLogic>()){
          Get.find<TaskLogic>().getTask()
        },
        Get.back(),
        Toast.show(toastMessage: value.body['message']??"Successfully Added"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
      }
    }).whenComplete(() => {
      toCreateTask = false,
      update(),
    });
  }

  bool deleteTaskProcess = false;
  deleteTask(){
    dynamic body = {
      "id" : "${model?.id}",
      "project_id" : "$projectId"
    };
    print("MKT__ $body");

    deleteTaskProcess = true;
    update();

    repository.deleteTask(body: body).then((value) => {
      if(value.body['success']){
        if(Get.isRegistered<TaskLogic>()){
          Get.find<TaskLogic>().getTask()
        },
        Get.back(),
        Toast.show(toastMessage: value.body['message']??"Delete Added"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
      }
    }).whenComplete(() => {
      deleteTaskProcess = false,
      update(),
    });
  }

  isValid(){
    if(nameController.text.isNotEmpty)
      if(descriptionController.text.isNotEmpty)
        if(assign != null)
          if(priority != null)
          if(dueDate != null)
              return true;
            else
              Toast.show(toastMessage: "select Due Date", isError: true);
          else
            Toast.show(toastMessage: "set priority", isError: true);
        else
          Toast.show(toastMessage: "which employee assign?", isError: true);
      else
        Toast.show(toastMessage: "Enter description", isError: true);
    else
      Toast.show(toastMessage: "Enter name", isError: true);

    return false;
  }

}
