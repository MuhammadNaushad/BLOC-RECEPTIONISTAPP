class SingleContactDataModel {
  bool? success;
  String? message;
  SingleContactData? data;

  SingleContactDataModel({this.success, this.message, this.data});

  SingleContactDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new SingleContactData.fromJson(json['data'])
        : null;
  }
}

class SingleContactData {
  String? id;
  String? firstName;
  String? lastName;
  String? userType;
  String? isAdmin;
  String? roleId;
  String? email;
  String? image;
  String? status;
  String? messageCheckedAt;
  String? clientId;
  String? notificationCheckedAt;
  String? isPrimaryContact;
  String? jobTitle;
  String? disableLogin;
  String? note;
  String? address;
  String? alternativeAddress;
  String? phone;
  String? alternativePhone;
  String? dob;
  String? ssn;
  String? gender;
  String? stickyNote;
  String? skype;
  String? language;
  String? enableWebNotification;
  String? enableEmailNotification;
  String? createdAt;
  String? lastOnline;
  String? requestedAccountRemoval;
  String? deleted;
  String? vendorId;

  SingleContactData(
      {this.id,
      this.firstName,
      this.lastName,
      this.userType,
      this.isAdmin,
      this.roleId,
      this.email,
      this.image,
      this.status,
      this.messageCheckedAt,
      this.clientId,
      this.notificationCheckedAt,
      this.isPrimaryContact,
      this.jobTitle,
      this.disableLogin,
      this.note,
      this.address,
      this.alternativeAddress,
      this.phone,
      this.alternativePhone,
      this.dob,
      this.ssn,
      this.gender,
      this.stickyNote,
      this.skype,
      this.language,
      this.enableWebNotification,
      this.enableEmailNotification,
      this.createdAt,
      this.lastOnline,
      this.requestedAccountRemoval,
      this.deleted,
      this.vendorId});

  SingleContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
    roleId = json['role_id'];
    email = json['email'];
    image = json['image'];
    status = json['status'];
    messageCheckedAt = json['message_checked_at'];
    clientId = json['client_id'];
    notificationCheckedAt = json['notification_checked_at'];
    isPrimaryContact = json['is_primary_contact'];
    jobTitle = json['job_title'];
    disableLogin = json['disable_login'];
    note = json['note'];
    address = json['address'];
    alternativeAddress = json['alternative_address'];
    phone = json['phone'];
    alternativePhone = json['alternative_phone'];
    dob = json['dob'];
    ssn = json['ssn'];
    gender = json['gender'];
    stickyNote = json['sticky_note'];
    skype = json['skype'];
    language = json['language'];
    enableWebNotification = json['enable_web_notification'];
    enableEmailNotification = json['enable_email_notification'];
    createdAt = json['created_at'];
    lastOnline = json['last_online'];
    requestedAccountRemoval = json['requested_account_removal'];
    deleted = json['deleted'];
    vendorId = json['vendor_id'];
  }
}
