import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class ApplicationRepository{
  final ApiClient apiClient;
  ApplicationRepository({required this.apiClient});

  Future<Response> getAdminLeaves() => apiClient.getAPI(ApiProvider.getAdminLeaves);
  Future<Response> leavesUpdate(dynamic body,int? id) => apiClient.postAPI("${ApiProvider.leavesUpdate}/$id",body);

}