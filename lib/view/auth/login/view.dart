import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/assets.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_input.dart';
import 'logic.dart';

class LoginPage extends GetView<LoginLogic> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 100,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(appLogo,width: 50,height: 50,),
                ],
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    child: Text(appName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        color: Colors.white
                      ),),
                  ),
                ],
              ),

              const SizedBox(height: 80,),


              const Text("Login your account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),),


              const SizedBox(height: 30,),

              const Text("Phone Number",
                style: TextStyle(
                    fontSize: 12
                ),),
              const SizedBox(height: 2,),
              CustomInput(
                textController: controller.numberController,
                keyboardType: TextInputType.number,
                hintText: "Enter Number",
                maxLength: 10,
                suffixIcon: const Icon(Icons.phone),
              ),

              const SizedBox(height: 20,),

              const Text("Password",
                style: TextStyle(
                    fontSize: 12
                ),),
              const SizedBox(height: 2,),
              CustomInput(
                textController: controller.passwordController,
                keyboardType: TextInputType.text,
                hintText: "Enter Password",
                suffixIcon: const Icon(Icons.lock),
              ),

              const SizedBox(height: 40,),

              Obx(() {
                return CustomButton(
                  borderRadius: 5,
                  text: "Login",
                  isLoading: controller.loginInProcess.value,
                  fontColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    controller.login();
                  },
                );
              }),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have a Account".tr,
                    style: const TextStyle(
                        color: AppColors.text2,
                        fontSize: 16
                    ),),
                  const SizedBox(width: 2,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(rsSignUpPage);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text("SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.text2,
                            fontSize: 15
                        ),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
