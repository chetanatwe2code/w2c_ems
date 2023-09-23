import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/account_repository.dart';
import '../../../utils/toast.dart';

class ChangePasswordLogic extends GetxController {
  final AccountRepository repository;
  ChangePasswordLogic({required this.repository});

  final TextEditingController passwordController = TextEditingController();//..text = "12345";
  final TextEditingController confirmPasswordController = TextEditingController();//..text = "12345";


  bool toChange = false;
  changePassword(){
    if(!isValid()) return;
    toChange = true;
    update();
    repository.changePassword({ "password" : passwordController.text }).then((value) => {
      if(value.body['success']){
        Get.back(),
        Toast.show(toastMessage: value.body['message']??"Password Changed"),
      }else{
        Toast.show(toastMessage: value.body['message']??"Failed",isError: true)
      },
    }).whenComplete(() => {
      toChange = false,
      update()
    });
  }
  //
  isValid(){
    if(passwordController.text.isNotEmpty)
      if(confirmPasswordController.text.isNotEmpty)
      if(confirmPasswordController.text == passwordController.text)
        return true;
      else
        Toast.show(toastMessage: "Confirm Password not matched", isError: true);
      else
        Toast.show(toastMessage: "Enter Confirm Password", isError: true);
    else
      Toast.show(toastMessage: "Enter Password", isError: true);

    return false;
  }

}
