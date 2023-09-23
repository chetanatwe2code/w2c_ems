import 'package:get/get.dart';

import 'logic.dart';

class AttendanceSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceSummaryLogic(apiClient: Get.find()));
  }
}
