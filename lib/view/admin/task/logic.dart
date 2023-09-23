import 'package:get/get.dart';

import '../../../model/TaskModel.dart';
import '../../../repository/project_repository.dart';

class TaskLogic extends GetxController {
  final ProjectRepository repository;
  TaskLogic({required this.repository});

  dynamic argumentData = Get.arguments;
  int? projectId;

  List<TaskModel> list = [];

  @override
  void onInit() {
    super.onInit();
    if(argumentData?['project_id'] != null){
      projectId = int.tryParse(argumentData!['project_id'].toString());
      getTask();
    }
  }

  getTask(){
    list.clear();
    repository.getTasks(body: {"project_id": projectId}).then((value) => {
      if(value.body['success']){
        value.body['tasks'].forEach((v) {
          list.add(TaskModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      update()
    });
  }

  // changeTaskStatus(String status){
  //   repository.updateTask(body: { "project_id": projectId, "status" : status }).then((value) => {
  //     if(value.body['success']){
  //       Toast.show(toastMessage: value.body['message']??"Successfully Added"),
  //     }else{
  //       Toast.show(toastMessage: value.body['message']??"Failed",isError: true),
  //     }
  //   }).whenComplete(() => {
  //     update()
  //   });
  // }

}
