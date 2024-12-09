import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/screens/dashboard/controllers/dashboard_cntler.dart';

import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';
import 'package:badges/badges.dart' as badges;

import '../../utils/preferences.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? viewType;
  final String? dashboardType;
  final String? approvedLabel;
  final bool? isCalendar;
  MyAppBar(
      {this.viewType,
      this.isCalendar = false,
      this.dashboardType,
      this.approvedLabel});

  @override
  Size get preferredSize => const Size.fromHeight(68.0);
  Widget _appBar() {
    /* var actualDate = ''.obs;
    var actualTime = ''.obs;
    Map<String, String> date =
        Utilities.getCurrentDateAndTime(actualDate.value, actualTime.value);
    actualDate.value = date['date']!;
    actualTime.value = date['time']!; */
    if (viewType == 'Dash') {
      if (dashboardType == '2') {
        return AppBar(
            backgroundColor: AppColors.PRIMARY_COLOR,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: InkWell(
                  child: Padding(
                      padding: const EdgeInsets.all(4.2),
                      child: Image.asset(Constant.menu_bar)),
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    /* Get.find<DashboardController>()
                        .scaffoldKey
                        .currentState
                        ?.openDrawer(); */
                  }),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                    child: Image.asset(
                      Constant.profileIcon,
                      height: 52.0,
                      width: 52.0,
                    ),
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 50));
                      Get.toNamed(Routes.MyProfile);
                    }),
              ),
            ]);
      } else {
        return AppBar(
            backgroundColor: AppColors.PRIMARY_COLOR,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: InkWell(
                  child: Padding(
                      padding: const EdgeInsets.all(4.2),
                      child: Image.asset(Constant.menu_bar)),
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    Get.find<DashboardController>()
                        .scaffoldKey
                        .currentState
                        ?.openDrawer();
                  }),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 50));
                  Get.toNamed(Routes.MyProfile);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    badges.Badge(
                      ignorePointer: false,
                      badgeContent: Text("0"),
                      child: Icon(
                        0 > 0 ? Icons.notifications : Icons.notifications_none,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Obx(
                  () => InkWell(
                      child: DashboardController.profilePic.value == ''
                          ? Image.asset(
                              Constant.profileIcon,
                              width: 52.0,
                              height: 52.0,
                            )
                          : CachedNetworkImage(
                              imageUrl: DashboardController.profilePic.value,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: 38.0,
                                    height: 38.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                              placeholder: (context, url) => new Image.asset(
                                    Constant.profileIcon,
                                    width: 38.0,
                                    height: 38.0,
                                  ),
                              errorWidget: (context, url, error) =>
                                  new Image.asset(
                                    Constant.profileIcon,
                                    width: 38.0,
                                    height: 38.0,
                                  )),
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 50));
                        Get.toNamed(Routes.MyProfile);
                      }),
                ),
              ),
            ]);
      }
    } else if (viewType == 'My Profile') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("Profile"),
        ),
      );
    } else if (viewType == 'Patients Management') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("Patients Management"),
        ),
      );
    } else if (viewType == 'Add New Patient' || viewType == 'Update Patient') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.2),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyBlack,
                  )),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 100));
                Navigator.pop(Get.context!);
              }),
        ),
        centerTitle: true,
        title: Text(
          viewType!,
        ),
      );
    } else if (viewType == 'Doctors Management' ||
        viewType == 'Schedule Management') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(viewType!),
        ),
      );
    } else if (viewType == 'Add New Doctor' || viewType == 'Update Doctor') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.2),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyBlack,
                  )),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 100));
                Navigator.pop(Get.context!);
              }),
        ),
        centerTitle: true,
        title: Text(
          viewType!,
        ),
      );
    } else if (viewType == 'Schedules') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: Text("Schedules", style: Constant.appbar_title_ts()),
      );
    } else if (viewType == 'Export Appointment') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: Text("Export Appointment", style: Constant.appbar_title_ts()),
      );
    } else if (viewType == 'Add New Slot' || viewType == 'Update Slot') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.2),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyBlack,
                  )),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 100));
                // Get.back(result: "getContacts");
                Navigator.pop(Get.context!);
              }),
        ),
        centerTitle: true,
        title: Text(viewType!, style: Constant.appbar_title_ts()),
      );
    } else if (viewType == 'Appointment Management') {
      return Padding(
        padding: const EdgeInsets.only(
          top: 4.0,
        ),
        child: AppBar(
          backgroundColor: AppColors.WHITE,
          centerTitle: true,
          title: Get.arguments == null || Get.arguments
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(viewType!, style: Constant.appbar_title_ts()),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(viewType!, style: Constant.appbar_title_ts()),
                ),
        ),
      );
    } else if (viewType == 'Add Appointment') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.2),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyBlack,
                  )),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 100));
                Navigator.pop(Get.context!);
              }),
        ),
        centerTitle: true,
        title: Text(viewType!, style: Constant.appbar_title_ts()),
      );
    } else if (viewType == 'Update Appointment') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.2),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyBlack,
                  )),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 100));
                Navigator.pop(Get.context!);
              }),
        ),
        centerTitle: true,
        title: Text(viewType!, style: Constant.appbar_title_ts()),
      );
    } else if (viewType == 'InvoiceView') {
      return Banner(
        message: approvedLabel!.capitalizeFirst ?? "",
        location: BannerLocation.bottomEnd,
        color: approvedLabel != "unpaid" ? Colors.green : Colors.red,
        child: AppBar(
          backgroundColor: AppColors.WHITE,
          centerTitle: true,
          title: Text("$dashboardType", style: Constant.appbar_title_ts()),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: InkWell(
                child: Padding(
                    padding: const EdgeInsets.all(4.2),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppTheme.nearlyBlack,
                    )),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  Navigator.pop(Get.context!);
                }),
          ),
        ),
      );
    } else if (viewType == 'Notifications') {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(4.2),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyBlack,
                  )),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 100));
                Get.offNamed(Routes.DASHBOARD);
              }),
        ),
        centerTitle: true,
        title: Text("Notifications", style: Constant.appbar_title_ts()),
      );
    } else {
      return AppBar(
        backgroundColor: AppColors.WHITE,
        centerTitle: true,
        title: Text("Profile", style: Constant.appbar_title_ts()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return this._appBar();
  }
}
