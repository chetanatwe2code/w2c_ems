import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../employee/leave/view.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_input.dart';
import 'logic.dart';


class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CreateProjectLogic>().getUsersList();
    return Scaffold(
      appBar: AppBar(title: const Text("Project")),
      backgroundColor: AppColors.appBackground,
      bottomSheet: Container(
        height: 80,
        color: AppColors.appBackground,
        padding: const EdgeInsets.all(15),
        child: GetBuilder<CreateProjectLogic>(
          assignId: true,
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: 5,
                    text: "${logic.model == null
                        ? "Create"
                        : "Update"} Project",
                    isLoading: logic.toCreateProject,
                    fontColor: Colors.white,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    onTap: () {
                      if (logic.model == null) {
                        logic.createProject();
                      } else {
                        logic.updateProject();
                      }
                    },
                  ),
                ),
                if(logic.model != null)...[
                  const SizedBox(width: 10,),
                  Expanded(
                    child: CustomButton(
                      borderRadius: 5,
                      text: "Delete Project",
                      isLoading: logic.deleteProjectProcess,
                      fontColor: Colors.white,
                      color: Colors.red,
                      onTap: () {
                        logic.deleteProject();
                      },
                    ),
                  )
                ]
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<CreateProjectLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 30,),

                  // if(logic.model?.projectName != null)
                  //  Padding(
                  //    padding: const EdgeInsets.only(top: 30),
                  //    child: Text(logic.model?.projectName??""),
                  //  ),


                  CustomInput(
                    textController: logic.nameController,
                    keyboardType: TextInputType.name,
                    hintText: "Enter Project Name",
                  ),

                  const SizedBox(height: 30,),


                  CustomInput(
                    textController: logic.descriptionController,
                    keyboardType: TextInputType.text,
                    maxLine: 4,
                    hintText: "Enter Project description",
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
                        value: logic.leader,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text("Project Leader",
                          style: TextStyle(
                              fontSize: 14
                          ),),
                        items: logic.userItems,
                        onChanged: (String? s) {
                          logic.leader = s;
                          logic.update();
                        },

                      )
                  ),

                  const SizedBox(height: 30,),

                  InkWell(
                    onTap: () {
                      selectDate(context,initialDate: logic.startDate).then((value) =>
                      {
                        logic.startDate = value,
                        if(logic.endDate != null &&
                            logic.endDate!.isBefore(logic.startDate!)){
                          logic.endDate = null,
                        },
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
                              Text("${logic.startDate ?? "Start Date"}"
                                  .toDateDMMMY(),
                                style: TextStyle(
                                    color: logic.startDate == null ? Theme
                                        .of(context)
                                        .hintColor : null,
                                    fontSize: 14
                                ),),
                              Icon(Icons.timelapse,
                                color: logic.startDate == null ? Theme
                                    .of(context)
                                    .hintColor : null,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30,),

                  InkWell(
                    onTap: logic.startDate != null ? () {
                      selectDate(context, firstDate: logic.startDate,initialDate: logic.endDate).then((
                          value) =>
                      {
                        logic.endDate = value,
                        logic.update(),
                      });
                    } : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: logic.startDate != null ? AppColors.whiteColor() : Colors.white54,
                              borderRadius: const BorderRadius.all(Radius
                                  .circular(10))
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${logic.endDate ?? "End Date"}"
                                  .toDateDMMMY(),
                                style: TextStyle(
                                  color: logic.endDate == null ? Theme
                                      .of(context)
                                      .hintColor : null,
                                ),),
                              Icon(Icons.timelapse,
                                color: logic.endDate == null ? Theme
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
