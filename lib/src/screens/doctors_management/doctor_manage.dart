import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/widgets/appBar.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/assign_schedules/add_slot/controllers/add_slot_cntler.dart';
import 'package:yslcrm/src/screens/doctors_management/widgets/doctor_searchbar.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';

import '../../utils/utilities.dart';
import 'add_doctors/controllers/add_doctor_cntler.dart';
import 'controllers/doctors_management_cntler.dart';
import 'widgets/doctor_list_main.dart';

class DoctorManage extends GetView<DoctorManageController> {
  final bool? isDoctorManagementView;
  DoctorManage({this.isDoctorManagementView});

  @override
  Widget build(BuildContext context) {
    controller.isDoctorManagementView = isDoctorManagementView ?? Get.arguments;
    print(Get.arguments);
    return Scaffold(
      appBar: MyAppBar(
          viewType: controller.isDoctorManagementView!
              ? 'Doctors Management'
              : 'Schedule Management'),
      body: SafeArea(
          child: RefreshIndicator(
        color: AppColors.PRIMARY_COLOR,
        onRefresh: controller.onRefresh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: Column(children: [
            DoctorSearchBar(),
            Obx(
              () => !DoctorManageController.isDataNotFound.value
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                        child: Text(
                          "Swipe left for more actions",
                          style: TextStyle(
                              color: AppColors.LIGHT_BLACK.withOpacity(0.8)),
                        ),
                      ))
                  : SizedBox.shrink(),
            ),
            Expanded(
              child: DoctorsListMain(),
            )
          ]),
        ),
      )),
      floatingActionButton: controller.isDoctorManagementView!
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Icon(
                Icons.add,
                color: AppTheme.nearlyWhite,
              ),
              onPressed: () async {
                await Utilities.delay(100);
                if (controller.isDoctorManagementView!) {
                  AddDoctorController.doctorID = "";
                  final result = await Get.toNamed(Routes.AddDoctor)!;
                  if (result != null) {
                    await controller.getDoctorsListData();
                  }
                } /* else {
              AddSlotController.slotID = "";
              final result = await Get.toNamed(Routes.AddSlot)!;
              if (result != null) {
                //await AssignScheduleController.getScheduleListData();
              }
            } */
              })
          : SizedBox.shrink(),
    );
  }
}
