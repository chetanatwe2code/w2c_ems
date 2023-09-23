import 'package:get/get.dart';

import '../../../repository/project_repository.dart';
import 'logic.dart';

class CreateProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectRepository(apiClient: Get.find()));
    Get.lazyPut(() => CreateProjectLogic(repository: Get.find()));
  }
}
