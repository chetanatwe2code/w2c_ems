import 'package:attendance/model/ProjectModel.dart';
import 'package:attendance/view/other/widget/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/TaskModel.dart';
import '../../../repository/project_repository.dart';
import '../../../utils/toast.dart';
import '../task/widget/change_status.dart';

class ProjectLogic extends GetxController implements GetxService {
 final ProjectRepository repository;
 ProjectLogic({required this.repository});

 @override
 void onInit() {
  super.onInit();
   getUsersList();
 }


 List<ProjectModel> model = [];
 bool toGet = false;
  getProject(){
   toGet = true;
   model.clear();
   update();
   repository.getProject(body: {}).then((value) => {
    if(value.body['success']){
     value.body['projects'].forEach((v) {
      model.add(ProjectModel.fromJson(v));
     }),
    },
   }).whenComplete(() => {
    toGet = false,
    update(),
   });

  }

 List<TaskModel> list = [];
 int? expandedIndex;
 getTask(String projectId,int index){
  expandedIndex = index;
  list.clear();
  update();
  repository.getTasks(body: {"project_id": projectId}).then((value) => {
   if(value.body['success']){
    value.body['tasks'].forEach((v) {
     list.add(TaskModel.fromJson(v));
    }),
   }
  }).whenComplete(() => update()
  );
 }

 clearIndex(){
  expandedIndex = null;
  list.clear();
  update();
 }

 List<DropDownModel> userItems = [];
 getUsersList(){
  userItems.clear();
  Get.find<ProjectRepository>().getUsersList().then((value) => {
   if(value.body['success']){
    value.body['users'].forEach((v) {
     userItems.add(DropDownModel(value: "${v['name']??""}",id: "${v['id']??0}"));
    }),
   },
  });
 }


 bool toCreateTask = false;
 createTask(int index, { dynamic body , Function? callback }){
  toCreateTask = true;
  update();
  repository.createTask(body: body).then((value) => {
   if(value.body['success']){
    getTask(body['project_id'],index),
    Toast.show(toastMessage: value.body['message']??"Successfully Added"),
    if(callback != null){
     callback(),
    }
   }else{
    Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
   }
  }).whenComplete(() => {
   toCreateTask = false,
   update(),
  });
 }

 int? changeIndex;
 changeStatus(int index,String status){
  changeIndex = index;
  update();
  bool isComplete = status == TaskStatus.complete.name;
  Get.find<ProjectRepository>().updateTask(body: { "id": list[index].id, "status" : status }).then((value) => {
   if(value.body['success']){
    list[index].status = status,
    Toast.show(toastMessage:  isComplete ? 'Mark Completed' : "Status Changed" , iconData: isComplete ? Icons.check_circle : Icons.refresh)
   }
  }).whenComplete(() => {
   changeIndex = null,
   update()
  });
 }

}
