import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/di/get_di.dart' as di;

class LoginRepository{
  final ApiClient apiClient;
  LoginRepository({required this.apiClient});

  // Method to check login by number and email
  Future<Response> login(dynamic body) async {
   return await apiClient.postAPI(ApiProvider.login, body);
  }

  saveLoginData(String token) async{
    await di.init();
    apiClient.updateHeader(token);
    await apiClient.sharedPreferences.setString(ApiProvider.preferencesToken,token);
  }
}