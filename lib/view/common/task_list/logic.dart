import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/TaskModel.dart';
import '../../../repository/project_repository.dart';
import '../../../utils/toast.dart';
import '../../admin/project/widget/task_view.dart';
import '../../other/widget/custom_dropdown.dart';

class TaskListLogic extends GetxController implements GetxService {
  final ProjectRepository repository;
  TaskListLogic({required this.repository});


  List<TaskModel> workingModel = [];
  List<TaskModel> completeModel = [];

  int? userId;
  String? userName;
  String? selectedName;

  setUser({ int? userId,String? userName }){
    this.userId = userId;
    this.userName = userName;
  }

  List<DropDownModel> dropdown = [];
  getUsersList(){
    dropdown.clear();
    Get.find<ProjectRepository>().getUsersList().then((value) => {
      if(value.body['success']){
        value.body['users'].forEach((v) {
          print("whenComplete 1 ${v['id']}");
          dropdown.add(DropDownModel(value: "${v['name']??""}",id: "${v['id']??""}"));
        }),
      },
    }).whenComplete((){
     // update();
      print("whenComplete ${userId == null ? null : "$userId"}");
    //  selectedName = "20";
      selectedName = userId == null ? null : "$userId";
      update();
    });
    // selectedName = userId == null ? null : "$userName";
  }

  clearUser(){
    userId = null;
    userName = null;
    selectedName = null;
    dropdown.clear();
  }
  refreshList(){
    getAllWorkingTask();
    getAllCompleteTask();
  }

  getAllWorkingTask({ String status = "working" }){
    workingModel.clear();
    update();
    dynamic body = {
      'status' : status,
      'user_id' : userId
    };
    repository.getAllTasks(body: body).then((value) => {
      if(value.body['success']){
        value.body['tasks'].forEach((v) {
          workingModel.add(TaskModel.fromJson(v));
        }),
      }
    }).whenComplete(() => update());
  }

  getAllCompleteTask({ String status = "complete" }){
    completeModel.clear();
    update();
    dynamic body = {
      'status' : status,
      'user_id' : userId
    };
    repository.getAllTasks(body: body).then((value) => {
      if(value.body['success']){
        value.body['tasks'].forEach((v) {
          completeModel.add(TaskModel.fromJson(v));
        }),
      }
    }).whenComplete(() => update()
    );
  }

  changeStatus(int index, String status,String? task, {bool isWorking = true}){
    update();
    bool isComplete = status == TaskStatus.complete.name;
    dynamic body = {
      "id": isWorking ? workingModel[index].id : completeModel[index].id,
      "status" : status
    };
    Get.find<ProjectRepository>().updateTask(body: body).then((value) => {
      if(value.body['success']){
        if(isWorking){
          workingModel[index].status = status,
        }else{
          completeModel[index].status = status,
        },
        Toast.show(title: task,toastMessage:  isComplete ? 'Mark Completed' : "Status Changed" , iconData: isComplete ? Icons.check_circle : Icons.refresh)
      }
    }).whenComplete(() => refreshList()
    );
  }

}
