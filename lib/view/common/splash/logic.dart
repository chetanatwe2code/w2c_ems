import 'dart:async';

import 'package:get/get.dart';

import '../../../core/di/api_client.dart';
import '../../../core/di/api_provider.dart';
import '../../../core/routes.dart';


class SplashLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  SplashLogic({required this.apiClient});


  checkLogin(){
    Timer(const Duration(seconds: 4),isLoggedIn);
  }

  /// SessionController
  isLoggedIn() async{
    if(apiClient.sharedPreferences.containsKey(ApiProvider.preferencesToken)){
      Get.offNamed(rsBasePage);
    }else{
      Get.offNamed(rsLoginPage);
    }
  }
}
