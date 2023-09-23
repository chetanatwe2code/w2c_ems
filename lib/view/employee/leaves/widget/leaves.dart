import 'package:attendance/utils/date_converter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../model/ApplicationModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../admin/applications/widget/Application.dart';
import '../../../common/punching/view.dart';

class Leaves extends StatelessWidget {
  final ApplicationModel? leaveModel;
  const Leaves({Key? key, this.leaveModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LeaveStatus? leaveStatus = getLeaveStatus(leaveModel?.status);
    Color statusColor = leaveStatus == LeaveStatus.pending ? Colors.blue : (leaveStatus == LeaveStatus.approved ? AppColors.greenColor() : AppColors.redColor());
    return Container(
      decoration: getDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              if(leaveModel?.userId?.name?.isNotEmpty??false)
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(leaveModel?.userId?.name??"",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor()
                    ),),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),

                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.only(left: 10),
                  child: Text("${leaveModel?.status}".toCapitalizeFirstLetter(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                        fontSize: 12
                    ),),
                ),


            ],
          ),

          const SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor(),width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      (leaveModel?.endDate?.isNotEmpty??false) ?
                      (leaveModel?.startDate??"").toDateDMMM() : (leaveModel?.startDate??"").toDateDMMMYY(),
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor()
                      ),),

                    if(leaveModel?.endDate?.isNotEmpty??false)
                      Text(" - ${(leaveModel?.endDate??"").toDateDMMMYY()}",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor()
                        ),),
                  ],
                ),
              ),

              Column(
                children: [
                  Text(leaveModel?.leaveType??"",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark
                    ),),

                  // Text((widget.model?.leaveTime??""),
                  //   style: TextStyle(
                  //     color: AppColors.secondary.withOpacity(0.5),
                  //     fontSize: 12,
                  //   ),),
                ],
              ),
            ],
          ),

          if(leaveModel?.reason?.isNotEmpty??false)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: ExpandableText(
                leaveModel?.reason??"",
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                linkColor: Colors.blue,
                style: TextStyle(
                    color: AppColors.textColor()
                ),),
            ),

          const SizedBox(height: 5,),
        ],
      ),
    );
  }

}
