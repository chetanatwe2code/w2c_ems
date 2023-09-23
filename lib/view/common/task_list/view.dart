import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/view/common/task_list/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../other/widget/custom_dropdown.dart';
import '../punching/view.dart';
import 'logic.dart';


class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {

  @override
  void initState() {
    Get.find<TaskListLogic>().getUsersList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<TaskListLogic>().refreshList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(title: GetBuilder<TaskListLogic>(
          assignId: true,
          builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(logic.userName ?? "Task"),
                CustomDropDown(
                  width: 100,
                  height: 25,
                  list: logic.dropdown,
                  selectValue: logic.selectedName,
                  hintStyle: TextStyle(
                      fontSize: 9,
                      color: AppColors.whiteColor()
                  ),
                  textStyle: TextStyle(
                      fontSize: 9,
                      color: AppColors.whiteColor()
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.whiteColor(), width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  onChanged: (String? model) {
                    logic.selectedName = model;
                    logic.userId = int.tryParse(model.toString());
                    logic.refreshList();
                  },
                ),
              ],
            );
          },
        ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Working"),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Completed"),
                ),
              ),
            ],
          ),),
        body: TabBarView(
          children: [
            _buildWorking(),
            _buildCompleted(),
          ],
        ),
      ),
    );
  }

  _buildWorking() {
    return SingleChildScrollView(
      child: GetBuilder<TaskListLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            children: [
              const SizedBox(height: 10,),
              ListView.builder(
                itemCount: logic.workingModel.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Task(model: logic.workingModel[index],
                    onChangeStatus: (s) {
                      logic.changeStatus(index, s,logic.workingModel[index].taskName);
                    },);
                },),
            ],
          );
        },
      ),
    );
  }

  _buildCompleted() {
    return SingleChildScrollView(
      child: GetBuilder<TaskListLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            children: [
              const SizedBox(height: 10,),
              ListView.builder(
                itemCount: logic.completeModel.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Task(model: logic.completeModel[index],
                    onChangeStatus: (s) {
                      logic.changeStatus(index, s,logic.completeModel[index].taskName, isWorking: false);
                    },);
                },),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.find<TaskListLogic>().clearUser();
    super.dispose();
  }
}
