import 'package:attendance/utils/date_converter.dart';
import 'package:flutter/material.dart';

import '../../../../model/AttendaceModel.dart';
import '../../punching/view.dart';
import '../logic.dart';
import '../view.dart';

class AttendanceView extends StatelessWidget {
  final AttendanceModel? list;
  final bool showMonth;
  const AttendanceView({Key? key, this.list,this.showMonth = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? inDateTime = "${list?.inTime}".toDateTime();

    DateTime? outDateTime = "${list?.outTime}".toDateTime();


    StatusModel? isPresent = getPresentStatus(status: list?.status);

    StatusModel? isJoinOnTime = getStatusData(
        inTime: inDateTime,
        outTime: outDateTime,
        status: StatusFor.joinOnTime);

    StatusModel? isLeftOnTime = getStatusData(
        inTime: inDateTime,
        outTime: outDateTime,
        status: StatusFor.leftOnTime);

    String? currentMonth = "${list?.date}".toDateMMMMYYYY();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // show month when start new month
        if(showMonth)
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 5),
            child: Text(currentMonth,
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
        Container(
          decoration: getDecoration(),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [

              // first box
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      "${list?.date}"
                          .toDateDMMMY()
                          .toDateDMMMY(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight
                              .bold
                      ),),

                    const SizedBox(height: 4,),

                    if(isPresent != null)
                      Row(
                        children: [
                          Text(isPresent.text,
                            style: TextStyle(
                              fontSize: 14,
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
              ),

              // second box
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: [

                    Text("${list?.inTime}".toTime(),
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight
                              .bold
                      ),),

                    const SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(isJoinOnTime?.shortText == "L" ? isJoinOnTime!.text : "In-Time",
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
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: [

                    Text("${list?.outTime}".toTime(),
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

                        // if(isLeftOnTime.shortText.isNotEmpty)
                        //   Text(" (${isLeftOnTime.shortText})",
                        //     style: TextStyle(
                        //         color: isLeftOnTime.color,
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.bold
                        //     ),),
                      ],
                    ),







                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: outDateTime != null
                    //           ? (isLeftOnTime.color)
                    //           .withOpacity(0.1)
                    //           : null,
                    //       borderRadius: const BorderRadius
                    //           .all(
                    //           Radius.circular(15))
                    //   ),
                    //   margin: const EdgeInsets.only(
                    //       top: 4),
                    //   padding: const EdgeInsets
                    //       .symmetric(horizontal: 7,
                    //       vertical: 1),
                    //   child: Text(isLeftOnTime.text,
                    //     style: TextStyle(
                    //       fontSize: 13,
                    //       fontWeight: FontWeight
                    //           .bold,
                    //       color: isLeftOnTime.color,
                    //     ),),
                    // ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
