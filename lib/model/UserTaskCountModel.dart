/// id : 1
/// name : "Anamika pawar"
/// image : "xyz"
/// total_task : 0

class UserTaskCountModel {
  UserTaskCountModel({
      this.id, 
      this.name, 
      this.image, 
      this.totalTask,});

  UserTaskCountModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalTask = json['total_task'];
  }
  int? id;
  String? name;
  String? image;
  int? totalTask;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['total_task'] = totalTask;
    return map;
  }

}