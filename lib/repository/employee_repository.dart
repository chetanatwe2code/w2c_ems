import 'package:attendance/core/di/api_provider.dart';
import 'package:get/get.dart';

import '../core/di/api_client.dart';

class EmployeeRepository{
  final ApiClient apiClient;
  EmployeeRepository({required this.apiClient});

  Future<Response> getUsersList() => apiClient.getAPI(ApiProvider.getUsersList);

  Future<Response> deleteUser(dynamic body) => apiClient.postAPI(ApiProvider.deleteUser,body);

  Future<Response> approveUser(dynamic body) => apiClient.putAPI(ApiProvider.approveUser,body);

}