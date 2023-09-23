import 'package:attendance/view/common/punching/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_input.dart';
import 'logic.dart';

class ChangePasswordPage extends GetView<ChangePasswordLogic> {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Change Password"),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            CustomInput(
              textController: controller.passwordController,
              keyboardType: TextInputType.text,
              hintText: "Enter Password",
              suffixIcon: const Icon(Icons.lock),
            ),

            const SizedBox(height: 20,),

            CustomInput(
              textController: controller.confirmPasswordController,
              keyboardType: TextInputType.text,
              hintText: "Enter Confirm Password",
              suffixIcon: const Icon(Icons.lock),
            ),

            const SizedBox(height: 20,),

            GetBuilder<ChangePasswordLogic>(
              assignId: true,
              builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    text: "Change Password",
                    fontColor: AppColors.whiteColor(),
                    fontWeight: FontWeight.bold,
                    iconData: Icons.lock,
                    isLoading: logic.toChange,
                    onTap: () {
                      logic.changePassword();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
