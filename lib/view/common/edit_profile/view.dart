import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/sign_up/logic.dart';
import '../../employee/leave/view.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_dropdown.dart';
import '../../other/widget/custom_input.dart';
import 'logic.dart';

class EditProfilePage extends GetView<EditProfileLogic> {
  const EditProfilePage({super.key});

  List<DropDownModel> get institutionItems {
    List<DropDownModel> menuItems = [
      DropDownModel(value: "We2code Technology Private Limited",id: "1"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<Gender>> get genderItems {
    List<DropdownMenuItem<Gender>> menuItems = [
      const DropdownMenuItem(
          value: Gender.male, child: Text("Male",style: TextStyle(
          fontSize: 14
      ),)),
      const DropdownMenuItem(
          value: Gender.female, child: Text("Female",style: TextStyle(
          fontSize: 14
      ),)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Edit Profile"),),
      body: GetBuilder<EditProfileLogic>(
        assignId: true,
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  const SizedBox(height: 20,),


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
                        // Container(
                        //     decoration: BoxDecoration(
                        //         color: AppColors.whiteColor(),
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(10))
                        //     ),
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     child: DropdownButton(
                        //       isExpanded: true,
                        //       icon: const Icon(Icons.keyboard_arrow_down),
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

                        CustomDropDown(
                          list: institutionItems,
                          height: 40,
                          dropdownWidth: Get.width*0.7,
                          hint: "Institution",
                          padding: const EdgeInsets.symmetric(horizontal: 15,),
                          selectValue: logic.institutionItem,
                          hintStyle: TextStyle(
                              fontSize: 12,
                              color: AppColors.textColor().withOpacity(0.5)
                          ),
                          textStyle: TextStyle(
                              fontSize: 12,
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
                          enabled: !logic.itself,
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
                                onTap: () {
                                  selectBarthDate(context).then((value) =>
                                  {
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
                                      height: 45,
                                      width: Get.width / 2,
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor(),
                                          borderRadius: const BorderRadius.all(
                                              Radius
                                                  .circular(10))
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Text("${logic.dateOfBirth ??
                                              "Birth Date"}".toDateDMMMY(),
                                            style: TextStyle(
                                              color: logic.dateOfBirth == null
                                                  ? Theme
                                                  .of(context)
                                                  .hintColor
                                                  : null,
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
                                    Container(
                                        height: 45,
                                        width: Get.width / 2,
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor(),
                                            borderRadius: const BorderRadius
                                                .all(Radius
                                                .circular(10))
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: logic.gender,
                                          underline: const SizedBox(),
                                          icon: const Icon(Icons.keyboard_arrow_down),
                                          hint: const Text("Gender"),
                                          items: genderItems,
                                          onChanged: (Gender? s) {
                                            logic.gender = s;
                                            logic.update();
                                          },

                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40,),

                        CustomButton(
                          borderRadius: 5,
                          text: "Update",
                          isLoading: controller.updatingInProcess,
                          fontColor: Colors.white,
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onTap: () {
                            if(logic.itself){
                              logic.editUser();
                            }else{
                              logic.updateUser();
                            }
                          },
                        ),
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
