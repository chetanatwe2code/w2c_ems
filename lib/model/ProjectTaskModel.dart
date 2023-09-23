/// tasks : [{"tasks":[{"id":3,"parent_id":null,"project_id":3,"task_name":"New testing task adding","description":"New testing task adding","assign":{"id":20,"name":"Raj"},"due_date":"2023-09-16","status":"pending","priority":"medium","dependency":null,"created_by":1,"updated_by":null,"deleted_at":null,"created_at":"2023-09-01T10:27:20.000000Z","updated_at":"2023-09-01T10:27:20.000000Z"},{"id":4,"parent_id":null,"project_id":3,"task_name":"Testing task two for testing","description":"Testing task two for testing","assign":{"id":11,"name":"Aashi Vyas"},"due_date":"2023-09-30","status":"pending","priority":"high","dependency":null,"created_by":1,"updated_by":null,"deleted_at":null,"created_at":"2023-09-01T10:27:48.000000Z","updated_at":"2023-09-01T10:27:48.000000Z"}]}]

class ProjectTaskModel {
  ProjectTaskModel({
     this.projectName,
      this.tasks,});

  ProjectTaskModel.fromJson(dynamic json) {
    projectName = json['project_name'];
    if (json['tasks'] != null) {
      tasks = [];
      json['tasks'].forEach((v) {
        tasks?.add(ProjectTask.fromJson(v));
      });
    }
  }
  List<ProjectTask>? tasks;
  String? projectName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['project_name'] = projectName;
    if (tasks != null) {
      map['tasks'] = tasks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class ProjectTask {
  ProjectTask({
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
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,});

  ProjectTask.fromJson(dynamic json) {
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
    deletedAt = json['deleted_at'];
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
  dynamic dependency;
  int? createdBy;
  dynamic updatedBy;
  dynamic deletedAt;
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
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 20
/// name : "Raj"

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