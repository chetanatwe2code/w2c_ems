import 'package:attendance/core/routes.dart';
import 'package:attendance/view/admin/project/logic.dart';
import 'package:attendance/view/admin/project/widget/project_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../common/punching/view.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if(!Get.isRegistered<ProjectRepository>()){
    //   Get.put(() => ProjectRepository(apiClient: Get.find()));
    // }
    Get.find<ProjectLogic>().getProject();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Project"),
      actions: [
        IconButton(onPressed: (){
          Get.toNamed(rsCreateProjectPage);
        }, icon: const Icon(Icons.add))
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //   },
      //   child: const Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: GetBuilder<ProjectLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              children: [

                ListView.builder(
                  itemCount: logic.model.length,
                  padding: EdgeInsets.only(
                      top: 20, left: hPadding, right: hPadding,bottom: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProjectView(model: logic.model[index],isExpanded: logic.expandedIndex == index,index: index,);
                  },),
              ],
            );
          },
        ),
      ),
    );
  }

}
