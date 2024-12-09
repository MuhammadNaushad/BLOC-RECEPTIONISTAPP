class GetAllTaxListModel {
  bool? status;
  String? message;
  List<AllTaxData>? data;

  GetAllTaxListModel({this.status, this.message, this.data});

  GetAllTaxListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllTaxData>[];
      json['data'].forEach((v) {
        data!.add(new AllTaxData.fromJson(v));
      });
    }
  }
}

class AllTaxData {
  String? id;
  String? label;
  String? percentage;

  AllTaxData({this.id, this.label, this.percentage});

  AllTaxData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    label = json['label'] ?? "";
    percentage = json['percentage'] ?? "";
  }
}
