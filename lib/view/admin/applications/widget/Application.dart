import 'package:attendance/repository/application_repository.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/ApplicationModel.dart';
import '../../../../theme/app_colors.dart';
import '../../../common/punching/view.dart';
import '../../../other/dialog/approve_leave.dart';
import '../../../other/dialog/reject_leave.dart';

enum LeaveStatus { pending, approved,rejected }

LeaveStatus? getLeaveStatus(String? string){
  if(string == null) return null;

  if(string.endsWith(LeaveStatus.pending.name)){
    return LeaveStatus.pending;
  }
  if(string.endsWith(LeaveStatus.approved.name)){
    return LeaveStatus.approved;
  }
  if(string.endsWith(LeaveStatus.rejected.name)){
    return LeaveStatus.rejected;
  }
  return null;
}

class Application extends StatefulWidget {
  final ApplicationModel? model;
  final Function? updateLeaveCallback; // HorizontalApplication
  const Application({super.key,this.model,this.updateLeaveCallback});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  bool isApproving = false;
  bool isRejecting = false;

  @override
  Widget build(BuildContext context) {
    LeaveStatus? leaveStatus = getLeaveStatus(widget.model?.status);
    Color statusColor = leaveStatus == LeaveStatus.pending ? Colors.blue : (leaveStatus == LeaveStatus.approved ? AppColors.greenColor() : AppColors.redColor());
    return InkWell(
      child: Container(
        decoration: getDecoration(),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  if(widget.model?.userId?.name?.isNotEmpty??false)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(widget.model?.userId?.name??"",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textColor()
                        ),),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),

                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      margin: const EdgeInsets.only(left: 10),
                      child: Text("${widget.model?.status}".toCapitalizeFirstLetter(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColors.whiteColor(),
                            fontSize: 12
                        ),),
                    ),


                ],
              ),


            const SizedBox(height: 3,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor().withOpacity(0.2),
                      border: Border.all(color: AppColors.primaryColor().withOpacity(0.5),width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(
                        (widget.model?.endDate?.isNotEmpty??false) ?
                        (widget.model?.startDate??"").toDateDMMM() : (widget.model?.startDate??"").toDateDMMMYY(),
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryColor()
                        ),),

                      if(widget.model?.endDate?.isNotEmpty??false)
                        Text(" - ${(widget.model?.endDate??"").toDateDMMMYY()}",
                          style: TextStyle(
                              fontSize: 10,
                              color: AppColors.primaryColor()
                          ),),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Text(widget.model?.leaveType??"",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
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

            const SizedBox(height: 5,),

           if(widget.model?.reason?.isNotEmpty??false)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: ExpandableText(
                widget.model?.reason??"",
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                linkColor: Colors.blue,
                style: TextStyle(
                    color: AppColors.textColor()
                ),),
            ),

            if(widget.model?.status == "pending")
            Column(
              children: [
                //const SizedBox(height: 5,),
                const Divider(),
                //const SizedBox(height: 5,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          approveLeave(context,widget.model?.userId?.name??"",onPressed: (){
                            setState((){
                              isApproving = true;
                            });
                            Get.find<ApplicationRepository>().leavesUpdate({ "status" : "approved" },widget.model?.id).then((value) => {
                              if(value.body['success']){
                                if(widget.updateLeaveCallback != null){
                                  widget.updateLeaveCallback!("approved")
                                }
                              }
                            }).whenComplete(() => {
                              setState((){
                                isApproving = false;
                              })
                            });
                          });
                        },
                        child: isApproving ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: (AppColors.greenColor()).withOpacity(0.2),
                            shape: BoxShape.circle
                          ),
                          child: const SizedBox(
                            height: 24,
                            width: 24,
                            child:  CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 3,
                            ),
                          ),
                        ) :
                        Container(
                          decoration: const BoxDecoration(
                            color: (AppColors.primary),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          height: 30,
                          width: 100,
                          child: Center(
                            child: Text("Approve".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor(),
                              ),),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          rejectLeave(context,widget.model?.userId?.name??"",onPressed: (){
                            setState((){
                              isRejecting = true;
                            });
                            Get.find<ApplicationRepository>().leavesUpdate({ "status" : "rejected" },widget.model?.id).then((value) => {
                              if(value.body['success']){
                                if(widget.updateLeaveCallback != null){
                                  widget.updateLeaveCallback!("rejected")
                                }
                              }
                            }).whenComplete(() => {
                              setState((){
                                isRejecting = false;
                              })
                            });
                          });
                        },
                        child: isRejecting ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: (AppColors.redColor()).withOpacity(0.2),
                              shape: BoxShape.circle
                          ),
                          height: 30,
                          width: 100,
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child:  CircularProgressIndicator(
                              color: AppColors.redColor(),
                              strokeWidth: 3,
                            ),
                          ),
                        ) :
                        Container(
                          decoration: const BoxDecoration(
                            color: (AppColors.secondary),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          height: 30,
                          width: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2),
                          child: Center(
                            child: Text("Reject".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor(),
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
