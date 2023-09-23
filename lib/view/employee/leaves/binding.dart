import 'package:get/get.dart';

import '../../../repository/leaves_repository.dart';
import 'logic.dart';

class LeavesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeavesRepository(apiClient: Get.find()));
    Get.lazyPut(() => LeavesLogic(repository: Get.find()));
  }
}
