class GetAllSheduleModel {
  int? status;
  List<SlotData>? data;
  String? message;

  GetAllSheduleModel({this.status, this.data, this.message});

  GetAllSheduleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SlotData>[];
      json['data'].forEach((v) {
        data!.add(new SlotData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class SlotData {
  int? id;
  int? doctorId;
  String? timeSlots;
  String? noOfTokens;
  String? status;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  SlotData(
      {this.id,
      this.doctorId,
      this.timeSlots,
      this.noOfTokens,
      this.status,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  SlotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    timeSlots = json['time_slots'] ?? json["slots"];
    noOfTokens = json['no_of_tokens'];
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
