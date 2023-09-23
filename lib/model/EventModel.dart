/// id : 1
/// institution_id : 1
/// created_by : {"id":12,"email":"raj.we2code@gmail.com","name":"Rajaram Patidar","phone":"9993266886"}
/// event : "Independence Day"
/// start_date : "2023-08-15"
/// end_date : "2023-08-15"
/// event_type : "holiday"
/// created_at : "2023-08-10T09:19:04.000000Z"
/// updated_at : "2023-08-10T09:19:04.000000Z"

class EventModel {
  EventModel({
      this.id, 
      this.institutionId, 
      this.createdBy, 
      this.event, 
      this.startDate, 
      this.endDate, 
      this.eventType, 
      this.createdAt, 
      this.updatedAt,});

  EventModel.fromJson(dynamic json) {
    id = json['id'];
    institutionId = json['institution_id'];
    createdBy = json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null;
    event = json['event'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    eventType = json['event_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? institutionId;
  CreatedBy? createdBy;
  String? event;
  String? startDate;
  String? endDate;
  String? eventType;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['institution_id'] = institutionId;
    if (createdBy != null) {
      map['created_by'] = createdBy?.toJson();
    }
    map['event'] = event;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['event_type'] = eventType;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 12
/// email : "raj.we2code@gmail.com"
/// name : "Rajaram Patidar"
/// phone : "9993266886"

class CreatedBy {
  CreatedBy({
      this.id, 
      this.email, 
      this.name, 
      this.phone,});

  CreatedBy.fromJson(dynamic json) {
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