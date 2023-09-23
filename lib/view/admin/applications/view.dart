import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/view/admin/applications/widget/Application.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic.dart';

class ApplicationsPage extends GetView<ApplicationsLogic> {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAdminLeaves();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Leave Applications"),),
      body: GetBuilder<ApplicationsLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            mainAxisAlignment: logic.getLeavesProcess ? MainAxisAlignment
                .center : MainAxisAlignment.start,
            children: [

              if(logic.getLeavesProcess)...[
                const SizedBox(height: 100,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ],
                ),
              ]else...[
                Expanded(
                  child: ListView.builder(
                    itemCount: logic.list.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemBuilder: ((context, index) {
                      return Application(model: logic.list[index],
                      updateLeaveCallback: (status){
                        logic.updateListStatus(status, index);
                      },);
                    }),
                  ),
                )
              ],
            ],
          );
        },
      ),
    );
  }
}
