
import 'package:attendance/view/admin/attendance/binding.dart';
import 'package:attendance/view/admin/attendance_summary/binding.dart';
import 'package:attendance/view/admin/create_project/binding.dart';
import 'package:attendance/view/admin/create_task/binding.dart';
import 'package:attendance/view/admin/employee/binding.dart';
import 'package:attendance/view/admin/holiday/binding.dart';
import 'package:attendance/view/common/change_password/binding.dart';
import 'package:attendance/view/employee/employee_task/binding.dart';
import 'package:get/get.dart';
import '../view/admin/attendance/view.dart';
import '../view/admin/attendance_summary/view.dart';
import '../view/admin/create_project/view.dart';
import '../view/admin/create_task/view.dart';
import '../view/admin/employee/view.dart';
import '../view/admin/holiday/view.dart';
import '../view/admin/home/view.dart';
import '../view/admin/task/binding.dart';
import '../view/admin/task/view.dart';
import '../view/auth/login/binding.dart';
import '../view/auth/login/view.dart';
import '../view/auth/sign_up/binding.dart';
import '../view/auth/sign_up/view.dart';
import '../view/base/base_page.dart';
import '../view/common/account/view.dart';
import '../view/common/change_password/view.dart';
import '../view/common/edit_profile/binding.dart';
import '../view/common/edit_profile/view.dart';
import '../view/common/punching/view.dart';
import '../view/common/splash/SplashPage.dart';
import '../view/common/splash/binding.dart';
import '../view/employee/employee_task/view.dart';
import '../view/employee/leave/binding.dart';
import '../view/employee/leave/view.dart';
import '../view/employee/leaves/binding.dart';
import '../view/employee/leaves/view.dart';

/// application routes name
const String rsDefaultPage = "/";

const String rsPunchingPage = "/PunchingPage";
const String rsLoginPage = "/LoginPage";
const String rsSignUpPage = "/SignUpPage";
const String rsBasePage = "/BasePage";
const String rsLeavePage = "/LeavePage";

const String rsAccountPage = "/AccountPage";
const String rsEmployeePage = "/EmployeePage";
const String rsEditProfilePage = "/EditProfilePage";
const String rsCreateProjectPage = "/CreateProjectPage";

const String rsCreateTaskPage = "/CreateTaskPage";

const String rsAttendancePage = "/AttendancePage";
const String rsChangePasswordPage = "/ChangePasswordPage";
const String rsHolidayPage = "/HolidayPage";

/// unused route
const String rsHomePage = "/HomePage";
const String rsLeavesPage = "/LeavesPage";
const String rsEmployeeTaskPage = "/EmployeeTaskPage";
const String rsTaskPage = "/TaskPage";
const String rsAttendanceSummaryPage = "/AttendanceSummaryPage";

class Routes{

  static final routes = [
    // how can add custom Transition
    GetPage(name: rsBasePage, page: () => const BasePage()),
    GetPage(name: rsAccountPage, page: () => const AccountPage()),

    GetPage(name: rsPunchingPage, page: () => const PunchingPage()),

    GetPage(name: rsDefaultPage, page: () => const SplashPage(),binding: SplashBinding()),
    GetPage(name: rsLoginPage, page: () => const LoginPage(),binding: LoginBinding()),
    GetPage(name: rsSignUpPage, page: () => const SignUpPage(),binding: SignUpBinding()),
    GetPage(name: rsLeavePage, page: () => const LeavePage(),binding: LeaveBinding()),

    GetPage(name: rsEmployeePage, page: () => const EmployeePage(),binding: EmployeeBinding()),
    GetPage(name: rsEditProfilePage, page: () => const EditProfilePage(),binding: EditProfileBinding()),
    GetPage(name: rsCreateProjectPage, page: () => const CreateProjectPage(),binding: CreateProjectBinding()),

    GetPage(name: rsCreateTaskPage, page: () => const CreateTaskPage(),binding: CreateTaskBinding()),

    GetPage(name: rsAttendancePage, page: () => const AttendancePage(),binding: AttendanceBinding()),
    GetPage(name: rsChangePasswordPage, page: () => const ChangePasswordPage(),binding: ChangePasswordBinding()),
    GetPage(name: rsHolidayPage, page: () => const HolidayPage(),binding: HolidayBinding()),
    GetPage(name: rsAttendanceSummaryPage, page: () => const AttendanceSummaryPage(),binding: AttendanceSummaryBinding()),

    /// unused page
    GetPage(name: rsLeavesPage, page: () => const LeavesPage(),binding: LeavesBinding()),
    GetPage(name: rsEmployeeTaskPage, page: () => const EmployeeTaskPage(),binding: EmployeeTaskBinding()),
    GetPage(name: rsTaskPage, page: () => const TaskPage(),binding: TaskBinding()),
    GetPage(name: rsHomePage, page: () => const HomePage()),
  ];

}