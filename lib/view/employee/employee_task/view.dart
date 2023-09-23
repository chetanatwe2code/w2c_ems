import 'package:attendance/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes.dart';
import '../../admin/project/logic.dart';
import '../../admin/project/widget/project_view.dart';
import '../../common/punching/view.dart';
import 'logic.dart';

class EmployeeTaskPage extends StatelessWidget {
  const EmployeeTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProjectLogic>().getProject();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Task"),
      actions: [
        IconButton(onPressed: (){
          Get.toNamed(rsCreateProjectPage);
        }, icon: const Icon(Icons.add))
      ]),
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
