import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes.dart';
import '../../../repository/sign_up_page_repository.dart';
import '../../../utils/email_validator.dart';
import '../../../utils/toast.dart';

enum Gender { male , female, other }

Gender? getGender(String? string){
  if(string == Gender.male.name){
    return Gender.male;
  }else if(string == Gender.female.name){
    return Gender.female;
  }
  return null;
}

class SignUpLogic extends GetxController {
  final SignUpRepository repository;
  SignUpLogic({required this.repository});

  int? createdBy;
  dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    createdBy = argumentData?['created_by'];
    super.onInit();
  }

  String? institutionItem;
  String? gender;
  DateTime? dateOfBirth;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController()..text = "12345";

  bool loginInProcess = false;

  signup(){
    if(!isValid()) return;

    dynamic body = {
      "name" : nameController.text,
      "email" : emailController.text,
      "phone" : numberController.text,
      "password" : passwordController.text,
      "institution_id" : institutionItem,
      "gender" : gender,
      "date_of_birth" : "${dateOfBirth!.year}-${dateOfBirth!.month}-${dateOfBirth!.day}",
    };

    loginInProcess = true;
    update();

    repository.signup(body: body).then((value) => {
      if(value.body['success']){
        repository.saveSignUpData(value.body['data']['token']),
        Toast.show(toastMessage: value.body['message'] ?? "Signup Success"),
        Get.offAllNamed(rsBasePage)
      }else{
        Toast.show(toastMessage: value.body['message'] ?? "Signup Failed",isError: true),
      },
    }).whenComplete(() => {
      loginInProcess = false,
      update()
    });
  }

  createEmployee(){
    if(!isValid()) return;

    dynamic body = {
      "name" : nameController.text,
      "email" : emailController.text,
      "phone" : numberController.text,
      "password" : passwordController.text,
      "institution_id" : institutionItem,
      "gender" : gender,
      "date_of_birth" : "${dateOfBirth!.year}-${dateOfBirth!.month}-${dateOfBirth!.day}",
    };

    loginInProcess = true;
    update();

    repository.employeeCreate(body: body).then((value) => {
      if(value.body['success']){
        Get.back(),
        Toast.show(toastMessage:  value.body['message'] ?? "Employee Created"),
      }else{
        Toast.show(toastMessage:  value.body['message'] ?? "Failed",isError: true),
        loginInProcess = false,
        update()
      },
    });
  }

  isValid(){
    if(institutionItem?.isNotEmpty??false)
      if(nameController.text.isNotEmpty)
        if(emailController.text.isNotEmpty)
          if(EmailValidator.validate(emailController.text))
            if(numberController.text.isNotEmpty)
              if(passwordController.text.isNotEmpty)
                if(gender != null)
                  if(dateOfBirth != null)
                    return true;
                  else
                    Toast.show(toastMessage: "select birth date", isError: true);
                else
                  Toast.show(toastMessage: "select gender", isError: true);
              else
                Toast.show(toastMessage: "Enter password", isError: true);
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
