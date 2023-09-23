import 'package:attendance/repository/attendance_repository.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceRepository(apiClient: Get.find()));
    Get.lazyPut(() => AttendanceLogic(repository: Get.find()));
  }
}
