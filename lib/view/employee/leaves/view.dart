import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/employee/leaves/widget/leaves.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes.dart';
import '../../../theme/app_colors.dart';
import 'logic.dart';

class LeavesPage extends GetView<LeavesLogic> {
  const LeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getLeaves();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text("Leaves"), elevation: 1,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(rsLeavePage);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: GetBuilder<LeavesLogic>(
        assignId: true,
        builder: (logic) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: logic.getLeavesProcess ? MainAxisAlignment
                  .center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if(logic.getLeavesProcess)...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ],
                  ),
                ]else...[

                  const SizedBox(height: 10,),

                  Container(
                    height: 115,
                    width: Get.width,
                    decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("${DateTime.now()}".toDateMMMMYYYY(),
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontWeight: FontWeight.w800
                                  ),),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 18,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              children: [
                                Text("${logic.approvedCount??0}",
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),),

                                const SizedBox(height: 2,),
                                Text("Approved",
                                  style: TextStyle(
                                    color: AppColors.whiteColor(),
                                  ),),
                              ],
                            ),

                            Column(
                              children: [
                                Text("${logic.rejectedCount??0}",
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),),

                                const SizedBox(height: 2,),
                                Text("Rejected",
                                  style: TextStyle(
                                    color: AppColors.whiteColor(),
                                  ),),
                              ],
                            ),

                            Column(
                              children: [
                                Text("${logic.pendingCount??0}",
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),),

                                const SizedBox(height: 2,),
                                Text("Processing",
                                  style: TextStyle(
                                    color: AppColors.whiteColor(),
                                  ),),
                              ],
                            ),

                          ],
                        )

                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),



                  if(logic.getLeavesProcess)...[
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
                  ]else...[

                    if(logic.list.isNotEmpty)...[
                      const Text("Leave History",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),

                      Expanded(
                        child: ListView.builder(
                          itemCount: logic.list.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Leaves(leaveModel: logic.list[index],);
                          }),
                        ),
                      )
                    ]else...[
                      const Text("No Record",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                    ],


                  ],
                ]
              ],
            ),
          );
        },
      ),
    );
  }

}
