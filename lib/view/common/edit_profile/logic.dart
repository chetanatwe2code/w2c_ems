import 'package:attendance/model/UserModel.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/admin/employee/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/account_repository.dart';
import '../../../utils/email_validator.dart';
import '../../../utils/toast.dart';
import '../../auth/sign_up/logic.dart';
import '../account/logic.dart';

class EditProfileLogic extends GetxController {
  final AccountRepository repository;
  EditProfileLogic({required this.repository});

  dynamic argumentData = Get.arguments;

  String? institutionItem;
  Gender? gender;
  DateTime? dateOfBirth;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  bool updatingInProcess = false;

  UserModel? userModel;
  bool itself = true;
  @override
  void onInit() {
    super.onInit();
    if(argumentData?['user'] != null){
      itself = false;
      userModel = UserModel.fromJson(argumentData!['user']??{});
    }else{
      userModel = Get.find<AccountLogic>().userModel;
    }
    initValue();
  }

  initValue(){
    gender = getGender(userModel?.gender);
    dateOfBirth = "${userModel?.dateOfBirth}".toDateTime();
    nameController.text = userModel?.name??"";
    emailController.text = userModel?.email??"";
    numberController.text = userModel?.phone??"";
    institutionItem = "1";
  }

  editUser(){
    if(!isValid()) return;
    updatingInProcess = true;
    update();
    dynamic body = {
      "name" : nameController.text,
      "email" : emailController.text,
      "phone" : numberController.text,
      "institution_id" : institutionItem,
      "gender" : gender!.name,
      "date_of_birth" : "${dateOfBirth!.year}-${dateOfBirth!.month}-${dateOfBirth!.day}",
    };
    repository.editUser(body).then((value) => {
      if(value.body['success']){
        Get.back(),
        Toast.show(toastMessage: "Updated Success"),
      }
    }).whenComplete(() => {
      Get.find<AccountLogic>().getLoginUser(),
      updatingInProcess = false,
      update(),

    });
  }

  updateUser(){
    if(!isValid()) return;
    updatingInProcess = true;
    update();
    dynamic body = {
      "id": userModel?.id,
      "name" : nameController.text,
      "email" : emailController.text,
      "phone" : numberController.text,
      "institution_id" : institutionItem,
      "gender" : gender!.name,
      "date_of_birth" : "${dateOfBirth!.year}-${dateOfBirth!.month}-${dateOfBirth!.day}",
    };
    repository.updateUser(body).then((value) => {
      if(value.body['success']){
        Get.back(),
        Toast.show(toastMessage: "Updated Success"),
      }
    }).whenComplete(() => {
      Get.find<EmployeeLogic>().getUsersList(),
      updatingInProcess = false,
      update(),

    });
  }

  isValid(){
    if(institutionItem?.isNotEmpty??false)
      if(nameController.text.isNotEmpty)
        if(emailController.text.isNotEmpty)
          if(EmailValidator.validate(emailController.text))
            if(numberController.text.isNotEmpty)
                if(gender != null)
                  if(dateOfBirth != null)
                    return true;
                  else
                    Toast.show(toastMessage: "select birth date", isError: true);
                else
                  Toast.show(toastMessage: "select gender", isError: true);
            else
              Toast.show(toastMessage: "Enter number", isError: true);
          else
            Toast.show(toastMessage: "Enter valid email", isError: true);
        else
          Toast.show(toastMessage: "Enter email", isError: true);
      else
        Toast.show(toastMessage: "Enter name", isError: true);
    else
      Toast.show(toastMessage: "select institution", isError: true);

    return false;
  }

}
