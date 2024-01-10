class UserModel {
  UserModel({
      this.status, 
      this.message, 
      this.response,});

  UserModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  int? status;
  String? message;
  Response? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

class Response {
  Response({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.password, 
      this.isActive, 
      this.isBlock, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Response.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    isActive = json['is_active'];
    isBlock = json['is_block'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? isActive;
  String? isBlock;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    map['is_active'] = isActive;
    map['is_block'] = isBlock;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}