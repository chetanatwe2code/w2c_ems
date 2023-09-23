import 'package:attendance/model/BirthdayModel.dart';
import 'package:attendance/model/UsersModel.dart';
import 'package:attendance/utils/assets.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../common/punching/view.dart';

class HorizontalBirthdayView extends StatelessWidget {
  final BirthdayModel? model;
  final bool isFirst;
  const HorizontalBirthdayView({super.key,this.model,this.isFirst = false});


  @override
  Widget build(BuildContext context) {
    double fontSize = isFirst ? 15 : 12;
    double fontSize2 = isFirst ? 13 : 10;
    Color textColor = AppColors.textColor();
    String img = appBirthdayCake;
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: (){

          },
          child: Container(
            decoration: getDecoration(borderRadius: 50),
            width: isFirst ? Get.width*1 :  Get.width * 0.88,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            margin: const EdgeInsets.only(bottom: 3),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text((model?.name??"").toCapitalizeFirstLetter(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.normal,
                        color: textColor
                    ),),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //     color: AppColors.primaryColor().withOpacity(0.2),
                  //     border: Border.all(color: AppColors.primaryColor().withOpacity(0.5),width: 0.5),
                  //     borderRadius: const BorderRadius.all(Radius.circular(5))
                  // ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Flexible(
                        child: Text((model?.dateOfBirth??"").toDateDMMMYY(),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: fontSize2,
                              color:  textColor
                          ),),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                    opacity: 0.5,
                    child: Image.asset(img,width: isFirst ? 17 : 14,)),
              ],
            )),
      ],
    );
  }
}
