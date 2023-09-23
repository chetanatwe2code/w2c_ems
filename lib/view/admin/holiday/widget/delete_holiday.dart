import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/EventModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../other/widget/custom_button.dart';
import '../logic.dart';

class DeleteHoliday extends StatelessWidget {
  final double? paddingTop;
  final EventModel? applicationModel;
  const DeleteHoliday({super.key, this.paddingTop,this.applicationModel});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      height: Get.height/3,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GetBuilder<HolidayLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Text("Delete Holiday event",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),),

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                            // border: Border.all(color: Colors.red,width: 0.1)
                          ),
                          child: Icon(
                            Icons.clear,
                            color: AppColors.redColor(),),
                        ),
                      ),
                    ],
                  )
              ),

              const Divider(),

              const SizedBox(height: 10),

              Flexible(child: Text("${applicationModel?.event}",maxLines: 2,)),

              const SizedBox(height: 10),

              const Spacer(),

              CustomButton(
                text: "Delete Event Holiday",
                color: AppColors.redColor().withOpacity(0.2),
                isLoading: logic.deleteHolidayProcess,
                fontColor: AppColors.redColor(),
                fontWeight: FontWeight.bold,
                onTap: (){
                  logic.destroyHoliday(id: applicationModel?.id,callback: (){
                    Navigator.pop(context);
                    logic.getHolidays();
                  });
                },
              ),

              const Spacer(),

            ],
          );
        },
      ),
    );
  }

}
