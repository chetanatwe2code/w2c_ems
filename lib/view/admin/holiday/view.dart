import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../common/punching/view.dart';
import 'logic.dart';
import 'widget/create_holiday.dart';
import 'widget/holiday_view.dart';

class HolidayPage extends GetView<HolidayLogic> {
  const HolidayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getHolidays();

    return Scaffold(
      appBar: AppBar(title: const Text("Events and holiday")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            CreateHoliday(paddingTop: MediaQuery
                .of(context)
                .padding
                .top),
            isScrollControlled: true,
            barrierColor: Colors.transparent,
            isDismissible: false,
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: AppColors.appBackground,
      body: GetBuilder<HolidayLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            mainAxisAlignment: logic.getHolidaysProcess ? MainAxisAlignment
                .center : MainAxisAlignment.start,
            children: [

              if(logic.getHolidaysProcess)...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ],
                ),
              ] else
                ...[

                  // if(logic.selectedDateTime != null)
                  //  InkWell(
                  //    onTap: (){
                  //      Get.bottomSheet(
                  //        CreateHoliday(paddingTop: MediaQuery
                  //            .of(context)
                  //            .padding
                  //            .top),
                  //        isScrollControlled: true,
                  //        barrierColor: Colors.transparent,
                  //        isDismissible: false,
                  //      );
                  //    },
                  //    child: Container(
                  //      decoration: const BoxDecoration(
                  //        color: AppColors.secondary,
                  //        borderRadius: BorderRadius.all(Radius.circular(5))
                  //      ),
                  //      margin: EdgeInsets.symmetric(horizontal: hPadding),
                  //      padding: EdgeInsets.symmetric(vertical: hPadding),
                  //      child: Row(
                  //        mainAxisAlignment: MainAxisAlignment.center,
                  //        children: [
                  //          Text("Create Holiday On ${"${logic.selectedDateTime??""}".toDateDMMMY()}",
                  //          style: TextStyle(
                  //            color: AppColors.whiteColor(),
                  //            fontWeight: FontWeight.bold
                  //          ),)
                  //        ],
                  //      ),
                  //    ),
                  //  ),

                  const SizedBox(height: 15,),

                  if(logic.list.isNotEmpty)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: ListView.builder(
                              itemCount: logic.list.length,
                              padding: EdgeInsets.only(
                                  top: 20, left: hPadding, right: hPadding),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return HolidayView(model: logic.list[index]);
                              },),
                          ),
                        ],
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
