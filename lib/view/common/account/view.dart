import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/other/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes.dart';
import 'logic.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: Center(
        child: GetBuilder<AccountLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 50,),

                const Icon(Icons.person, size: 100,),

                const SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(logic.userModel?.name??"",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),),
                    IconButton(onPressed: (){
                      Get.toNamed(rsEditProfilePage);
                    }, icon:  const Icon(Icons.edit,),)
                  ],
                ),

                Text(logic.userModel?.institutionId?.name??"",
                  style: const TextStyle(
                      fontSize: 17,
                    color: AppColors.secondaryDark
                  ),),

                const SizedBox(height: 15,),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),

                const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.phone,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text(logic.userModel?.phone??"")
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.email,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text(logic.userModel?.email??"")
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.account_circle,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text((logic.userModel?.role??"").toCapitalizeFirstLetter(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.cake,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text((logic.userModel?.dateOfBirth??"").toDateDMMMY(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.male,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text((logic.userModel?.gender??"").toCapitalizeFirstLetter(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    text: "Change Password",
                    fontColor: AppColors.whiteColor(),
                    fontWeight: FontWeight.bold,
                    iconData: Icons.lock,
                    onTap: (){
                      Get.toNamed(rsChangePasswordPage);
                    },
                  ),
                )

              ],
            );
          },
        ),
      ),
    );
  }
}
