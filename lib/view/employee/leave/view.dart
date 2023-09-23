import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_dropdown.dart';
import '../../other/widget/custom_input.dart';
import '../../../test/test_app.dart';
import 'logic.dart';

class LeavePage extends GetView<LeaveLogic> {
  const LeavePage({Key? key}) : super(key: key);

  List<DropDownModel> get dropdownItems {
    List<DropDownModel> menuItems = [
      DropDownModel(value: "Medical Leave",id: "Medical"),
      DropDownModel(value: "Emergency leave",id: "Emergency"),
      DropDownModel(value: "Casual leave",id: "Casual"),
      DropDownModel(value: "Half Day Leave",id: "Half Day"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get leavesTime {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Full Day", child: Text("Full Day",style: TextStyle(
          fontSize: 14
      ),)),
      const DropdownMenuItem(value: "Leave Before Half Day", child: Text("Leave before Half Day",style: TextStyle(
          fontSize: 14
      ),)),
      const DropdownMenuItem(value: "Before After Half Day", child: Text("Leave  Half Day",style: TextStyle(
          fontSize: 14
      ),))
    ];
    return menuItems;
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Leave Request"),),
      body: GetBuilder<LeaveLogic>(
        assignId: true,
        builder: (logic) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 40,),

                  const Text("Leave Type",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  const SizedBox(height: 2,),

                  CustomDropDown(
                    height: 40,
                    dropdownWidth: Get.width*0.7,
                    list: dropdownItems,
                    selectValue: logic.leaveType,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColor().withOpacity(0.8)
                    ),
                    hint: "Leave Type",
                    textStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColor()
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor(),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    onChanged: (String? s){
                      logic.leaveType = s;
                      logic.update();
                    },
                  ),

                  const SizedBox(height: 30,),

                  const Text("Leave Reason",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  const SizedBox(height: 2,),
                  CustomInput(
                    maxLine: 4,
                    textController: logic.reasonController,
                    hintText: "Reason for leave",
                  ),

                  const SizedBox(height: 30,),


                  const Text("Leave Time",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  const SizedBox(height: 2,),

                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: AppColors.whiteColor(),
                  //       borderRadius: const BorderRadius.all(Radius.circular(5))
                  //   ),
                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                  //   child: DropdownButton(
                  //     isExpanded: true,
                  //     value: logic.leaveTime,
                  //     underline: const SizedBox(),
                  //     hint: const Text("Leave Time"),
                  //     items: leavesTime,
                  //     onChanged: (String? s) {
                  //       logic.leaveTime = s;
                  //       logic.update();
                  //     },
                  //   ),
                  // ),

                  Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor(),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      //color: AppColors.whiteColor(),
                      child: DropdownButton(
                        isExpanded: true,
                        value: logic.leaveTime,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        underline: const SizedBox(),
                        hint: const Text("Leave Type",
                        style: TextStyle(
                          fontSize: 14
                        ),),
                        items: leavesTime,
                        onChanged: (String? s) {
                          logic.leaveTime = s;
                          logic.update();
                        },

                      )
                  ),

                  const SizedBox(height: 30,),

                  Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            selectDate(context,initialDate: logic.startDate).then((value) => {
                              logic.startDate = value,
                              if(logic.endDate != null && logic.endDate!.isBefore(logic.startDate!)){
                                logic.endDate = null,
                              },
                              logic.update(),
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Start Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
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
                                child: Center(child: Text("${logic.startDate??"Pick Date"}".toDateDMMMY(),
                                  style: TextStyle(
                                    color: logic.startDate == null ? Theme
                                        .of(context)
                                        .hintColor : null,
                                      fontSize: 14
                                  ),)),
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
                          onTap: logic.startDate != null ? (){
                            selectDate(context,firstDate: logic.startDate,initialDate: logic.endDate).then((value) => {
                              logic.endDate = value,
                              logic.update(),
                            });
                          } : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("End Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              const SizedBox(height: 2,),
                              Container(
                                height: 40,
                                width: Get.width / 2,
                                decoration: BoxDecoration(
                                    color: logic.startDate != null ? AppColors.whiteColor() : Colors.white54,
                                    borderRadius: const BorderRadius.all(Radius
                                        .circular(10))
                                ),
                                child: Center(child: Text("${logic.endDate??"Pick Date"}".toDateDMMMY(),
                                  style: TextStyle(
                                    color: logic.endDate == null ? Theme
                                        .of(context)
                                        .hintColor : null,
                                    fontSize: 14
                                  ),)),
                              ),
                              // CustomInputField(
                              //   enabled: false,
                              //   hintText: "Reason for leave",
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 50,),

                  CustomButton(
                    text: "Submit Request",
                    fontColor: Colors.white,
                    fontSize: 17,
                    isLoading: logic.isSubmitting,
                    fontWeight: FontWeight.bold,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    onTap: (){
                      logic.addLeave();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<DateTime> selectDate(BuildContext context,{DateTime? firstDate,DateTime? initialDate}) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? (firstDate?? DateTime.now()),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2100)
  );
  if (pickedDate != null) {
    return Future.value(pickedDate);
  }
  return Future.error("Date Not Found");
}

Future<DateTime> selectBarthDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
  );
  if (pickedDate != null) {
    return Future.value(pickedDate);
  }
  return Future.error("Date Not Found");
}
