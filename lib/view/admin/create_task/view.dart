import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../employee/leave/view.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_input.dart';
import 'logic.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CreateTaskLogic>().getUsersList();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Task")),
      bottomSheet: Container(
        height: 80,
        color: AppColors.appBackground,
        padding: const EdgeInsets.all(15),
        child: GetBuilder<CreateTaskLogic>(
          assignId: true,
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  borderRadius: 5,
                  text: "${logic.model != null ? "Update" : "Create"} Task",
                  isLoading: logic.toCreateTask,
                  fontColor: Colors.white,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onTap: () {
                    if (logic.model != null) {
                      logic.updateTask();
                    } else {
                      logic.createTask();
                    }
                  },
                ),

                if(logic.model != null)
                  CustomButton(
                    borderRadius: 5,
                    text: "Delete Task",
                    isLoading: logic.deleteTaskProcess,
                    fontColor: Colors.white,
                    color: Colors.red,
                    onTap: () {
                      logic.deleteTask();
                    },
                  )
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<CreateTaskLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 30,),

                  // if(logic.model?.taskName != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(bottom: 20),
                  //     child: Text(logic.model?.taskName??""),
                  //   ),


                  CustomInput(
                    textController: logic.nameController,
                    keyboardType: TextInputType.name,
                    hintText: "Enter Task Name",
                  ),

                  const SizedBox(height: 30,),


                  CustomInput(
                    textController: logic.descriptionController,
                    keyboardType: TextInputType.text,
                    maxLine: 4,
                    hintText: "Enter Task description",
                  ),

                  const SizedBox(height: 30,),
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton(
                        isExpanded: true,
                        value: logic.assign,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text("Task assign",
                          style: TextStyle(
                              fontSize: 14
                          ),),
                        items: logic.userItems,
                        onChanged: (String? s) {
                          logic.assign = s;
                          logic.update();
                        },

                      )
                  ),

                  const SizedBox(height: 30,),
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton(
                        isExpanded: true,
                        value: logic.priority,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text("Task Priority",
                          style: TextStyle(
                              fontSize: 14
                          ),),
                        items: logic.priorities,
                        onChanged: (String? s) {
                          logic.priority = s;
                          logic.update();
                        },

                      )
                  ),

                  const SizedBox(height: 30,),

                  InkWell(
                    onTap: () {
                      selectDate(context).then((value) =>
                      {
                        logic.dueDate = value,
                        logic.update(),
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius
                                  .circular(10))
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${logic.dueDate ?? "Due Date"}"
                                  .toDateDMMMY(),
                                style: TextStyle(
                                    color: logic.dueDate == null ? Theme
                                        .of(context)
                                        .hintColor : null,
                                    fontSize: 14
                                ),),
                              Icon(Icons.timelapse,
                                color: logic.dueDate == null ? Theme
                                    .of(context)
                                    .hintColor : null,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80,),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
