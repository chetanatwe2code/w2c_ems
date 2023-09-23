import 'package:get/get.dart';

import 'logic.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskLogic(repository: Get.find()));
  }
}
