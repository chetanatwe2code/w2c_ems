import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/view/admin/applications/view.dart';
import 'package:attendance/view/admin/attendance/view.dart';
import 'package:attendance/view/base/base_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../admin/holiday/view.dart';
import '../admin/home/view.dart';
import '../admin/project/view.dart';
import '../common/account/logic.dart';
import '../common/punching/view.dart';
import '../common/task_list/view.dart';
import '../employee/leaves/view.dart';
import '../other/animation/show_animated_dialog.dart';

enum UserType { employee, hr, admin }

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  static const List<Widget> _employeeOptions = <Widget>[
    PunchingPage(),
    LeavesPage(),
    TaskListPage(),
    ProjectPage(),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AttendancePage(),
    ApplicationsPage(), // Applications
    TaskListPage(), //     HolidayPage(),
    ProjectPage(),
  ];

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  Future<bool> _onWillPop() async {
    return await showAnimatedDialog(
        context,
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  left: 0,
                  top: 5,
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        size: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Are you sure?",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                        "Do you want to exit an App",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(
                              'YES',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
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
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    Get.find<AccountLogic>().getLoginUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<BaseLogic>(
        assignId: true,
        builder: (logic) {
          return GetBuilder<AccountLogic>(
            assignId: true,
            builder: (accountLogic) {
              return Scaffold(
                bottomNavigationBar:
                accountLogic.userModel != null
                   // && (accountLogic.userModel?.role != UserType.employee.name)
                    ? BottomNavigationBar(
                        iconSize: 24,
                        backgroundColor: AppColors.primary,
                        selectedItemColor: AppColors.whiteColor(),
                        unselectedItemColor: AppColors.whiteColor().withOpacity(0.4),
                        elevation: 10,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: logic.selectedIndex,
                        onTap: logic.onItemTapped,
                        items:  [
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: "Home",
                              backgroundColor: Colors.green),
                         if(accountLogic.userModel?.role != UserType.employee.name)
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.contacts),
                              label: "Attendance",
                              backgroundColor: Colors.green),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.personal_injury),
                              label: "Leave",
                              backgroundColor: Colors.green),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.task),
                              label: "Task",
                              backgroundColor: Colors.green),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.settings),
                              label: "Project",
                              backgroundColor: Colors.green),
                        ],
                      )
                    : null,
                body: accountLogic.userModel == null
                    ? Center(
                        child: Container(
                          color: AppColors.appBackground,
                          width: Get.width,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ],
                          ),
                        ),
                      )
                    : accountLogic.userModel?.role == UserType.employee.name
                        ? BasePage._employeeOptions[logic.selectedIndex]
                        : BasePage._widgetOptions[logic.selectedIndex],
              );
            },
          );
        },
      ),
    );
  }
}
