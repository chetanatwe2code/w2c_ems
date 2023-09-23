import 'package:get/get.dart';

import 'logic.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveLogic(repository: Get.find()));
  }
}
