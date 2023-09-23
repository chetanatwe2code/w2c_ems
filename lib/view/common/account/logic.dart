import 'package:attendance/model/UserModel.dart';
import 'package:get/get.dart';

import '../../../core/di/api_provider.dart';
import '../../../core/routes.dart';
import '../../../repository/account_repository.dart';
import '../../admin/home/logic.dart';
import '../punching/logic.dart';

class AccountLogic extends GetxController implements GetxService {
  final AccountRepository repository;
  AccountLogic({required this.repository});


  UserModel? userModel;

  setUserModel(UserModel userModel){
    this.userModel = userModel;
    update();
  }

  getLoginUser(){
    repository.getUserDetail().then((value) => {
      if(value.body['success']){
        userModel = UserModel.fromJson(value.body['user']),
        update()
      }
    }).catchError((e){
      print("catchError $e");
    });
  }

  Future<void> logout() async{
    userModel = null;
    if(Get.isRegistered<HomeLogic>()){
      Get.find<HomeLogic>().clearData();
    }
    if(Get.isRegistered<PunchingLogic>()){
      Get.find<PunchingLogic>().clearData();
    }
    await repository.apiClient.sharedPreferences.remove(ApiProvider.preferencesToken);
    Get.offAllNamed(rsLoginPage);
  }
}
