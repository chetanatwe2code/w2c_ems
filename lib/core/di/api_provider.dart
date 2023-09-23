class ApiProvider{

 // static const String url = 'http://192.168.29.87:8000';
  static const String url = 'https://apnaorganicstore.in/attendance/public';

  static const String baseUrl = '$url/api/';

  /// login api
  static const String login = 'auth/login';
  static const String signup = 'auth/signup';
  static const String employeeCreate = 'user/create';
  static const String getUserDetail = 'user';
  static const String getUpdate = 'user/updateUser';
  static const String changePassword = 'user/change/password';

  /// Attendance
  static const String insertAttendance = 'attendance/punch/in';
  static const String updateOutTime = 'attendance/punch/out/';

  static const String getAttemptStatus = 'attendance/check/attempt';
  static const String getHistory = 'attendance';

   /// leave
   static const String leaveAdd = 'leave/add';
   static const String leaveGet = 'leave';


  /// admin APIs
  static const String getUsers = 'admin/users';
  static const String updateUser = 'admin/users/update';
  static const String getUsersList = 'admin/users/list';
  static const String deleteUser = 'admin/deleteUser';
  static const String approveUser = 'admin/approve/user';
  static const String attendanceByMonth = 'admin/attendance/month';
  static const String attendanceByDate = 'admin/attendance/date';
  static const String getHolidays = 'admin/holiday';
  static const String getHolidayByMonth = 'admin/holiday/show/month';
  static const String getLeavesByMonth = 'admin/leaves/show/month';
  static const String storeHoliday = 'admin/holiday/store';
  static const String updateHoliday = 'admin/holiday/update';
  static const String destroyHoliday = 'admin/holiday/destroy';
  static const String getAdminLeaves = 'admin/leaves';
  static const String leavesUpdate = 'admin/leaves/update';
  static const String markAttendance = 'admin/change/status';
  static const String attendanceSummary = 'admin/attendance/summary';

  // Project
  static const String createProject = 'project/create';
  static const String updateProject = 'project/update';
  static const String deleteProject = 'project/delete';
  static const String getProject = 'project/getProjects';

  // task
  static const String deleteTask = 'task/delete';
  static const String updateTask = 'task/update';
  static const String createTask = 'task/create';
  static const String getTasks = 'task/getTasks';
  static const String getAllTasks = 'task/getAllTasks';
  static const String userWithTasksCount = 'task/getTasksCount';


  static const String preferencesToken = 'USER_TOKEN';
}
