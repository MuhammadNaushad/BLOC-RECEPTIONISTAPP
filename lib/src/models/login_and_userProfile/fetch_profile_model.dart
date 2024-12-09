class FetchUserModel {
  FetchUserModel({
    required this.data,
  });
  Data? data;

  FetchUserModel.fromJson(Map<String, dynamic> json) {
    try {
      data = Data.fromJson(json['data']);
    } catch (e) {
      print(e.toString());
    }
  }
}

class Data {
  Data({
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.type,
  });
  late final String profileImage;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phoneNumber;
  late final int type;

  Data.fromJson(Map<String, dynamic> json) {
    print('object');
    profileImage = json['profile_image'] ?? '';
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['profile_image'] = profileImage;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['type'] = type;
    return _data;
  }
}
