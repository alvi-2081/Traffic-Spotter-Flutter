class ComplainModel {
  ComplainModel({
    this.status,
    this.message,
    this.response,
  });

  ComplainModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  List<Response>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Response {
  Response({
    this.id,
    this.userId,
    this.location,
    this.date,
    this.time,
    this.type,
    this.victimName,
    this.latitude,
    this.longitude,
    this.isApproved,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  Response.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    location = json['location'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    victimName = json['victim_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isApproved = json['is_approved'];
    isCompleted = json['is_completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? userId;
  String? location;
  String? date;
  String? time;
  String? type;
  String? victimName;
  String? latitude;
  String? longitude;
  String? isApproved;
  String? isCompleted;
  String? createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['location'] = location;
    map['date'] = date;
    map['time'] = time;
    map['type'] = type;
    map['victim_name'] = victimName;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_approved'] = isApproved;
    map['is_completed'] = isCompleted;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
