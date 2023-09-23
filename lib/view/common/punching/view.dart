import 'package:attendance/utils/assets.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes.dart';
import '../../../repository/home_repository.dart';
import '../../../theme/app_colors.dart';
import '../../other/animation/show_animated_dialog.dart';
import '../../other/widget/custom_button.dart';
import '../../other/widget/custom_image.dart';
import '../account/logic.dart';
import 'logic.dart';
import 'widget/attendance_view.dart';

class StatusModel {
  Color? color;
  IconData? iconData;
  String text;
  String shortText;

  StatusModel({this.iconData, this.text = "", this.shortText = "", this.color});
}

BoxDecoration getDecoration({ Color? color, double? borderRadius }) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
    boxShadow: [
      BoxShadow(
        color: (const Color(0xFF333333)).withOpacity(0.5),
        blurRadius: 4,
        offset: const Offset(
            0, 0), // Shadow position
      ),
    ],
  );
}

enum StatusFor { joinOnTime, leftOnTime }

double maxInTimeHour = 9;
double maxInTimeMinute = 45;

double minOutTimeHour = 18;
double minOutTimeMinute = 30;

double halfDayTime = 4;

StatusModel? getStatusData(
    {StatusFor? status, DateTime? inTime, DateTime? outTime }) {
  if (status == StatusFor.joinOnTime) {
    if (inTime == null) return null;
    if ((inTime.hour <= maxInTimeHour && inTime.minute <= maxInTimeMinute)) {
      return StatusModel(
          color: Colors.green,
          text: "On Time",
          shortText: "T"
      );
    } else {
      return StatusModel(
          color: Colors.orange,
          text: "Late Coming",
          shortText: "L"
      );
    }
  }

  if (status == StatusFor.leftOnTime) {
    if (inTime == null || outTime == null) return null;

    if ((outTime.hour >= minOutTimeHour &&
        ((outTime.hour) > minOutTimeHour ? true : (outTime.minute) >=
            minOutTimeMinute))) {
      return StatusModel(
          color: Colors.green,
          text: "Left on time",
          shortText: "T"
      );
    } else {
      return StatusModel(
          color: Colors.orange,
          text: "",
          shortText: "L"
      );
    }
  }

  return null;
}

double hPadding = 15;

class PunchingPage extends GetView<PunchingLogic> {
  const PunchingPage({Key? key}) : super(key: key);


  confirmIn(BuildContext context, bool isLeftNow) async {
    await showAnimatedDialog(
        context,
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  top: 5,
                  child: Row(
                    children: [
                      Text(!isLeftNow ? "Punch In" : "Punch Out?",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Are you sure?",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('NO', style: TextStyle(
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (isLeftNow) {
                                controller.punchingIn = false;
                                controller.punchingOut = true;
                              } else {
                                controller.punchingOut = false;
                                controller.punchingIn = true;
                              }
                              controller.update();
                              controller.askGpsPermission();
                            },
                            child: Text(
                              'YES',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  markAttendance(BuildContext context, String name,
      PresentStatus status) async {
    await showAnimatedDialog(
        context,
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  top: 5,
                  child: Row(
                    children: [
                      Text("Mark ${status.name}? $name",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Are you sure Mark?",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('NO', style: TextStyle(
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.isMarkAttendance = status;
                              controller.update();
                              controller.markAttendance(status: status);
                            },
                            child: Text(
                              'YES',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    controller.checkAttempt();
    controller.getHistory();
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: 0,
        shadowColor: Colors.black,
        actions: [
          //
          // IconButton(onPressed: () {
          //
          // }, icon: const Icon(Icons.notifications)),


          GetBuilder<PunchingLogic>(
            assignId: true,
            builder: (logic) {
              return Row(
                children: [
                if(logic.user == null)
                  PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem<int>(
                            value: 0,
                            child: Text("My Account"),
                          ),

                          // const PopupMenuItem<int>(
                          //   value: 1,
                          //   child: Text("Task"),
                          // ),
                          //
                          //
                          // const PopupMenuItem<int>(
                          //   value: 2,
                          //   child: Text("Leave"),
                          // ),

                          const PopupMenuItem<int>(
                            value: 1,
                            child: Text("Logout"),
                          ),

                        ];
                      },
                      onSelected: (value) {
                        if (value == 0) {
                          Get.toNamed(rsAccountPage);
                        }
                        // else if (value == 1) {
                        //   Get.toNamed(rsEmployeeTaskPage);
                        // }
                        // else if (value == 2) {
                        //   Get.toNamed(rsLeavesPage);
                        // }
                        else if (value == 1) {

                          Get.find<AccountLogic>().logout();
                        }
                      }
                  ),
                ],
              );
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.only(
                    top: 10, bottom: 10, left: hPadding, right: hPadding),
                child: GetBuilder<PunchingLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              const SizedBox(width: 5,),

                              if(logic.user?.name?.isNotEmpty ?? false)...[
                                Flexible(
                                  child: Row(
                                    children: [
                                      CustomImage(imageUrl: "",assetPlaceholder: appMaleProfile,height: 25,width: 25,),
                                      const SizedBox(width: 5,),
                                      Flexible(
                                        child: Text((logic.user?.name ?? ""),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                          ),),
                                      )
                                    ],
                                  ),
                                ),

                              ] else
                                ...[
                                  GetBuilder<AccountLogic>(
                                    assignId: true,
                                    builder: (logic) {
                                      return Flexible(
                                        child: Text(logic.userModel?.name ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                          ),),
                                      );
                                    },
                                  ),
                                ],
                            ],
                          ),
                        ),

                        const SizedBox(width: 5,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [

                                Text("${logic.dateTime ?? DateTime.now()}"
                                    .toDateDMMMYY(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),),

                                if(logic.dateTime == null)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text("Today",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),),
                                  ),

                              ],
                            ),

                            if((logic.dateTime ?? DateTime.now()).weekday == DateTime.sunday)
                              Text("Sunday",
                                style: TextStyle(
                                  color: AppColors.redColor(),
                                  fontWeight: FontWeight.bold,
                                ),),

                            if(logic.isHoliday != null)
                              Text("${logic.isHoliday?.name}",
                                style: TextStyle(
                                  color: AppColors.redColor(),
                                  fontWeight: FontWeight.bold,
                                ),),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              GetBuilder<PunchingLogic>(
                assignId: true,
                builder: (logic) {
                  return Container(
                    height: 115,
                    width: Get.width,
                    margin: EdgeInsets.all(hPadding),
                    decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    padding: EdgeInsets.all(hPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${logic.dateTime ?? DateTime.now()}"
                                .toDateMMMMYYYY(),
                              style: TextStyle(
                                  color: AppColors.whiteColor(),
                                  fontWeight: FontWeight.w800
                              ),),

                            // Row(
                            //   children: [
                            //     Text("View All",
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w800
                            //       ),),
                            //     SizedBox(width: 2,),
                            //     Icon(Icons.arrow_forward_ios, size: 13,
                            //       color: Colors.white,),
                            //   ],
                            // ),
                          ],
                        ),


                        const SizedBox(height: 18,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              children: [
                                Text("${logic.presentCount}",
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),),

                                const SizedBox(height: 2,),
                                Text("Present",
                                  style: TextStyle(
                                    color: AppColors.whiteColor(),
                                  ),),
                              ],
                            ),

                            Column(
                              children: [
                                Text("${logic.letComing}",
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),),

                                const SizedBox(height: 2,),
                                Text("Late",
                                  style: TextStyle(
                                    color: AppColors.whiteColor(),
                                  ),),
                              ],
                            ),


                            Column(
                              children: [
                                Text("${logic.absentCount}",
                                  style: TextStyle(
                                      color: AppColors.whiteColor(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),),

                                const SizedBox(height: 2,),
                                Text("Absent",
                                  style: TextStyle(
                                    color: AppColors.whiteColor(),
                                  ),),
                              ],
                            ),


                          ],
                        )

                      ],
                    ),
                  );
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: const Calendar(),
              // ),
              //
              const SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: GetBuilder<PunchingLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        if(logic.user == null && logic.isHoliday == null && (logic.dateTime ?? DateTime.now()).weekday != DateTime.sunday)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [


                              Expanded(
                                child: CustomButton(
                                  text: "Punch In",
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  height: 40,
                                  isLoading: logic.punchingIn,
                                  isEnable: logic.attemptStep ==
                                      AttemptStep.none && logic.isValidInTime(),
                                  borderRadius: 5,
                                  horizontalPadding: 25,
                                  onTap: () {
                                    if (logic.punchingIn != true) {
                                      confirmIn(context, false);
                                    }
                                  },
                                ),
                              ),

                              const SizedBox(width: 20,),

                              Expanded(
                                child: CustomButton(
                                  text: "Punch Out",
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  height: 40,
                                  isLoading: logic.punchingOut,
                                  isEnable: logic.attemptStep ==
                                      AttemptStep.isAttemptIn &&
                                      logic.isValidOutTime(),
                                  borderRadius: 5,
                                  horizontalPadding: 25,
                                  onTap: () {
                                    if (logic.punchingOut != true) {
                                      confirmIn(context, true);
                                    }
                                  },
                                ),
                              ),

                            ],
                          ),

                        if(logic.user != null && logic.isHoliday == null)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [


                                    Expanded(
                                      child: CustomButton(
                                        text: "Present",
                                        fontColor: Colors.white,
                                        color: Colors.green,
                                        height: 35,
                                        isLoading: logic.isMarkAttendance == PresentStatus.P,
                                        //isEnable: logic.attemptStep == AttemptStep.none,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.P);
                                        },
                                      ),
                                    ),

                                    const SizedBox(width: 10,),

                                    Expanded(
                                      child: CustomButton(
                                        text: "Late",
                                        fontColor: Colors.white,
                                        height: 35,
                                        color: Colors.amber,
                                        isLoading: logic.isMarkAttendance ==
                                            PresentStatus.L,
                                        //isEnable: logic.attemptStep != AttemptStep.isAttemptBoth,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.L);
                                        },
                                      ),
                                    ),

                                    const SizedBox(width: 10,),

                                    Expanded(
                                      child: CustomButton(
                                        text: "Half Day",
                                        fontColor: Colors.white,
                                        color: Colors.blue,
                                        height: 35,
                                        isLoading: logic.isMarkAttendance ==
                                            PresentStatus.HD,
                                        //isEnable: logic.attemptStep == AttemptStep.none,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.HD);
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [

                                    Expanded(
                                      child: CustomButton(
                                        text: "WFH",
                                        fontColor: Colors.white,
                                        height: 35,
                                        color: Colors.green,
                                        isLoading: logic.isMarkAttendance ==
                                            PresentStatus.WH,
                                        //isEnable: logic.attemptStep != AttemptStep.isAttemptBoth,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.WH);
                                        },
                                      ),
                                    ),

                                    const SizedBox(width: 10,),

                                    Expanded(
                                      child: CustomButton(
                                        text: "CL",
                                        fontColor: Colors.white,
                                        height: 35,
                                        color: AppColors.redColor(),
                                        isLoading: logic.isMarkAttendance ==
                                            PresentStatus.CL,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.CL);
                                        },
                                      ),
                                    ),

                                    const SizedBox(width: 10,),

                                    Expanded(
                                      child: CustomButton(
                                        text: "EL/ML",
                                        fontColor: Colors.white,
                                        height: 35,
                                        color: AppColors.redColor(),
                                        isLoading: logic.isMarkAttendance ==
                                            PresentStatus.ML,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.ML);
                                        },
                                      ),
                                    ),

                                    // Expanded(
                                    //   child: CustomButton(
                                    //     text: "Leave",
                                    //     fontColor: Colors.white,
                                    //     color: AppColors.redColor(),
                                    //     height: 35,
                                    //     isLoading: logic.isMarkAttendance == PresentStatus.EL,
                                    //     //isEnable: logic.attemptStep == AttemptStep.none,
                                    //     borderRadius: 5,
                                    //     horizontalPadding: 10,
                                    //     onTap: () {
                                    //       markAttendance(context,logic.user?.name??"",PresentStatus.EL);
                                    //     },
                                    //   ),
                                    // ),

                                    const SizedBox(width: 10,),

                                    Expanded(
                                      child: CustomButton(
                                        text: "Absent",
                                        fontColor: Colors.white,
                                        height: 35,
                                        color: AppColors.redColor(),
                                        isLoading: logic.isMarkAttendance ==
                                            PresentStatus.A,
                                        //isEnable: logic.attemptStep != AttemptStep.isAttemptBoth,
                                        borderRadius: 5,
                                        horizontalPadding: 10,
                                        onTap: () {
                                          markAttendance(
                                              context, logic.user?.name ?? "",
                                              PresentStatus.A);
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              const SizedBox(height: 10,),
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ),


              GetBuilder<PunchingLogic>(
                assignId: true,
                builder: (logic) {
                  return Column(
                    children: [

                      if(logic.getHistoryProcess)...[
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
                      ] else
                        ...[
                          if(logic.list.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ListView.builder(
                                  itemCount: logic.list.length,
                                  padding: EdgeInsets.only(
                                      top: 20, left: hPadding, right: hPadding),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    bool showMonth = false;
                                    if (logic.lastMonth !=
                                        "${logic.list[index].date}"
                                            .toDateMMMMYYYY()) {
                                      showMonth = true;
                                      logic.lastMonth =
                                          "${logic.list[index].date}"
                                              .toDateMMMMYYYY();
                                    }
                                    return AttendanceView(
                                      showMonth: showMonth,
                                      list: logic.list[index],);
                                  },),

                              ],
                            )
                        ],


                    ],
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
