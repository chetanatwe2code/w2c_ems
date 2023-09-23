import 'package:attendance/core/routes.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/UsersModel.dart';
import '../../../../utils/assets.dart';
import '../../../auth/sign_up/logic.dart';
import '../../../common/punching/logic.dart';
import '../../../common/punching/view.dart';
import '../../../other/widget/custom_image.dart';

class UsersView extends StatelessWidget {
  final UsersModel? list;
  final DateTime? dateTime;
  const UsersView({Key? key, this.list,this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Attendance? attendance =  list?.attendance?.isNotEmpty == true ? list!.attendance!.first : null;

    DateTime? inDateTime = "${attendance?.inTime}".toDateTime();

    DateTime? outDateTime = "${attendance?.outTime}".toDateTime();


    StatusModel? isPresent = getPresentStatus(status: attendance?.status);

    StatusModel? isJoinOnTime = getStatusData(
        inTime: inDateTime,
        outTime: outDateTime,
        status: StatusFor.joinOnTime);

    StatusModel? isLeftOnTime = getStatusData(
        inTime: inDateTime,
        outTime: outDateTime,
        status: StatusFor.leftOnTime);

    return InkWell(
      onTap: list != null && dateTime != null ? (){
        Get.find<PunchingLogic>().initUser(list!.toJson(),dateTime!);
        Get.toNamed(rsPunchingPage);
      } : null,
      child: Container(
        decoration: getDecoration(),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [

            // first box
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      CustomImage(imageUrl: "",
                        assetPlaceholder: list?.gender == Gender.female.name ? appFemaleProfile : appMaleProfile,
                        width: 35,
                        height: 35,
                        radius: 20,
                      ),

                      const SizedBox(width: 5,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 4,),
                          Text(
                            "${list?.name}"
                                .toDateDMMMY()
                                .toDateDMMMY(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight
                                    .bold
                            ),),

                          const SizedBox(height: 4,),

                          if(isPresent != null)
                            Row(
                              children: [
                                Text(isPresent.text,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isPresent.color,
                                  ),),
                                if(isPresent.iconData != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(isPresent.iconData,size: 15, color: isPresent.color,),
                                  )
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),

            // second box
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: [

                  Text("${attendance?.inTime}".toTime(),
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight
                            .bold
                    ),),

                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("In-Time",
                        style: TextStyle(
                            color: isJoinOnTime?.color,
                            fontSize: 12
                        ),),
                    ],
                  ),

                ],
              ),
            ),

            // third box
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: [

                  Text("${attendance?.outTime}".toTime(),
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight
                            .bold
                    ),),

                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Out-Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: isLeftOnTime?.color,
                        ),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
