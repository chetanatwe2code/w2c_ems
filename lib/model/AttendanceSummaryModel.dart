/// id : 5
/// name : "Chetan Barod"
/// institution_id : 1
/// present : 3
/// absent : 0
/// late : 2
/// half_day : 0
/// el_leave : 0
/// cl_leave : 0

class AttendanceSummaryModel {
  AttendanceSummaryModel({
      this.id, 
      this.name, 
      this.institutionId, 
      this.present, 
      this.absent, 
      this.late, 
      this.halfDay, 
      this.elLeave, 
      this.clLeave,
      this.missedPunchOut});

  AttendanceSummaryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    institutionId = json['institution_id'];
    present = json['present'] > 0 ? json['present'] : null;
    absent = json['absent'] > 0 ?  json['absent'] : null;
    late = json['late'] > 0 ? json['late'] : null;
    halfDay = json['half_day'] > 0 ? json['half_day'] : null;
    elLeave = json['el_leave'] > 0 ? json['el_leave'] : null;
    clLeave = json['cl_leave'] > 0 ? json['cl_leave'] : null;
    missedPunchOut = json['missed_punch_out'] > 0 ? json['missed_punch_out'] : null;
  }
  int? id;
  String? name;
  int? institutionId;
  int? present;
  int? absent;
  int? late;
  int? halfDay;
  int? elLeave;
  int? clLeave;
  int? missedPunchOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['institution_id'] = institutionId;
    map['present'] = present;
    map['absent'] = absent;
    map['late'] = late;
    map['half_day'] = halfDay;
    map['el_leave'] = elLeave;
    map['cl_leave'] = clLeave;
    map['missed_punch_out'] = missedPunchOut;
    return map;
  }

}