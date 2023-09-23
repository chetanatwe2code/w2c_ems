import 'package:attendance/core/routes.dart';
import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/base/base_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../calendar/new_calendar.dart';
import '../../common/account/logic.dart';
import '../../common/punching/view.dart';
import '../../common/task_list/logic.dart';
import '../applications/widget/horizontal_application.dart';
import '../holiday/widget/horizontal_birthday_view.dart';
import '../holiday/widget/horizontal_holiday_view.dart';
import '../project/widget/task_view.dart';
import 'chart/home_chart.dart';
import 'logic.dart';
import 'widget/users_view.dart';


class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    controller.attendanceByDate();
    controller.getHolidayByMonth();
    controller.getLeavesByMonth();
    controller.getUserWithTasksCount();
    //double widthCount = Get.width/4;
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 0,
        shadowColor: Colors.black,
        actions: [

          // IconButton(onPressed: () {
          //
          // }, icon: const Icon(Icons.notifications)),

          PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("My Account"),
                  ),

                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Employee"),
                  ),

                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Create Employee"),
                  ),

                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Get.toNamed(rsAccountPage);
                }else if (value == 1) {
                  Get.toNamed(rsEmployeePage);
                }    else if (value == 2) {
                  Get.toNamed(rsSignUpPage,arguments: { "created_by" : Get.find<AccountLogic>().userModel?.id});
                }else if (value == 3) {
                  Get.find<AccountLogic>().logout();
                }
              }
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomeLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPadding,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.find<BaseLogic>().onItemTapped(1);
                        },
                        child: Container(
                          height: 110,
                          width: (Get.width/2) - (hPadding*2),
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.contacts,size: 44,color: AppColors.whiteColor(),),
                              const SizedBox(height: 10,),
                              Text("Attendance",
                              style: TextStyle(
                                color: AppColors.whiteColor(),
                                fontWeight: FontWeight.bold
                              ),),
                            ],
                          )),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Get.find<BaseLogic>().onItemTapped(3);
                        },
                        child: Container(
                          height: 110,
                          width: (Get.width/2) - (hPadding*2),
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryDark,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.checklist,size: 44,color: AppColors.whiteColor(),),
                              const SizedBox(height: 10,),
                              Text("Task",
                                style: TextStyle(
                                    color: AppColors.whiteColor(),
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPadding,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.find<BaseLogic>().onItemTapped(2);
                        },
                        child: Container(
                          height: 110,
                          width: (Get.width/2) - (hPadding*2),
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryDark,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.offline_bolt_rounded,size: 44,color: AppColors.whiteColor(),),
                              const SizedBox(height: 10,),
                              Text("Leave",
                                style: TextStyle(
                                    color: AppColors.whiteColor(),
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          )),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Get.toNamed(rsHolidayPage);
                          //Get.find<BaseLogic>().onItemTapped(2);
                        },
                        child: Container(
                          height: 110,
                          width: (Get.width/2) - (hPadding*2),
                          decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.event,size: 44,color: AppColors.whiteColor(),),
                              const SizedBox(height: 10,),
                              Text("Event",
                                style: TextStyle(
                                    color: AppColors.whiteColor(),
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: NewCalendar(
                //     selectedDate: (dateTime){
                //       controller.dateTime = dateTime;
                //       controller.getUsers();
                //     },
                //     holidays: logic.holiday,
                //     lastDay: DateTime.now(),
                //   ),
                // ),

               // const SizedBox(height: 15,),
                //
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: MyCalendar(
                //     holidays: logic.holiday,
                //     selectedDate: (dateTime) {
                //       controller.dateTime = dateTime;
                //       controller.getUsers();
                //     },
                //   ),
                // ),

                if(logic.getAttendanceByMonth)...[
                  const SizedBox(height: 50,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ],
                  ),
                ]else...[

                  const SizedBox(height: 10,),

                  // Container(
                  //   height: 121,
                  //   width: Get.width,
                  //   margin: EdgeInsets.all(hPadding),
                  //   decoration: getDecoration(color: AppColors.primary),
                  //   padding: EdgeInsets.all(hPadding),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           InkWell(
                  //             onTap: logic.getAttendanceByMonth ? null : (){
                  //               if(logic.attendanceType == 1){
                  //                 logic.attendanceByMonth();
                  //               }else{
                  //                 logic.getUsers();
                  //               }
                  //             },
                  //             child: Text(
                  //               logic.attendanceType == 1 ?
                  //               "${logic.dateTime ?? DateTime.now()}".toDateDMMM() :
                  //               "${logic.dateTime ?? DateTime.now()}".toDateDMMMY(),
                  //               style: TextStyle(
                  //                   color: AppColors.whiteColor(),
                  //                   fontWeight: FontWeight.w800
                  //               ),),
                  //           ),
                  //         ],
                  //       ),
                  //
                  //
                  //       const SizedBox(height: 15,),
                  //
                  //       SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //
                  //             SizedBox(
                  //               width: widthCount,
                  //               child: Column(
                  //                 children: [
                  //                   Text("${logic.attendanceCount.presentCount}",
                  //                     style: TextStyle(
                  //                         color: AppColors.whiteColor(),
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.w800
                  //                     ),),
                  //
                  //                   const SizedBox(height: 2,),
                  //                   Text("Present",
                  //                     style: TextStyle(
                  //                       color: AppColors.whiteColor(),
                  //                     ),),
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //             SizedBox(
                  //               width: widthCount,
                  //               child: Column(
                  //                 children: [
                  //                   Text("${logic.attendanceCount.letComing}",
                  //                     style: TextStyle(
                  //                         color: AppColors.whiteColor(),
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.w800
                  //                     ),),
                  //
                  //                   const SizedBox(height: 2,),
                  //                   Text("Late",
                  //                     style: TextStyle(
                  //                       color: AppColors.whiteColor(),
                  //                     ),),
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //             SizedBox(
                  //               width: widthCount,
                  //               child: Column(
                  //                 children: [
                  //                   Text("${logic.attendanceCount.absentCount}",
                  //                     style: TextStyle(
                  //                         color: AppColors.whiteColor(),
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.w800
                  //                     ),),
                  //
                  //                   const SizedBox(height: 2,),
                  //                   Text("Absent",
                  //                     style: TextStyle(
                  //                       color: AppColors.whiteColor(),
                  //                     ),),
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //             SizedBox(
                  //               width: widthCount,
                  //               child: Column(
                  //                 children: [
                  //                   Text("${logic.attendanceCount.halfDayCount}",
                  //                     style: TextStyle(
                  //                         color: AppColors.whiteColor(),
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.w800
                  //                     ),),
                  //
                  //                   const SizedBox(height: 2,),
                  //                   Text("Half Day",
                  //                     style: TextStyle(
                  //                       color: AppColors.whiteColor(),
                  //                     ),),
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //             SizedBox(
                  //               width: widthCount,
                  //               child: Column(
                  //                 children: [
                  //                   Text("${logic.attendanceCount.workHomeCount}",
                  //                     maxLines: 1,
                  //                     style: TextStyle(
                  //                         color: AppColors.whiteColor(),
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.w800
                  //                     ),),
                  //
                  //                   const SizedBox(height: 2,),
                  //                   Text("Remote Work",
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                       color: AppColors.whiteColor(),
                  //                     ),),
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //       )
                  //
                  //     ],
                  //   ),
                  // ),

                  InkWell(
                    onTap: (){
                      Get.toNamed(rsAttendanceSummaryPage);
                    },
                    child: Container(
                      decoration: getDecoration(borderRadius: 20),
                      margin: EdgeInsets.symmetric(horizontal: hPadding,vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: hPadding,vertical: 8),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month,size: 20,),
                          SizedBox(width: 10,),
                          Text("Monthly Attendance"),
                        ],
                      ),
                    ),
                  ),

                 if(logic.count.isNotEmpty)
                  Container(
                      decoration: getDecoration(color: AppColors.whiteColor(),borderRadius: 10),
                    margin: EdgeInsets.symmetric(horizontal: hPadding),
                    //color: Colors.white,
                      height: 150,
                      width: Get.width,
                      child: Center(
                        child: HomeChart(
                          count: logic.count,
                          activeEmployee: logic.activeEmployee,
                        ),
                      )),

                  if(logic.thisMonthBirthday.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          const Text("Birthday",
                            style: TextStyle(
                                fontSize: 17
                            ),),
                          const SizedBox(height: 10,),
                          ListView.builder(
                            itemCount: logic.thisMonthBirthday.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return HorizontalBirthdayView(model: logic.thisMonthBirthday[index],isFirst: index == 0,);
                            },),
                        ],
                      ),
                    ),


                  if(logic.thisMonthEvent.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        const Text("Events And Holiday",
                        style: TextStyle(
                          fontSize: 17
                        ),),
                        const SizedBox(height: 10,),
                        ListView.builder(
                          itemCount: logic.thisMonthEvent.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return HorizontalHolidayView(model: logic.thisMonthEvent[index],isFirst: index == 0,);
                          },),
                      ],
                    ),
                  ),

                  if(logic.thisMonthLeaves.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),

                          const Text("Leave Request",
                            style: TextStyle(
                                fontSize: 17
                            ),),
                          const SizedBox(height: 15,),
                          ListView.builder(
                            itemCount: logic.thisMonthLeaves.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return HorizontalApplication(model: logic.thisMonthLeaves[index],isFirst: index == 0,);
                            },),
                        ],
                      ),
                    ),

                  if(logic.userTaskCountModel.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),

                          const Text("Tasks",
                            style: TextStyle(
                                fontSize: 17
                            ),),
                          const SizedBox(height: 15,),
                          SizedBox(
                            height: 63,
                            child: ListView.builder(
                              itemCount: logic.userTaskCountModel.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Get.find<TaskListLogic>().setUser(userId: logic.userTaskCountModel[index].id,userName: logic.userTaskCountModel[index].name);
                                    Get.find<BaseLogic>().onItemTapped(2);
                                  },
                                  child: Container(
                                    decoration: getDecoration(),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(right: 10,top: 5,bottom: 5,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: generateDarkColor("${logic.userTaskCountModel[index].name}"),
                                              shape: BoxShape.circle
                                          ),
                                          child: Center(child: Text("${logic.userTaskCountModel[index].name}".toImageName(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.whiteColor(),
                                                fontWeight: FontWeight.w500
                                            ),)),
                                        ),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${logic.userTaskCountModel[index].name}"),
                                            //SizedBox(height: 2,),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Row(
                                                children: [
                                                  const Text("Task: ",
                                                    style: TextStyle(
                                                        fontSize: 12.5,
                                                    ),),
                                                  Text("${logic.userTaskCountModel[index].totalTask}",
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12.5,
                                                        color: AppColors.primary
                                                    ),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 10,),

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        if(logic.isHoliday != null)
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: hPadding, right: hPadding),
                            child: Row(
                              children: [
                                Text(logic.isHoliday?.name??"",
                                style: const TextStyle(
                                  fontSize: 17
                                ),),
                              ],
                            ),
                          ),

                        // if(logic.isHoliday == null && logic.dateTime?.weekday != DateTime.sunday)
                        // ListView.builder(
                        //   itemCount: logic.list.length,
                        //   padding: EdgeInsets.only(
                        //       top: 20, left: hPadding, right: hPadding),
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   itemBuilder: (context, index) {
                        //     return UsersView(list: logic.list[index],
                        //       dateTime: logic.dateTime,);
                        //   },),

                      ],
                    )
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
