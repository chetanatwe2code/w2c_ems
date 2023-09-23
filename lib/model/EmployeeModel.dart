class EmployeeModel {
  EmployeeModel({
      this.id, 
      this.name, 
      this.institutionId, 
      this.phone,
      this.email,
      this.gender,
      this.dateOfBirth,
      this.role,
      this.emailVerifiedAt,
      this.createdBy,
      this.updatedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,});

  EmployeeModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      name = json['name'];
      institutionId = json['institution_id'] != null ? InstitutionId.fromJson(json['institution_id']) : null;
      phone = json['phone'];
      email = json['email'];
      gender = json['gender'];
      dateOfBirth = json['date_of_birth'];
      role = json['role'];
      emailVerifiedAt = json['email_verified_at'];
      approved = int.tryParse(json['approved'].toString());
      isActive = int.tryParse(json['is_active'].toString());
      createdBy = int.tryParse(json['created_by'].toString());
      updatedBy = int.tryParse(json['updated_by'].toString());
      deletedAt = json['deleted_at'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
    }catch(e){
      ///
    }
  }

  int? id;
  String? name;
  InstitutionId? institutionId;
  String? phone;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? role;
  String? emailVerifiedAt;
  int? createdBy;
  int? isActive;
  int? approved;
  int? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (createdBy != null) {
      map['institution_id'] = institutionId?.toJson();
    }
    map['phone'] = phone;
    map['email'] = email;
    map['gender'] = gender;
    map['date_of_birth'] = dateOfBirth;
    map['role'] = role;
    map['email_verified_at'] = emailVerifiedAt;
    map['is_active'] = isActive;
    map['approved'] = approved;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class InstitutionId{

  InstitutionId.fromJson(dynamic json) {
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