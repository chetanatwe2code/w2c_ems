import 'package:attendance/model/ProjectTaskModel.dart';
import 'package:attendance/model/TaskModel.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';


import '../../../theme/app_colors.dart';
import '../../admin/project/widget/task_view.dart' as TaskView;
import '../../admin/task/widget/change_status.dart';
import '../../other/widget/custom_dropdown.dart';
import '../punching/view.dart';

class Task extends StatefulWidget {
  final TaskModel model;
  final Function(String s)? onChangeStatus;
  const Task({Key? key, required this.model,this.onChangeStatus}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: getDecoration(borderRadius: 30),
      child: Row(
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
                      if(widget.onChangeStatus != null){
                        widget.onChangeStatus!((widget.model.status ?? "") != TaskStatus.complete.name ? TaskStatus.complete.name : TaskStatus.working.name);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularCheckBoxIcon(
                          isChecked: (widget.model.status ?? "") == TaskStatus.complete.name,
                          size: 18,
                          color: TaskView.getTaskStatusColor(widget.model.status ?? ""),
                        ),
                        const SizedBox(width: 5,),
                        Flexible(
                          child: Text((widget.model.taskName ?? "").toCapitalizeFirstLetter(),
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
                      color: TaskView.generateDarkColor("${widget.model.assign?.name}"),
                      shape: BoxShape.circle
                  ),
                  margin: const EdgeInsets.only(right: 5),
                  child: Center(child: Text("${widget.model.assign?.name}".toImageName(),
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

                      if((((widget.model.dueDate??"").toDateTime())??DateTime.now()).isBefore(DateTime.now()))...[
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
                              color: TaskView.getPriorityColor(widget.model.priority ?? ""),
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
                                    (widget.model.priority ?? "").toCapitalizeFirstLetter(),
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
                          //DropDownModel(value: "pending"),
                          DropDownModel(value: "pending",id: 'working'),
                          DropDownModel(value: "complete"),
                        ],
                        selectValue: widget.model.status == 'pending' ? "working" : widget.model.status,
                        hintStyle: TextStyle(
                          fontSize: 9,
                          color: TaskView.getTaskStatusColor(widget.model.status ?? "")
                      ),
                        textStyle: TextStyle(
                            fontSize: 9,
                            color: TaskView.getTaskStatusColor(widget.model.status ?? "")
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: TaskView.getTaskStatusColor(widget.model.status ?? ""), width: 0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        onChanged: (String? model){
                          if(widget.onChangeStatus != null){
                            widget.onChangeStatus!("$model");
                          }
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
    );
  }
}

