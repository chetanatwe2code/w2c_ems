import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../utils/assets.dart';
import '../../employee/leave/view.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_dropdown.dart';
import '../../other/widget/custom_input.dart';
import 'logic.dart';

class SignUpPage extends GetView<SignUpLogic> {
  const SignUpPage({Key? key}) : super(key: key);

  List<DropDownModel> get institutionItems {
    List<DropDownModel> menuItems = [
      DropDownModel(value: "We2code Technology Private Limited",id: "1"),
    ];
    return menuItems;
  }

  List<DropDownModel> get genderItems {
    List<DropDownModel> menuItems = [
      DropDownModel(value: "Male",id: Gender.male.name),
      DropDownModel(value: "Female",id: Gender.female.name),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: GetBuilder<SignUpLogic>(
        assignId: true,
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                if(logic.createdBy != null)...[
                  AppBar( title: const Text("Create Employee"), ),
                ]else...[
                  Column(
                    children: [

                      const SizedBox(height: 55,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(appLogo, width: 50, height: 50,),
                        ],
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                borderRadius: const BorderRadius.all(Radius.circular(
                                    5))
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Text("Signup",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white
                              ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(height: 30,),


                      const Text("Institution",
                        style: TextStyle(
                            fontSize: 12
                        ),),
                      const SizedBox(height: 2,),
                      CustomDropDown(
                        list: institutionItems,
                        height: 45,
                        dropdownWidth: Get.width*0.7,
                        hint: "Institution",
                        padding: const EdgeInsets.symmetric(horizontal: 15,),
                        selectValue: logic.institutionItem,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor().withOpacity(0.8)
                        ),
                        textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor()
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor(),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10))
                        ),
                        onChanged: (String? id){
                          logic.institutionItem = id;
                          logic.update();
                        },
                      ),
                      // Container(
                      //     decoration: BoxDecoration(
                      //         color: AppColors.whiteColor(),
                      //         borderRadius: const BorderRadius.all(Radius.circular(10))
                      //     ),
                      //     padding: const EdgeInsets.symmetric(horizontal: 15),
                      //     child: DropdownButton(
                      //       isExpanded: true,
                      //       value: logic.institutionItem,
                      //       underline: const SizedBox(),
                      //       hint: const Text("Institution",
                      //       style: TextStyle(
                      //         fontSize: 14
                      //       ),),
                      //       items: institutionItems,
                      //       onChanged: (String? s) {
                      //         logic.institutionItem = s;
                      //         logic.update();
                      //       },
                      //
                      //     )
                      // ),

                      const SizedBox(height: 15,),

                      const Text("Name",
                        style: TextStyle(
                            fontSize: 12
                        ),),
                      const SizedBox(height: 2,),
                      CustomInput(
                        textController: controller.nameController,
                        keyboardType: TextInputType.name,
                        hintText: "Enter Name",
                        suffixIcon: const Icon(Icons.person),
                      ),

                      const SizedBox(height: 15,),

                      const Text("Email",
                        style: TextStyle(
                            fontSize: 12
                        ),),
                      const SizedBox(height: 2,),
                      CustomInput(
                        textController: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter Email",
                        suffixIcon: const Icon(Icons.email),
                      ),

                      const SizedBox(height: 15,),

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

                      const SizedBox(height: 15,),

                      Row(
                        children: [

                          Expanded(
                            child: InkWell(
                              onTap: (){
                                selectBarthDate(context).then((value) => {
                                  logic.dateOfBirth = value,
                                  logic.update(),
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Date Of Birth",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),),
                                  const SizedBox(height: 2,),
                                  Container(
                                    height: 40,
                                    width: Get.width / 2,
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor(),
                                        borderRadius: const BorderRadius.all(Radius
                                            .circular(10))
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text("${logic.dateOfBirth??"Birth Date"}".toDateDMMMY(),
                                          style: TextStyle(
                                            color: logic.dateOfBirth == null ? Theme
                                                .of(context)
                                                .hintColor : null,
                                            fontSize: 14
                                          ),),
                                      ],
                                    ),
                                  ),
                                  // CustomInputField(
                                  //   enabled: false,
                                  //   hintText: "Reason for leave",
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Gender",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),),
                                  const SizedBox(height: 2,),
                                  CustomDropDown(
                                    list: genderItems,
                                    height: 40,
                                    width: Get.width / 2,
                                    dropdownWidth: Get.width*0.7,
                                    hint: "Gender",
                                    padding: const EdgeInsets.symmetric(horizontal: 15,),
                                    selectValue: logic.gender,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textColor().withOpacity(0.8)
                                    ),
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textColor()
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))
                                    ),
                                    onChanged: (String? id){
                                      logic.gender = id;
                                      logic.update();
                                    },
                                  ),
                                  // Container(
                                  //     height: 40,
                                  //     width: Get.width / 2,
                                  //     decoration: BoxDecoration(
                                  //         color: AppColors.whiteColor(),
                                  //         borderRadius: const BorderRadius.all(Radius
                                  //             .circular(10))
                                  //     ),
                                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                                  //     child: DropdownButton(
                                  //       isExpanded: true,
                                  //       value: logic.gender,
                                  //       underline: const SizedBox(),
                                  //       hint: const Text("Gender",style: TextStyle(
                                  //         fontSize: 14
                                  //       ),),
                                  //       items: genderItems,
                                  //       onChanged: (Gender? s) {
                                  //         logic.gender = s!.name;
                                  //         logic.update();
                                  //       },
                                  //
                                  //     )
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15,),

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

                      const SizedBox(height: 20,),

                      CustomButton(
                        borderRadius: 5,
                        text: logic.createdBy != null ? "Create Employee" : "Signup",
                        isLoading: controller.loginInProcess,
                        fontColor: Colors.white,
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onTap: () {
                          if(logic.createdBy != null){
                            controller.createEmployee();
                          }else{
                            controller.signup();
                          }
                        },
                      ),

                      const SizedBox(height: 20,),

                      if(logic.createdBy == null)...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You Have a Account",
                              style: TextStyle(
                                  color: AppColors.text2,
                                  fontSize: 16
                              ),),

                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text("Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.text2,
                                      fontSize: 15
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ]
            ),
          );
        },
      ),
    );
  }

}
