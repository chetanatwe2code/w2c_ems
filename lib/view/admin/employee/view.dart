import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/view/admin/employee/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/employee_view.dart';


class EmployeePage extends GetView<EmployeeLogic> {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUsersList();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Employee")),
      body: GetBuilder<EmployeeLogic>(
        assignId: true,
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [

                if(logic.getUsersListProcess)...[
                  const SizedBox(height: 100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ],
                  ),
                ] else...[
                    ListView.builder(
                      itemCount: logic.empList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(15),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return EmployeeView(model: logic.empList[index]);
                      }),
                    )
                  ],

              ],
            ),
          );
        },
      ),
    );
  }
}
