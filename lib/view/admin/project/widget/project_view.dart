import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/admin/project/widget/task_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/routes.dart';
import '../../../../model/ProjectModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/punching/view.dart';
import '../logic.dart';

class ProjectView extends StatelessWidget {
  final ProjectModel? model;
  final bool? isExpanded;
  final int index;
  const ProjectView({super.key,this.model,this.isExpanded,required this.index});

  @override
  Widget build(BuildContext context) {
    DateTime endDate = (model?.endDate??"").toDateTime() ?? DateTime.now();
    bool isToday  = isSameDay(endDate,DateTime.now());
    bool isOverdue  = isToday ? false : endDate.isBefore(DateTime.now());
    bool isCompeted  = model?.status == ProjectStatus.complete.name;
    Color color = isCompeted ? Colors.green : (isToday ? Colors.amber : (isOverdue ? Colors.red : AppColors.primary));
    return Container(
        decoration: getDecoration(borderRadius: isExpanded == true ? 15 : 40),
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: InkWell(
                    onTap:  (){
                      if(isExpanded == false){
                        Get.find<ProjectLogic>().getTask("${model?.id??""}",index);
                      }else{
                        Get.find<ProjectLogic>().clearIndex();
                      }
                     // Get.toNamed(rsCreateProjectPage,arguments: { "project" : model?.toJson() });
                    },
                    child: Text((model?.projectName??"").toCapitalizeFirstLetter(),
                        maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                Text(isToday ? "Today" : (isOverdue ? "Overdue" : "${model?.status}".toCapitalizeFirstLetter()),
                style: TextStyle(
                  fontSize: 12,
                  color: color
                ),),

                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        // onTap: (){
                        //   if(isExpanded == false){
                        //     Get.find<ProjectLogic>().getTask("${model?.id??""}",index);
                        //   }else{
                        //     Get.find<ProjectLogic>().clearIndex();
                        //   }
                        //   // isExpanded = !isExpanded;
                        //   // setState((){});
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                              color: color,
                              border: Border.all(color: color,width: 0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                child: Text((model?.endDate??"").toDateDMMMY(),
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 12
                                  ),),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(isExpanded == true ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  size: 17,color: AppColors.whiteColor(),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // InkWell(
                //   onTap: (){
                //     Get.toNamed(rsCreateProjectPage,arguments: { "project" : model?.toJson() });
                //   },
                //   child: Container(
                //       decoration: const BoxDecoration(
                //         color: Colors.amber,
                //         shape: BoxShape.circle
                //       ),
                //       padding: const EdgeInsets.all(2),
                //       margin: const EdgeInsets.only(left: 5),
                //       child: const Icon(Icons.edit,size: 14,color: Colors.white,)),
                // )
              ],
            ),

            // how can add animation event when TaskView open
            if(isExpanded??false)
               TaskView(index: index,projectId: "${model?.id}"),
          ],
        ));
  }
}
