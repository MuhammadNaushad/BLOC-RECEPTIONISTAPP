class GetPatientListForAppnmtDataModel {
  int? status;
  List<PatientListForAppnmtData>? data;
  String? message;

  GetPatientListForAppnmtDataModel({this.status, this.data, this.message});

  GetPatientListForAppnmtDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PatientListForAppnmtData>[];
      json['data'].forEach((v) {
        data!.add(new PatientListForAppnmtData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PatientListForAppnmtData {
  int? id;
  int? userId;
  String? name;
  String? gender;
  String? guardianName;
  String? patientDob;
  int? age;
  String? phone;
  String? email;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  PatientListForAppnmtData(
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
      this.updatedAt});

  PatientListForAppnmtData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'];
    guardianName = json['guardian_name'];
    patientDob = json['patient_dob'];
    age = json['age'];
    phone = json['phone'];
    email = json['email'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
