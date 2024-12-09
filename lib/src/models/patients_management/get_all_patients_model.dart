class GetAllPatientsList {
  int? status;
  BaseAData? data;
  String? message;

  GetAllPatientsList({this.status, this.data, this.message});

  GetAllPatientsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new BaseAData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class BaseAData {
  int? currentPage;
  List<PatientData>? basedata;

  BaseAData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      basedata = <PatientData>[];
      json['data'].forEach((v) {
        basedata!.add(new PatientData.fromJson(v));
      });
    }
  }
}

class PatientData {
  dynamic id;
  dynamic userId;
  String? name;
  String? gender;
  String? guardianName;
  String? patientDob;
  dynamic age;
  String? phone;
  String? email;
  dynamic isDeleted;
  String? createdAt;
  String? updatedAt;
  User? user;

  PatientData(
      {this.id,
      this.userId,
      this.name,
      this.gender,
      this.guardianName,
      this.patientDob,
      this.age,
      this.phone,
      this.email,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.user});

  PatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['user_id'] ?? "";
    name = json['name'] ?? "";
    gender = json['gender'] ?? "";
    guardianName = json['guardian_name'] ?? "";
    patientDob = json['patient_dob'] ?? "";
    age = json['age'] ?? "";
    phone = json['phone'] ?? "";
    email = json['email'] ?? "";
    isDeleted = json['is_deleted'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
