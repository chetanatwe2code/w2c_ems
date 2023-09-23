import 'package:attendance/repository/account_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountRepository(apiClient: Get.find()));
    Get.lazyPut(() => ChangePasswordLogic(repository: Get.find()));
  }
}
