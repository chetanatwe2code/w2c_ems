import 'package:attendance/repository/sign_up_page_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpRepository(apiClient: Get.find()));
    Get.lazyPut(() => SignUpLogic(repository: Get.find()));
  }
}
