import 'package:attendance/repository/project_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EmployeeTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectRepository(apiClient: Get.find()));
    Get.lazyPut(() => EmployeeTaskLogic(repository: Get.find()));
  }
}
