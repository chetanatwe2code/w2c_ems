import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

//
class ProjectRepository{
  final ApiClient apiClient;
  ProjectRepository({required this.apiClient});

  Future<Response> createProject({ dynamic body }) => apiClient.postAPI(ApiProvider.createProject,body);

  Future<Response> updateProject({ dynamic body }) => apiClient.putAPI(ApiProvider.updateProject,body);

  Future<Response> deleteProject({ dynamic body }) => apiClient.postAPI("${ApiProvider.deleteProject}/${body['id']}",body);

  Future<Response> getProject({ dynamic body }) => apiClient.postAPI(ApiProvider.getProject,body);

  Future<Response> getUsersList() => apiClient.getAPI(ApiProvider.getUsersList);


  /// task
  Future<Response> createTask({ dynamic body }) => apiClient.postAPI(ApiProvider.createTask,body);

  Future<Response> updateTask({ dynamic body }) => apiClient.putAPI(ApiProvider.updateTask,body);

  Future<Response> deleteTask({ dynamic body }) => apiClient.postAPI("${ApiProvider.deleteTask}/${body['id']}",body);

  Future<Response> getTasks({ dynamic body }) => apiClient.postAPI(ApiProvider.getTasks,body);

  Future<Response> getAllTasks({ dynamic body }) => apiClient.postAPI(ApiProvider.getAllTasks , body);


}