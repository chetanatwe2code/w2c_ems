import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/admin/task/logic.dart';
import 'package:attendance/view/admin/task/widget/change_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../core/routes.dart';
import '../../../theme/app_colors.dart';
import '../../common/punching/view.dart';
import '../project/widget/task_view.dart';

class TaskPage extends GetView<TaskLogic> {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Task")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(rsCreateTaskPage,
              arguments: { "project_id": controller.projectId});
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: GetBuilder<TaskLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            children: [

              Flexible(
                child: StaggeredGridView.countBuilder(
                  itemCount: logic.list.length,
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  //physics: const BouncingScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(rsCreateTaskPage,
                            arguments: { "project_id": controller.projectId, "task" : logic.list[index].toJson() });
                      },
                      child: Container(
                        decoration: getDecoration(),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: generateDarkColor("${logic.list[index].assign?.name}"),
                                    shape: BoxShape.circle
                                  ),
                                  child: Center(child: Text("${logic.list[index].assign?.name}".toImageName(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.whiteColor(),
                                    fontWeight: FontWeight.bold
                                  ),)),
                                ),

                                const SizedBox(width: 5,),


                                Flexible(
                                  child: Text(((logic.list[index].taskName??"").toCapitalizeFirstLetter()),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary
                                    ),),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            Row(
                              children: [
                                const Text("Priority:",
                                  style: TextStyle(
                                  ),),
                                const SizedBox(width: 2,),
                                Text((logic.list[index].priority??"").toCapitalizeFirstLetter(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                  ),),
                              ],
                            ),

                            const SizedBox(height: 2,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Status:",
                                      style: TextStyle(
                                      ),),
                                    const SizedBox(width: 2,),
                                    Text((logic.list[index].status??"").toCapitalizeFirstLetter(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                                InkWell(
                                    onTap: (){
                                      Get.bottomSheet(
                                        ChangeStatus(paddingTop: MediaQuery
                                            .of(context)
                                            .padding
                                            .top,
                                          taskStatus: logic.list[index].status,
                                          taskName: "${logic.list[index].taskName}",
                                          taskId: "${logic.list[index].id}",
                                          callback: (){
                                          logic.getTask();
                                          },
                                        ),
                                        isScrollControlled: true,
                                        barrierColor: Colors.transparent,
                                        isDismissible: false,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.arrow_forward_ios,color: AppColors.textColor(),size: 12,),
                                    ))
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}