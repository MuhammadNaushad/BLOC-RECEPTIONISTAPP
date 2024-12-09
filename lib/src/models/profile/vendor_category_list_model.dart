class VendorCategoryNameList {
  bool? success;
  String? message;
  List<VendorCat>? data;

  VendorCategoryNameList({this.success, this.message, this.data});

  VendorCategoryNameList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VendorCat>[];
      json['data'].forEach((v) {
        data!.add(new VendorCat.fromJson(v));
      });
    }
  }
}

class VendorCat {
  String? id;
  String? categoryName;
  String? description;

  VendorCat({this.id, this.categoryName, this.description});

  VendorCat.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "0";
    categoryName = json['category_name'] ?? "";
    description = json['description'] ?? "";
  }
}
