class DashboardCountModel {
  int? visit;
  int? vendor;
  int? order;
  int? notification;

  DashboardCountModel({this.visit, this.vendor, this.order, this.notification});

  DashboardCountModel.fromJson(Map<String, dynamic> json) {
    visit = json['visit'];
    vendor = json['vendor'];
    order = json['order'];
    notification = json['notification'];
  }
}

class DashboardSCountModel {
  int? visit;
  int? vendor;
  int? order;
  int? fos;
  int? notification;

  int? assignVendor;
  int? unassignVendor;

  DashboardSCountModel(
      {this.visit,
      this.vendor,
      this.order,
      this.notification,
      this.fos,
      this.assignVendor,
      this.unassignVendor});

  DashboardSCountModel.fromJson(Map<String, dynamic> json) {
    visit = json['visits'];
    vendor = json['vendor'];
    order = json['order'];
    fos = json['fos_users'];
    notification = json['notification'];
    assignVendor = json['assign_vendor'];
    unassignVendor = json['unassign_vendor'];
  }
}
