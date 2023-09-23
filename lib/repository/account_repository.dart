import 'package:attendance/core/di/api_provider.dart';
import 'package:get/get.dart';

import '../core/di/api_client.dart';

class AccountRepository{
  final ApiClient apiClient;
  AccountRepository({required this.apiClient});


  // ProjectRepository
  Future<Response> getUserDetail() async {
    return apiClient.getAPI(ApiProvider.getUserDetail);
  }

  Future<Response> editUser(dynamic body) async => apiClient.putAPI(ApiProvider.getUpdate,body);

  Future<Response> updateUser(dynamic body) async => apiClient.putAPI(ApiProvider.updateUser,body);

  Future<Response> changePassword(dynamic body) async => apiClient.postAPI(ApiProvider.changePassword,body);

}