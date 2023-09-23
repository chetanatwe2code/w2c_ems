/// id : 1
/// user_id : 1
/// start_date : "2023-08-08"
/// end_date : "2023-08-09"
/// leave_type : "Wedding"
/// leave_time : "Leave Before Half Day"
/// reason : "test"
/// status : "pending"
/// created_at : "2023-08-08T10:26:09.000000Z"
/// updated_at : "2023-08-08T10:26:09.000000Z"

class ApplicationModel {
  ApplicationModel({
      this.id, 
      this.userId, 
      this.startDate, 
      this.endDate, 
      this.leaveType, 
      this.leaveTime, 
      this.reason, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  ApplicationModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    leaveType = json['leave_type'];
    leaveTime = json['leave_time'];
    reason = json['reason'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  UserId? userId;
  String? startDate;
  String? endDate;
  String? leaveType;
  String? leaveTime;
  String? reason;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (userId != null) {
      map['user_id'] = userId?.toJson();
    }
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['leave_type'] = leaveType;
    map['leave_time'] = leaveTime;
    map['reason'] = reason;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 1
/// email : "chetan.barod.we2code@gmail.com"
/// name : "Chetan Barod"
/// phone : "7089094141"

class UserId {
  UserId({
    this.id,
    this.email,
    this.name,
    this.phone,});

  UserId.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }
  int? id;
  String? email;
  String? name;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }

}