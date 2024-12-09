class GetNotificationModel {
  bool? success;
  Data? data;
  String? message;

  GetNotificationModel({this.success, this.data, this.message});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  List<NewNotification>? newNotification;
  List<NewNotification>? oldNotification;

  Data({this.newNotification, this.oldNotification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['new_notification'] != null) {
      newNotification = <NewNotification>[];
      json['new_notification'].forEach((v) {
        newNotification!.add(new NewNotification.fromJson(v));
      });
    }
    if (json['old_notification'] != null) {
      oldNotification = <NewNotification>[];
      json['old_notification'].forEach((v) {
        oldNotification!.add(new NewNotification.fromJson(v));
      });
    }
  }
}

class NewNotification {
  int? taskStatus;
  String? createdAt;
  int? id;
  String? taskName;
  String? taskDesc;
  String? taskType;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? address1;
  String? address2;
  String? companyName;
  String? state;
  String? city;
  String? country;
  String? postcode;

  NewNotification(
      {this.taskStatus,
      this.createdAt,
      this.id,
      this.taskName,
      this.taskDesc,
      this.taskType,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.address1,
      this.address2,
      this.companyName,
      this.state,
      this.city,
      this.country,
      this.postcode});

  NewNotification.fromJson(Map<String, dynamic> json) {
    taskStatus = json['task_status'];
    createdAt = json['created_at'];
    id = json['id'];
    taskName = json['task_name'];
    taskDesc = json['task_desc'];
    taskType = json['task_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    address1 = json['address1'];
    address2 = json['address2'];
    companyName = json['company_name'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    postcode = json['postcode'];
  }
}
