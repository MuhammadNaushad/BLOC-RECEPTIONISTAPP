class GetAllDoctorsListModel {
  int? status;
  List<DoctorsData>? data;
  String? message;

  GetAllDoctorsListModel({this.status, this.data, this.message});

  GetAllDoctorsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != String) {
      data = <DoctorsData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorsData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class DoctorsData {
  int? id;
  String? uniqueId;
  String? specialityId;
  String? accountId;
  String? payLink;
  String? name;
  int? onCall;
  String? image;
  String? address;
  String? earningTime;
  String? rating;
  int? callavailability;
  String? email;
  String? phoneNumber;
  String? password;
  String? gender;
  String? role;
  String? label;
  String? otp;
  String? userToken;
  int? status;
  int? isDeleted;
  int? availability;
  String? resetCode;
  String? new_consultation_fees;
  String? followup_consultation_fees;
  String? createdAt;
  String? updatedAt;

  DoctorsData(
      {this.id,
      this.uniqueId,
      this.specialityId,
      this.accountId,
      this.payLink,
      this.name,
      this.onCall,
      this.image,
      this.address,
      this.earningTime,
      this.rating,
      this.callavailability,
      this.email,
      this.phoneNumber,
      this.password,
      this.gender,
      this.role,
      this.label,
      this.otp,
      this.userToken,
      this.status,
      this.isDeleted,
      this.availability,
      this.resetCode,
      this.createdAt,
      this.updatedAt});

  DoctorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    specialityId = json['speciality_id'];
    accountId = json['account_id'];
    payLink = json['pay_link'];
    name = json['name'] ?? "";
    onCall = json['on_call'];
    image = json['image'];
    address = json['address'];
    earningTime = json['earning_time'];
    rating = json['rating'];
    callavailability = json['callavailability'];
    email = json['email'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    password = json['password'] ?? "";
    gender = json['gender'] ?? "";
    role = json['role'];
    label = json['label'];
    otp = json['otp'];
    userToken = json['user_token'];
    status = json['status'] ?? 0;
    isDeleted = json['is_deleted'];
    availability = json['availability'];
    resetCode = json['reset_code'];
    new_consultation_fees = json['new_consultation_fees'].toString();
    followup_consultation_fees = json['followup_consultation_fees'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
