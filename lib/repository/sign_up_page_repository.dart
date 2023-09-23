import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/di/get_di.dart' as di;

class SignUpRepository{
  final ApiClient apiClient;
  SignUpRepository({required this.apiClient});


  Future<Response> signup({ dynamic body }) async => await  apiClient.postAPI(ApiProvider.signup,body);

  Future<Response> employeeCreate({ dynamic body }) async => await apiClient.postAPI(ApiProvider.employeeCreate,body);

  Future<void> saveSignUpData(String token) async{
    await di.init();
    apiClient.updateHeader(token);
    await apiClient.sharedPreferences.setString(ApiProvider.preferencesToken,token);
  }

}