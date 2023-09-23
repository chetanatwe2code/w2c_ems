import 'package:get/get.dart';

import '../../../repository/punching_repository.dart';
import 'logic.dart';

class PunchingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PunchingRepository(apiClient: Get.find()));
    Get.lazyPut(() => PunchingLogic(repository: Get.find()));
  }
}
