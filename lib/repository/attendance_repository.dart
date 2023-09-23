import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class AttendanceRepository{
  final ApiClient apiClient;
  AttendanceRepository({required this.apiClient});

  Future<Response> getUsers({ dynamic body }) => apiClient.postAPI(ApiProvider.getUsers,body);

  Future<Response> attendanceByMonth({String? date }) => apiClient.getAPI("${ApiProvider.attendanceByMonth}${(date?.isNotEmpty??false)?"/$date":""}");

}