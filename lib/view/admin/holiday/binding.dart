import 'package:get/get.dart';

import 'logic.dart';

class HolidayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HolidayLogic(repository: Get.find()));
  }
}
