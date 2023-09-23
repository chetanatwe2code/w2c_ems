import 'package:get/get.dart';

import '../../../model/EmployeeModel.dart';
import '../../../repository/employee_repository.dart';

class EmployeeLogic extends GetxController {
  final EmployeeRepository repository;
  EmployeeLogic({required this.repository});

  List<EmployeeModel> empList = [];

  bool getUsersListProcess = false;
  getUsersList(){
    getUsersListProcess = true;
    empList.clear();

    repository.getUsersList().then((value) => {
      if(value.body['success']){
        value.body['users'].forEach((v) {
          print("______FFF___ ${v['id']} / ${v['name']}");
          empList.add(EmployeeModel.fromJson(v));
        }),
      },
    }).whenComplete(() => {
      getUsersListProcess = false,
      update()
    });
  }

  bool deleteProcess = false;
  deleteUser(String userId){
    deleteProcess = true;
    update();
    repository.deleteUser({
      "id":userId
    }).then((value) => {

    }).whenComplete(() => {
      deleteProcess = true,
      update()
    });

  }


}
