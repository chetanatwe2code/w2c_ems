import 'package:get/get.dart';

import 'logic.dart';

class TaskListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskListLogic(repository: Get.find()));
  }
}
