class ProjectModel {
  ProjectModel({
      this.id, 
      this.projectName, 
      this.description, 
      this.teamLeaderId, 
      this.startDate, 
      this.endDate, 
      this.status, 
      this.createdBy, 
      this.updatedBy, 
      this.createdAt, 
      this.updatedAt,});

  ProjectModel.fromJson(dynamic json) {
    id = json['id'];
    projectName = json['project_name'];
    description = json['description'];
    teamLeaderId = json['team_leader_id'] != null ? TeamLeaderId.fromJson(json['team_leader_id']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdBy = json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null;
    updatedBy = json['updated_by'] != null ? CreatedBy.fromJson(json['updated_by']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? projectName;
  String? description;
  TeamLeaderId? teamLeaderId;
  String? startDate;
  String? endDate;
  String? status;
  CreatedBy? createdBy;
  CreatedBy? updatedBy;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['project_name'] = projectName;
    map['description'] = description;
    if (teamLeaderId != null) {
      map['team_leader_id'] = teamLeaderId?.toJson();
    }
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['status'] = status;
    if (createdBy != null) {
      map['created_by'] = createdBy?.toJson();
    }
    if (updatedBy != null) {
      map['updated_by'] = updatedBy?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class TeamLeaderId {
  TeamLeaderId({
    this.id,
    this.name,});

  TeamLeaderId.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class CreatedBy {
  CreatedBy({
    this.id,
    this.name,});

  CreatedBy.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}