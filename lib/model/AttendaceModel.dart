/// id : 1
/// user_id : 1
/// in_time : "2023-07-26 12:12:22.610699"
/// in_near_by : 2.0
/// out_time : "2023-07-26 12:12:22.610699"
/// out_near_by : 2.0

class AttendanceModel {
  AttendanceModel({
      this.id, 
      this.userId,
      this.date,
      this.inTime,
      this.outTime,
      this.status,
  });

  // Attendance

  AttendanceModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    status = json['status'];
  }
  int? id;
  int? userId;
  String? date;
  String? inTime;
  String? outTime;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['in_time'] = inTime;
    map['date'] = date;
    map['out_time'] = outTime;
    map['status'] = status;
    return map;
  }

}