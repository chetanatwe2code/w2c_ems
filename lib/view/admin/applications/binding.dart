import 'package:attendance/repository/application_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ApplicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplicationsLogic(repository: Get.find<ApplicationRepository>()));
  }
}
