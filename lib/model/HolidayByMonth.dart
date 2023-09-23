/// id : 3
/// start_date : "2023-09-21"
/// end_date : "2023-09-25"

class HolidayByMonth {
  HolidayByMonth({
      this.id, 
      this.startDate, 
      this.endDate,});

  HolidayByMonth.fromJson(dynamic json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
  int? id;
  String? startDate;
  String? endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    return map;
  }

}