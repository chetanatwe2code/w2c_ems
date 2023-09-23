import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class HolidayRepository{
  final ApiClient apiClient;
  HolidayRepository({required this.apiClient});

  Future<Response> getHolidays() => apiClient.getAPI(ApiProvider.getHolidays);

  Future<Response> storeHoliday(dynamic body) => apiClient.postAPI(ApiProvider.storeHoliday,body);

  Future<Response> updateHoliday(dynamic body,int? id) => apiClient.postAPI("${ApiProvider.updateHoliday}/$id",body);

  Future<Response> destroyHoliday(int? id) => apiClient.deleteAPI("${ApiProvider.destroyHoliday}/$id");


}