/// id : 16
/// name : "sagar"
/// institution_id : 1
/// phone : "7204299662"
/// email : "sagaaar1.we2code@gmail.com"
/// gender : "male"
/// date_of_birth : "2023-08-01"
/// role : "employee"
/// email_verified_at : ""
/// created_by : null
/// updated_by : null
/// deleted_at : ""
/// created_at : "2023-08-10T09:35:25.000000Z"
/// updated_at : "2023-08-10T09:35:25.000000Z"

class BirthdayModel {
  BirthdayModel({
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

  BirthdayModel.fromJson(dynamic json) {
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
      createdBy = json['created_by'];
      updatedBy = json['updated_by'];
      deletedAt = json['deleted_at'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
    }catch(e){
      print("object $e");
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
  dynamic createdBy;
  dynamic updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (institutionId != null) {
      map['institution_id'] = institutionId?.toJson();
    }
    map['phone'] = phone;
    map['email'] = email;
    map['gender'] = gender;
    map['date_of_birth'] = dateOfBirth;
    map['role'] = role;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 1
/// name : "Chetan Barod"

class InstitutionId {
  InstitutionId({
    this.id,
    this.name,});

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