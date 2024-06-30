class User {
  UserData? userData;
  String? accessToken;

  User({this.userData, this.accessToken});

  User.fromJson(Map<String, dynamic> json) {
    userData = json['user'] != null ? UserData.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['user'] = userData!.toJson();
    }
    data['access_token'] = accessToken;
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? fcmToken;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.fcmToken,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['fcm_token'] = fcmToken;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
