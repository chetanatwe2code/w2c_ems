import 'package:attendance/core/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/login_repository.dart';
import '../../../utils/toast.dart';

class LoginLogic extends GetxController {
  final LoginRepository repository;
  LoginLogic({required this.repository});

  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController()..text = "12345";

  var loginInProcess = false.obs;
  login(){
    if(!kReleaseMode){
      if(numberController.text.isEmpty){
        numberController.text = "7089094141";
      }else{
        numberController.text = "8237988783";
      }
    }
    if(!isValid()) return;
    loginInProcess.value = true;
    repository.login({ "phone" : numberController.text, "password" : passwordController.text }).then((value) => {
      if(value.body['success']){
        repository.saveLoginData(value.body['data']['token']),
        Toast.show(toastMessage: value.body['message'] ?? "Login Success"),
        Get.offAllNamed(rsBasePage)
      }else{
        Toast.show(toastMessage: value.body['message'] ?? "Login Failed",isError: true),
      },
    }).catchError((onError){
      Toast.show(toastMessage: "${onError.message}");
      loginInProcess.value = false;
    }).whenComplete(() => {
      loginInProcess.value = false
    });
  }

  isValid(){
    if(numberController.text.isNotEmpty)
      if(passwordController.text.isNotEmpty)
        return true;
      else
        Toast.show(toastMessage: "Enter password", isError: true);
    else
      Toast.show(toastMessage: "Enter number", isError: true);

    return false;
  }
}
