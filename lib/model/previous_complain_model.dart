class PreviousComplainModel {
  PreviousComplainModel({
    this.status,
    this.message,
    this.response,
  });

  PreviousComplainModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }
  int? status;
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
    this.lastUpdate,
    this.status,
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
    lastUpdate = json['last_update'];
    status = json['status'];
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
  dynamic lastUpdate;
  String? status;

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
    map['last_update'] = lastUpdate;
    map['status'] = status;
    return map;
  }
}
