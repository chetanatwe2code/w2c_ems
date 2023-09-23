import 'package:attendance/repository/project_repository.dart';
import 'package:attendance/repository/punching_repository.dart';
import 'package:attendance/view/admin/project/logic.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/account_repository.dart';
import '../../repository/application_repository.dart';
import '../../repository/attendance_repository.dart';
import '../../repository/holiday_repository.dart';
import '../../repository/home_repository.dart';
import '../../repository/leaves_repository.dart';
import '../../view/admin/applications/logic.dart';
import '../../view/admin/attendance/logic.dart';
import '../../view/admin/create_project/binding.dart';
import '../../view/admin/holiday/logic.dart';
import '../../view/admin/home/logic.dart';
import '../../view/admin/project/binding.dart';
import '../../view/base/base_logic.dart';
import '../../view/common/account/logic.dart';
import '../../view/common/punching/logic.dart';
import '../../view/common/task_list/logic.dart';
import '../../view/employee/leaves/logic.dart';
import 'api_client.dart';
import 'api_provider.dart';

Future<void> init() async {

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences, permanent: true);
  Get.put(ApiClient(sharedPreferences: Get.find(),apkBaseUrl: ApiProvider.baseUrl), permanent: true);

  // Repository
  Get.lazyPut(() => AccountRepository(apiClient: Get.find()));
  Get.lazyPut(() => HomeRepository(apiClient: Get.find()));
  Get.lazyPut(() => PunchingRepository(apiClient: Get.find()));
  Get.lazyPut(() => ApplicationRepository(apiClient: Get.find()));
  Get.lazyPut(() => HolidayRepository(apiClient: Get.find()));
  Get.lazyPut(() => ProjectRepository(apiClient: Get.find()));
  Get.lazyPut(() => LeavesRepository(apiClient: Get.find()));
  Get.lazyPut(() => AttendanceRepository(apiClient: Get.find()));

  // Getx Controller And GetxService
  Get.lazyPut(() => BaseLogic());
  Get.lazyPut(() => AccountLogic(repository: Get.find()));
  Get.lazyPut(() => HomeLogic(repository: Get.find()));
  Get.lazyPut(() => ApplicationsLogic(repository: Get.find()));
  Get.lazyPut(() => LeavesLogic(repository: Get.find()));
  Get.lazyPut(() => HolidayLogic(repository: Get.find()));
  Get.lazyPut(() => PunchingLogic(repository: Get.find()));
  Get.lazyPut(() => ProjectLogic(repository: Get.find()));
  Get.lazyPut(() => TaskListLogic(repository: Get.find()));
  Get.lazyPut(() => AttendanceLogic(repository: Get.find()));

}