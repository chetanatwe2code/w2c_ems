

import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class PunchingRepository{
  final ApiClient apiClient;
  PunchingRepository({required this.apiClient});

  Future<Response> getAttemptStatus({ dynamic body }) async {
    return await apiClient.postAPI(ApiProvider.getAttemptStatus,body);
  }

  // Method to insert a new user into the USER_TABLE
  Future<Response> markAttendance({ dynamic body }) async {
    return apiClient.postAPI(ApiProvider.markAttendance, body);
  }

  // Method to insert a new user into the USER_TABLE
  Future<Response> insertAttendance({ dynamic body }) async {
    return apiClient.postAPI(ApiProvider.insertAttendance, body);
  }

  // Method to insert a new user into the USER_TABLE
  Future<Response> updateOutTime(String id,{ dynamic body }) async {
    return apiClient.postAPI(ApiProvider.updateOutTime+id,{});
  }

  // Method to get all users from the USER_TABLE
  Future<Response> getHistory({ dynamic body }) async {
    return apiClient.postAPI(ApiProvider.getHistory, body);
  }
}