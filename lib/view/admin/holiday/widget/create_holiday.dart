import 'package:attendance/model/EventModel.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../utils/toast.dart';
import '../../../employee/leave/view.dart';
import '../../../other/widget/custom_button.dart';
import '../../../other/widget/custom_input.dart';
import '../logic.dart';

class CreateHoliday extends StatefulWidget {
  final double? paddingTop;
  final EventModel? applicationModel;
  const CreateHoliday({super.key, this.paddingTop,this.applicationModel});

  @override
  State<CreateHoliday> createState() => _CreateHolidayState();
}

class _CreateHolidayState extends State<CreateHoliday> {

  final TextEditingController eventController = TextEditingController();
  int? radioId;
  String? eventType;

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    if(widget.applicationModel != null){
      radioId = widget.applicationModel?.eventType == "event" ? 1 : 2;
      eventType = widget.applicationModel?.eventType;
      startDate = "${widget.applicationModel?.startDate}".toDateTime();
      endDate = "${widget.applicationModel?.endDate}".toDateTime();
      eventController.text = widget.applicationModel?.event??"";
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.appBackground,
      ),
      height: Get.height/1.5,
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

                      Text(widget.applicationModel != null ? "Update Holiday Event" : "Create Holiday event",
                        style: const TextStyle(
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

              const SizedBox(height: 15,),

              Row(
                children: [

                  Expanded(
                    child: InkWell(
                      onTap: (){
                        selectDate(context,initialDate: startDate).then((value) => {
                          startDate = value,
                          if(endDate != null && endDate!.isBefore(startDate!)){
                            endDate = null,
                          },
                         setState((){})
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Start Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          const SizedBox(height: 2,),
                          Container(
                            height: 40,
                            width: Get.width / 2,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor(),
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(10))
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text("${startDate??"Start Date"}".toDateDMMMY(),
                                  style: TextStyle(
                                    color: startDate == null ? Theme
                                        .of(context)
                                        .hintColor : null,
                                  ),),
                              ],
                            ),
                          ),
                          // CustomInputField(
                          //   enabled: false,
                          //   hintText: "Reason for leave",
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: InkWell(
                      onTap: startDate != null ? (){
                        selectDate(context,firstDate: startDate,initialDate: endDate).then((value) => {
                          endDate = value,
                        setState((){}),
                        });
                      } : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("End Date(Optional)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          const SizedBox(height: 2,),
                          Container(
                            height: 40,
                            width: Get.width / 2,
                            decoration: BoxDecoration(
                                color: startDate != null ? AppColors.whiteColor() : Colors.white54,
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(10))
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text("${endDate??"End Date"}".toDateDMMMY(),
                                  style: TextStyle(
                                    color: endDate == null ? Theme
                                        .of(context)
                                        .hintColor : null,
                                  ),),
                              ],
                            ),
                          ),
                          // CustomInputField(
                          //   enabled: false,
                          //   hintText: "Reason for leave",
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25,),

              const Text("Event Name"),

              const SizedBox(height: 5,),

              CustomInput(
                maxLine: 3,
                textController: eventController,
                hintText: "Type...",
              ),

              const SizedBox(height: 25,),

              const Text("Event Type"),

              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: radioId,
                        onChanged: (val) {
                          radioId = 1;
                          eventType = "event";
                          setState((){});
                        },
                      ),
                      const Text("Event")
                    ],
                  ),
                  const SizedBox(width: 30,),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: radioId,
                        onChanged: (val) {
                          radioId = 2;
                          eventType = "holiday";
                          setState((){});
                        },
                      ),
                      const Text("Holiday"),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              CustomButton(
                text: "${widget.applicationModel != null ? "Update" : "Create"} now",
                color: AppColors.primary,
                isLoading: logic.storeHolidayProcess,
                fontColor: AppColors.whiteColor(),
                onTap: (){
                  if(eventController.text.isEmpty){
                    Toast.show(toastMessage: "Enter Event name",isError: true);
                    return;
                  }
                  if(startDate == null){
                    Toast.show(toastMessage: "Start date empty",isError: true);
                    return;
                  }
                  if(eventType == null){
                    Toast.show(toastMessage: "Select Event Type",isError: true);
                    return;//eventType
                  }
                  dynamic body = {
                    "event_type" : eventType,
                    "event" : eventController.text ,
                    "start_date" : "${startDate!.year}-${startDate!.month}-${startDate!.day}" ,
                    "end_date" : endDate == null ? null : "${endDate!.year}-${endDate!.month}-${endDate!.day}"
                  };
                  if(widget.applicationModel != null){
                    logic.updateHoliday(body: body,id: widget.applicationModel?.id,callback: (){
                      Navigator.pop(context);
                      logic.getHolidays();
                    });
                  }else{
                    logic.storeHoliday(body: body,callback: (){
                      Navigator.pop(context);
                      logic.getHolidays();
                    });
                  }

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
