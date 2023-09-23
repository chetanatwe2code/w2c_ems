import 'package:get/get.dart';

import 'logic.dart';

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTaskLogic(repository: Get.find()));
  }
}
