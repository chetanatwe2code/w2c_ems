import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class LeavesRepository{
  final ApiClient apiClient;
  LeavesRepository({required this.apiClient});


  Future<Response> leaveAdd({ dynamic body }) => apiClient.postAPI(ApiProvider.leaveAdd,body);
  Future<Response> leaveGet({ dynamic body }) => apiClient.getAPI(ApiProvider.leaveGet);

}