import 'package:get/get.dart';

class GetAllAppointmentDataModel {
  int? status;
  BaseAData? data;
  String? message;

  GetAllAppointmentDataModel({this.status, this.data, this.message});

  GetAllAppointmentDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new BaseAData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class BaseAData {
  int? currentPage;
  List<AppointmentData>? basedata;

  BaseAData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      basedata = <AppointmentData>[];
      json['data'].forEach((v) {
        basedata!.add(new AppointmentData.fromJson(v));
      });
    }
  }
}

class AppointmentData {
  int? id;
  int? userId;
  int? patientId;
  int? doctorId;
  String? date;
  String? patientType;
  int? consultCount;
  int? availId;
  String? price;
  int? type;
  String? receipt;
  String? receiptno;
  int? isComplete;
  int? isConnect;
  RxString? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? phone;
  String? doctorName;
  int? scheduleId;
  String? timeSlots;
  String? token;
  RxString? tokenStatus;
  String? mode;
  int? paymentStatus;
  bool? isSelected;

  AppointmentData(
      {this.id,
      this.userId,
      this.patientId,
      this.date,
      this.patientType,
      this.consultCount,
      this.availId,
      this.price,
      this.type,
      this.receipt,
      this.receiptno,
      this.isComplete,
      this.isConnect,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.phone,
      this.doctorName,
      this.scheduleId,
      this.timeSlots,
      this.token,
      this.tokenStatus,
      this.mode,
      this.isSelected,
      this.paymentStatus});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    date = json['date'];
    patientType = json['patient_type'] ?? "";
    consultCount = json['consult_count'];
    availId = json['avail_id'];
    price = json['price'];
    type = json['type'];
    receipt = json['receipt'];
    receiptno = json['receiptno'];
    isComplete = json['is_complete'];
    isConnect = json['is_connect'];

    status = json['status'] != null ? RxString(json['status']) : "".obs;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'] ?? "";
    phone = json['phone'] ?? "";
    doctorName = json['doctor_name'] ?? "";
    scheduleId = json['schedule_id'];
    timeSlots = json['time_slots'] ?? "";
    token = json['token'] ?? "";
    tokenStatus =
        json['token_status'] != null ? RxString(json['token_status']) : "".obs;
    mode = json['mode'] ?? "";
    paymentStatus = json['payment_status'] ?? 0;
    isSelected = false;
    print(isSelected);
  }
}
