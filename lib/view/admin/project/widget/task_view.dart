import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/other/widget/custom_button.dart';
import 'package:attendance/view/other/widget/custom_image.dart';
import 'package:attendance/view/other/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/routes.dart';
import '../../../../model/TaskModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/toast.dart';
import '../../../employee/leave/view.dart';
import '../../../other/widget/custom_dropdown.dart';
import '../../task/widget/change_status.dart';
import '../logic.dart';

enum Priority { low, medium, high }
enum TaskStatus { pending, working, complete, cancelled }
enum ProjectStatus { complete, progress, pending, cancelled }

Color getPriorityColor(String string) {
  if (string == Priority.low.name) {
    return Colors.amber;
  }
  if (string == Priority.medium.name) {
    return Colors.purple;
  }
  if (string == Priority.high.name) {
    return Colors.red;
  }
  return Colors.black54;
}

Color getTaskStatusColor(String string) {
  if (string == TaskStatus.pending.name) {
    return Colors.blue;
  }
  if (string == TaskStatus.working.name) {
    return Colors.amber;
  }
  if (string == TaskStatus.complete.name) {
    return Colors.green;
  }
  return Colors.red;
}

class TaskView extends StatefulWidget {
  final int index;
  final String projectId;

  const TaskView({super.key, required this.index, required this.projectId});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  DateTime? dueDate;
  String? priority;
  List<DropDownModel> priorities = [
    DropDownModel(value: "low"),
    DropDownModel(value: "medium"),
    DropDownModel(value: "high"),
  ];

  final TextEditingController nameController = TextEditingController();
  String? assign;

  clearData() {
    setState(() {
      nameController.clear();
      assign = null;
      priority = null;
      dueDate = null;
    });
  }

  isValid() {
    if (nameController.text.isNotEmpty)
      if (assign != null)
        if (priority != null)
          if (dueDate != null)
            return true;
          else
            Toast.show(toastMessage: "select Due Date", isError: true);
        else
          Toast.show(toastMessage: "set priority", isError: true);
      else
        Toast.show(toastMessage: "which employee assign?", isError: true);
    else
      Toast.show(toastMessage: "Enter name", isError: true);
    return false;
  }

  String? test;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectLogic>(
      assignId: true,
      builder: (logic) {
        return Column(
          children: [
            const SizedBox(height: 5,),
            const Divider(),
            const SizedBox(height: 5,),

            for(int i = 0; i < logic.list.length; i++)...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: (){
                              logic.changeStatus(i, (logic.list[i].status ?? "") != TaskStatus.complete.name ? TaskStatus.complete.name : TaskStatus.working.name);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularCheckBoxIcon(
                                  isChecked: (logic.list[i].status ?? "") == TaskStatus.complete.name,
                                  size: 18,
                                  color: getTaskStatusColor(logic.list[i].status ?? ""),
                                ),
                                const SizedBox(width: 5,),
                                Flexible(
                                  child: Text((logic.list[i].taskName ?? "").toCapitalizeFirstLetter(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 12.5
                                    ),
                                    maxLines: 1,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: generateDarkColor("${logic.list[i].assign?.name}"),
                              shape: BoxShape.circle
                          ),
                          margin: const EdgeInsets.only(right: 5),
                          child: Center(child: Text("${logic.list[i].assign?.name}".toImageName(),
                            style: TextStyle(
                                fontSize: 8,
                                color: AppColors.whiteColor(),
                                fontWeight: FontWeight.bold
                            ),)),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              if((((logic.list[i].dueDate??"").toDateTime())??DateTime.now()).isBefore(DateTime.now()))...[
                                SizedBox(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
                                    child: const Text("Overdue",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10
                                    ),),
                                  ),
                                ),]else...[
                                SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: getPriorityColor(logic.list[i].priority ?? ""),
                                        // border: Border.all(
                                        //     color: TaskView.getPriorityColor(widget.model.priority ?? ""), width: 0.5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3, vertical: 1),
                                          child: Text(
                                            (logic.list[i].priority ?? "").toCapitalizeFirstLetter(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 8
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        //Text("${widget.model.status}"),


                        Expanded(
                          flex: 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              CustomDropDown(
                                width: 65,
                                height: 20,
                                list: [
                                //  DropDownModel(value: "pending"),
                                  DropDownModel(value: "pending",id: 'working'),
                                  DropDownModel(value: "complete"),
                                ],
                                selectValue: logic.list[i].status == 'pending' ? "working" : logic.list[i].status,
                                hintStyle: TextStyle(
                                    fontSize: 9,
                                    color: getTaskStatusColor(logic.list[i].status ?? "")
                                ),
                                textStyle: TextStyle(
                                    fontSize: 9,
                                    color: getTaskStatusColor(logic.list[i].status ?? "")
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: getTaskStatusColor(logic.list[i].status ?? ""), width: 0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                onChanged: (String? model){
                                  logic.changeStatus(i, "$model");
                                },
                              ),


                              // Container(
                              //     width: 65,
                              //     height: 20,
                              //     decoration: BoxDecoration(
                              //       border: Border.all(
                              //           color: TaskView.getTaskStatusColor(widget.model.status ?? ""), width: 0.5),
                              //    //     color: TaskView.getTaskStatusColor(widget.model.status ?? ""),
                              //         borderRadius: const BorderRadius.all(Radius.circular(10))
                              //     ),
                              //     padding: const EdgeInsets.symmetric(horizontal: 5),
                              //     child: DropdownButton(
                              //       isExpanded: true,
                              //       value: test,
                              //       underline: const SizedBox(),
                              //       icon: Icon(Icons.keyboard_arrow_down, size: 12,
                              //           color: TaskView.getTaskStatusColor(widget.model.status ?? "")),
                              //       hint: Text((widget.model.status??"").toCapitalizeFirstLetter(),
                              //         style: TextStyle(
                              //             fontSize: 9,
                              //             color: TaskView.getTaskStatusColor(widget.model.status ?? "")
                              //         ),),
                              //       style: TextStyle(
                              //           fontSize: 9,
                              //           color: AppColors.whiteColor()
                              //       ),
                              //       items: stateList,
                              //       onChanged: (String? s) {
                              //         if(widget.onChangeStatus != null){
                              //           widget.onChangeStatus!("$s");
                              //         }
                              //       },
                              //
                              //     )
                              // ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 5,),
              const Divider(),
              const SizedBox(height: 5,),
            ],
            Row(
              children: [
                // Container(
                //     decoration: const BoxDecoration(
                //         color: AppColors.secondary,
                //         shape: BoxShape.circle
                //     ),
                //     child: Icon(
                //       Icons.add, color: AppColors.whiteColor(), size: 17,)),

                const SizedBox(width: 8,),

                Flexible(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                        child: CustomInput(
                          hintText: "Task Name",
                          fontSize: 10,
                          textController: nameController,
                          horizontalPadding: 0,
                          border: false,
                        ),
                      ),
                      const Divider(height: 0,)
                    ],
                  ),
                ),

                const SizedBox(width: 5,),

                CustomDropDown(
                  width: 55,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  hint: "Assign",
                  hintStyle: const TextStyle(
                        fontSize: 10
                    ),
                  textStyle: TextStyle(
                      fontSize: 10,
                      color: AppColors.textColor()
                  ),
                  selectValue: assign,
                  list: logic.userItems,
                  onChanged: (String? s){
                    setState(() {
                      assign = s;
                    });
                  },
                ),

                const SizedBox(width: 5,),

                CustomDropDown(
                  width: 55,
                  height: 35,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  hint: "Priority",
                  hintStyle: const TextStyle(
                      fontSize: 10
                  ),
                  textStyle: TextStyle(
                      fontSize: 10,
                      color: AppColors.textColor()
                  ),
                  selectValue: priority,
                  list: priorities,
                  onChanged: (String? s){
                    setState(() {
                      priority = s;
                    });
                  },
                ),

                const SizedBox(width: 5,),

                InkWell(
                  onTap: () {
                    selectDate(context).then((value) =>
                    {
                      setState(() {
                        dueDate = value;
                      })
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius
                                .circular(10))
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${dueDate ?? "YYYY-MM-DD"}"
                                .toDateDMMMY(),
                              style: TextStyle(
                                  color: dueDate == null ? Theme
                                      .of(context)
                                      .hintColor : null,
                                  fontSize: 10
                              ),),
                            const SizedBox(width: 5,),
                            Icon(Icons.calendar_today,
                              size: 12,
                              color: dueDate == null ? Theme
                                  .of(context)
                                  .hintColor : null,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8,),

                CustomButton(
                  height: 25,
                  label: Row(
                    children: [
                      Icon(Icons.add, size: 15, color: AppColors.whiteColor()),
                      const SizedBox(width: 2,),
                      Text("Add", style: TextStyle(
                          fontSize: 10,
                          color: AppColors.whiteColor()
                      ),),
                    ],
                  ),
                  horizontalPadding: 7,
                  isLoading: logic.toCreateTask,
                  onTap: () {
                    if (!isValid()) return;
                    dynamic body = {
                      "project_id": widget.projectId,
                      "task_name": nameController.text,
                      "description": nameController.text,
                      "assign": "$assign",
                      "priority": "$priority",
                      "due_date": "${dueDate!.year}-${dueDate!.month}-${dueDate!
                          .day}",
                      "status": "pending",
                    };
                    logic.createTask(widget.index, body: body, callback: () {
                      clearData();
                    });
                  },
                  //  borderRadius: 10,
                )
              ],
            )
          ],
        );
      },
    );
  }
}

Color generateDarkColor(String input) {
  int hashCode = input.hashCode;
  int red = (hashCode & 0xFF0000) >> 16;
  int green = (hashCode & 0x00FF00) >> 8;
  int blue = (hashCode & 0x0000FF);

  int brightnessThreshold = 300; // Adjust this threshold as needed

  if (red + green + blue > brightnessThreshold) {
    red = 0;
    green = 0;
    blue = 0;
  }

  return Color.fromRGBO(red, green, blue, 1);
}