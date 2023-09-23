/// id : 1
/// parent_id : null
/// project_id : 1
/// task_name : "lmia"
/// description : "create api to mail lmia status"
/// assign : {"id":1,"name":"Chetan b"}
/// due_date : "2023-08-18"
/// status : "working"
/// priority : "high"
/// dependency : 1
/// created_by : 1
/// updated_by : 1
/// created_at : "2023-08-18T06:34:00.000000Z"
/// updated_at : "2023-08-18T09:29:45.000000Z"

class TaskModel {
  TaskModel({
      this.id, 
      this.parentId, 
      this.projectId, 
      this.taskName, 
      this.description, 
      this.assign, 
      this.dueDate, 
      this.status, 
      this.priority, 
      this.dependency, 
      this.createdBy, 
      this.updatedBy, 
      this.createdAt, 
      this.updatedAt,});

  TaskModel.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    projectId = json['project_id'];
    taskName = json['task_name'];
    description = json['description'];
    assign = json['assign'] != null ? Assign.fromJson(json['assign']) : null;
    dueDate = json['due_date'];
    status = json['status'];
    priority = json['priority'];
    dependency = json['dependency'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  dynamic parentId;
  int? projectId;
  String? taskName;
  String? description;
  Assign? assign;
  String? dueDate;
  String? status;
  String? priority;
  int? dependency;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['project_id'] = projectId;
    map['task_name'] = taskName;
    map['description'] = description;
    if (assign != null) {
      map['assign'] = assign?.toJson();
    }
    map['due_date'] = dueDate;
    map['status'] = status;
    map['priority'] = priority;
    map['dependency'] = dependency;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 1
/// name : "Chetan b"

class Assign {
  Assign({
      this.id, 
      this.name,});

  Assign.fromJson(dynamic json) {
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