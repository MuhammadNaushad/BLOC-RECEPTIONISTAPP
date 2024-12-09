class ExistingUserDataModel {
  int? status;
  Data? data;
  String? message;

  ExistingUserDataModel({this.status, this.data, this.message});

  ExistingUserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  bool? userStatus;
  ExistingUserData? data;

  Data({this.userStatus, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    userStatus = json['user_status'];
    data = json['data'] != null
        ? new ExistingUserData.fromJson(json['data'])
        : null;
  }
}

class ExistingUserData {
  int? id;
  String? name;
  String? image;
  String? address;
  String? occupation;
  String? earningTime;
  int? subscriptionId;
  String? email;
  String? city;
  String? country;
  String? phoneNumber;
  String? gender;
  String? dob;
  int? age;
  String? role;
  String? otp;
  String? userToken;
  String? deviceToken;
  int? status;
  int? isDelete;
  String? resetCode;
  String? createdAt;
  String? updatedAt;

  ExistingUserData(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.occupation,
      this.earningTime,
      this.subscriptionId,
      this.email,
      this.city,
      this.country,
      this.phoneNumber,
      this.gender,
      this.dob,
      this.age,
      this.role,
      this.otp,
      this.userToken,
      this.deviceToken,
      this.status,
      this.isDelete,
      this.resetCode,
      this.createdAt,
      this.updatedAt});

  ExistingUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    occupation = json['occupation'];
    earningTime = json['earning_time'];
    subscriptionId = json['subscription_id'];
    email = json['email'];
    city = json['city'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    role = json['role'];
    otp = json['otp'];
    userToken = json['user_token'];
    deviceToken = json['device_token'];
    status = json['status'];
    isDelete = json['is_delete'];
    resetCode = json['reset_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
