import 'package:attendance/core/di/api_provider.dart';
import 'package:get/get.dart';
import '../core/di/api_client.dart';

enum AttemptStep { none, isAttemptIn, isAttemptBoth }

class HomeRepository{
  final ApiClient apiClient;
  HomeRepository({required this.apiClient});


  Future<Response> getUsers({ dynamic body }) => apiClient.postAPI(ApiProvider.getUsers,body);

  Future<Response> attendanceByMonth({String? date }) => apiClient.getAPI("${ApiProvider.attendanceByMonth}${(date?.isNotEmpty??false)?"/$date":""}");

  Future<Response> attendanceByDate({String? date }) => apiClient.getAPI("${ApiProvider.attendanceByDate}${(date?.isNotEmpty??false)?"/$date":""}");

  Future<Response> getHolidayByMonth({String? date }) => apiClient.getAPI("${ApiProvider.getHolidayByMonth}${(date?.isNotEmpty??false)?"/$date":""}");

  Future<Response> getLeavesByMonth({String? date }) => apiClient.getAPI("${ApiProvider.getLeavesByMonth}${(date?.isNotEmpty??false)?"/$date":""}");

  Future<Response> userWithTasksCount() => apiClient.getAPI(ApiProvider.userWithTasksCount);


}