/// id : 2
/// name : "Chetan"
/// phone : "7089094141"
/// role : "admin"
/// email : "chetan.barod.we2code@gmail.com.com"
/// email_verified_at : ""
///
/// created_at : "2023-07-31T01:58:09.000000Z"
/// updated_at : "2023-07-31T01:58:09.000000Z"
/// attendance : [{"id":10,"user_id":2,"date":"2023-08-01","in_time":"2023-08-01 17:14:27","out_time":"2023-08-01 17:14:32","is_editable":1,"created_at":"2023-08-01T11:44:27.000000Z","updated_at":"2023-08-01T11:44:32.000000Z"}]

class UsersModel {
  UsersModel({
      this.id, 
      this.name, 
      this.phone, 
      this.role, 
      this.email, 
      this.gender,
      this.emailVerifiedAt,
      this.createdAt, 
      this.updatedAt, 
      this.attendance,});

  UsersModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    email = json['email'];
    gender = json['gender'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attendance'] != null) {
      attendance = [];
      json['attendance'].forEach((v) {
        attendance?.add(Attendance.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? phone;
  String? role;
  String? email;
  String? gender;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  List<Attendance>? attendance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['role'] = role;
    map['email'] = email;
    map['gender'] = gender;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (attendance != null) {
      map['attendance'] = attendance?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 10
/// user_id : 2
/// date : "2023-08-01"
/// in_time : "2023-08-01 17:14:27"
/// out_time : "2023-08-01 17:14:32"
/// is_editable : 1
/// created_at : "2023-08-01T11:44:27.000000Z"
/// updated_at : "2023-08-01T11:44:32.000000Z"

class Attendance {
  Attendance({
      this.id, 
      this.userId, 
      this.date, 
      this.inTime, 
      this.outTime, 
      this.status,
      this.createdAt,
      this.updatedAt,});

  Attendance.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? date;
  String? inTime;
  String? outTime;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['date'] = date;
    map['in_time'] = inTime;
    map['out_time'] = outTime;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}