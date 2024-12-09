class UserLoginModel {
  bool? status;
  String? token;
  UserData? data;
  String? message;

  UserLoginModel({this.status, this.token, this.data, this.message});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class UserData {
  String? email;
  String? id;
  String? userType;
  String? firstName;
  String? lastName;
  String? vendorId;
  String? defaultCurrency;

  UserData(
      {this.email,
      this.id,
      this.userType,
      this.firstName,
      this.lastName,
      this.vendorId,
      this.defaultCurrency});

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    id = json['id'] ?? "";
    userType = json['user_type'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    vendorId = json['vendor_id'] ?? "";
    defaultCurrency = json['default_currency'] ?? "";
  }
}
