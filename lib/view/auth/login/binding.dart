import 'package:attendance/repository/login_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRepository(apiClient: Get.find()));
    Get.lazyPut(() => LoginLogic(repository: Get.find()));
  }
}
