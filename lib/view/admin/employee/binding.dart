import 'package:attendance/repository/employee_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeRepository(apiClient: Get.find()));
    Get.lazyPut(() => EmployeeLogic(repository: Get.find()));
  }
}
