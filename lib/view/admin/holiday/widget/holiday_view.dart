import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/EventModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/punching/view.dart';
import 'create_holiday.dart';
import 'delete_holiday.dart';

class HolidayView extends StatelessWidget {
  final EventModel? model;
  const HolidayView({super.key,this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.bottomSheet(
          CreateHoliday(paddingTop: MediaQuery
              .of(context)
              .padding
              .top,
            applicationModel: model,
          ),
          isScrollControlled: true,
          barrierColor: Colors.transparent,
          isDismissible: false,
        );
      },
      child: Container(
        decoration: getDecoration(),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text((model?.event??"").toCapitalizeFirstLetter(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor()
                    ),),
                ),

                Text((model?.eventType??"").toCapitalizeFirstLetter(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.textColor(),
                  ),),
              ],
            ),

            const SizedBox(height: 5,),

            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor().withOpacity(0.2),
                  border: Border.all(color: AppColors.primaryColor().withOpacity(0.5),width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    (model?.endDate?.isNotEmpty??false) ?
                    (model?.startDate??"").toDateDMMM() : (model?.startDate??"").toDateDMMMYY(),
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor()
                    ),),

                  if(model?.endDate?.isNotEmpty??false)
                    Text(" - ${(model?.endDate??"").toDateDMMMYY()}",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor()
                      ),),
                ],
              ),
            ),

            if(model?.createdBy != null)...[
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Create by: "),
                      Text("${model?.createdBy?.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Get.bottomSheet(
                        DeleteHoliday(paddingTop: MediaQuery
                            .of(context)
                            .padding
                            .top,
                          applicationModel: model,
                        ),
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        isDismissible: false,
                      );
                    },
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.redColor().withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.redColor(),width: 0.1)
                        ),
                        child: Icon(Icons.delete_forever,color: AppColors.redColor(),)),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
