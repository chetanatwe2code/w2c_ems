import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/admin/task/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/project_repository.dart';
import '../../../../theme/app_colors.dart';

enum TaskStatus { pending, working, complete, cancelled }

getStep(String? string){
  if(string == TaskStatus.pending.name){
    return 1;
  }
  if(string == TaskStatus.working.name){
    return 2;
  }
  if(string == TaskStatus.complete.name){
    return 3;
  }
  if(string == TaskStatus.cancelled.name){
    return 4;
  }
  return 1;
}

getTaskStatus(String? string){
  if(string == TaskStatus.pending.name){
    return TaskStatus.pending;
  }
  if(string == TaskStatus.working.name){
    return TaskStatus.working;
  }
  if(string == TaskStatus.complete.name){
    return TaskStatus.complete;
  }
  if(string == TaskStatus.cancelled.name){
    return TaskStatus.cancelled;
  }
  return TaskStatus.pending;
}

class ChangeStatus extends StatefulWidget {
  final double? paddingTop;
  final String? taskStatus;
  final String taskId;
  final String? taskName;
  final Function? callback;
  const ChangeStatus({super.key,this.paddingTop,
    this.taskName,
    this.taskStatus,required this.taskId,this.callback});

  @override
  State<ChangeStatus> createState() => _ChangeStatusState();
}

class _ChangeStatusState extends State<ChangeStatus> {

  int? changeStep;

  @override
  Widget build(BuildContext context) {
    TaskStatus status = getTaskStatus(widget.taskStatus);

    int statusStep = getStep(widget.taskStatus);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      height: Get.height/3,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            SizedBox(
                height: kToolbarHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Flexible(
                      child: Text(((widget.taskName??status.name).toCapitalizeFirstLetter()),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),),
                    ),

                    const SizedBox(width: 15,),

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

            const SizedBox(height: 20),

            createState(color: Colors.blue,text: "Pending",isDone: statusStep > 0,step: 1),
            createState(color: Colors.amber,text: "Working",isDone: statusStep > 1,step: 2),

           if(statusStep != 4)
            createState(color: Colors.green,text: "Complete",showLine: false,isDone: statusStep == 3,step: 3),

            if(statusStep == 4)
              createState(color: Colors.green,text: "Cancelled",showLine: false,isDone: true,step: 4),

          ],
        ),
      ),
    );
  }

  createState({ bool showLine = true,required Color? color,required String text,bool isDone = false,required int step }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: isDone || changeStep != null ? null : (){
            setState((){
              changeStep = step;
            });
            Get.find<ProjectRepository>().updateTask(body: { "id": widget.taskId, "status" : text }).then((value) => {
              if(value.body['success']){
                Navigator.pop(context),
                if(widget.callback != null){
                  widget.callback!(),
                }
              }
            }).whenComplete(() => {
              setState((){
                changeStep = null;
              })
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if((changeStep != null && changeStep == step))...[
                const SizedBox(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              ]else...[
                CircularCheckBoxIcon(
                  isChecked: isDone,
                  size: 14,
                ),
              ],

               const SizedBox(width: 10,),
              Text(text),
            ],
          ),
        ),

       if(showLine)
        Container(
          height: 30,
          margin: const EdgeInsets.only(left: 7,top: 2),
          child: CustomPaint(
            painter: DottedLinePainter(),
          ),
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 2;
    const double dashSpace = 2;
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    double startX = size.width / 2;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class CircularCheckBoxIcon extends StatelessWidget {
  final bool isChecked;
  final double size;
  final Color? color;
  final Function(bool? isChecked)? onChange;
  const CircularCheckBoxIcon({
    super.key,
    required this.isChecked,
    this.size = 24.0,
    this.color,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange == null ? null : (){
        onChange!(!isChecked);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (isChecked ? (color ?? AppColors.primary) : Colors.transparent),
          border: Border.all(
            color: (isChecked ? Colors.transparent : Colors.grey),
            width: 1.0,
          ),
        ),
        child: isChecked
            ? Icon(
          Icons.check,
          size: size * 0.7,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}


