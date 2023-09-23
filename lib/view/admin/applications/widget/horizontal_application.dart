import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../model/ApplicationModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/punching/view.dart';
import 'Application.dart';

class HorizontalApplication extends StatefulWidget {
  final ApplicationModel? model;
  final bool isFirst;
  final Function? updateLeaveCallback; // HorizontalApplication
  const HorizontalApplication({super.key,this.model,this.updateLeaveCallback,this.isFirst = false});

  @override
  State<HorizontalApplication> createState() => _HorizontalApplicationState();
}

class _HorizontalApplicationState extends State<HorizontalApplication> {

  bool isApproving = false;
  bool isRejecting = false;

  @override
  Widget build(BuildContext context) {
    bool isToday = false;

    DateTime? startDate  = "${widget.model?.startDate}".toDateTime();
    DateTime? endDate  = "${widget.model?.endDate}".toDateTime();

    if (startDate != null) {
      isToday = isSameDay(DateTime.now(), startDate) ||
          (endDate != null &&
              (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) ||
              isSameDay(DateTime.now(), endDate));
    }

    double fontSize = isToday ? 15 : 12;
    double fontSize2 = isToday ? 13 : 10;
    Color textColor = AppColors.textColor();
    LeaveStatus? leaveStatus = getLeaveStatus(widget.model?.status);
    IconData iconData = leaveStatus == LeaveStatus.pending ? Icons.refresh : (leaveStatus == LeaveStatus.approved ? Icons.check : Icons.clear);
    Color statusColor = leaveStatus == LeaveStatus.pending ? Colors.blue : (leaveStatus == LeaveStatus.approved ? AppColors.greenColor() : AppColors.redColor());
    return Column(
      children: [
        Container(
          decoration: getDecoration(borderRadius: 50),
          width: isToday ? Get.width*1 :  Get.width * 0.88,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          margin: const EdgeInsets.only(bottom: 3),
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text((widget.model?.userId?.name??"").toCapitalizeFirstLetter(),
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                      color: textColor
                  ),),
              ),
              Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Flexible(
                        child: Text(
                          (widget.model?.endDate?.isNotEmpty??false) ?
                          (widget.model?.startDate??"").toDateDMMM() : (widget.model?.startDate??"").toDateDMMMYY(),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: fontSize2,
                              color:  textColor
                          ),),
                      ),

                      if(widget.model?.endDate?.isNotEmpty??false)
                        Flexible(
                          child: Text(" - ${(widget.model?.endDate??"").toDateDMMMYY()}",
                            style: TextStyle(
                                fontSize: fontSize2,
                                color: textColor
                            ),),
                        ),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusColor,
                      ),
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(left: 5),
                      child: Icon(iconData,color: AppColors.whiteColor(),size: 15,)),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }

}
