import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/widgets/appBar.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/controllers/add_appointment_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import 'controllers/appointment_management_cntler.dart';
import 'widgets/appointment_list_main.dart';
import 'widgets/appointment_searchbar.dart';
import 'widgets/doctor_dropD.dart';

class AppointmentManagement extends GetView<AppointmentManagementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(viewType: 'Appointment Management'),
      body: SafeArea(
          child: RefreshIndicator(
        color: AppColors.PRIMARY_COLOR,
        onRefresh: controller.onRefresh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: Column(children: [
            AppointmentSearchBar(),
            DoctorDropDown(),
            SizedBox(
              height: 10,
            ),
            GetBuilder<AppointmentManagementController>(builder: (cntler) {
              return controller.isShowSelectAllBtn
                  ? AnimatedContainer(
                      duration: Duration(seconds: 2),
                      child: Align(
                        alignment: Alignment.center,
                        child: AppButton(
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 100));
                            FocusManager.instance.primaryFocus?.unfocus();
                            AppointmentManagementController.appointmentList!
                                .forEach((element) {
                              element.isSelected =
                                  !controller.isShowSelectAllBtnTxt;
                            });
                            controller.isShowSelectAllBtnTxt =
                                !controller.isShowSelectAllBtnTxt;
                            /*  if (controller.isShowSelectAllBtnTxt) {
                              controller.isShowSelectAllBtn = false;
                            } */
                            if (controller.isShowSelectAllBtn &&
                                controller.isShowSelectAllBtnTxt) {
                              AppointmentManagementController.appointmentList!
                                  .forEach((element) {
                                controller.appointmentIdListToPost
                                    .add(element.id.toString());
                              });
                            } else {
                              controller.appointmentIdListToPost.clear();
                              controller.isShowSelectAllBtn = false;
                            }
                            debugPrint(
                                "AppointmentIDList: ${controller.appointmentIdListToPost.toString()}");
                            controller.update();
                          },
                          textColor: Colors.white,
                          text: controller.isShowSelectAllBtnTxt
                              ? "Unselect All"
                              : "Select All",
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.WHITE),
                          color: AppColors.PRIMARY_COLOR,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50))),
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            Expanded(
              child: AppointmentListMain(),
            ),
          ]),
        ),
      )),
      bottomSheet:
          GetBuilder<AppointmentManagementController>(builder: (cntler) {
        return controller.isShowSelectAllBtn
            ? AnimatedContainer(
                duration: Duration(seconds: 2),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 30, bottom: 30),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(2.5, 2.5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //AppointmentStatusDropDown(),
                      10.height,
                      //TokenStatusDropDown(),
                    ],
                  ),
                ),
              )
            : SizedBox.shrink();
      }),
      /* floatingActionButton:
          GetBuilder<AppointmentManagementController>(builder: (cntler) {
        return !controller.isShowSelectAllBtn
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Icon(
                  Icons.add,
                  color: AppTheme.nearlyWhite,
                ),
                onPressed: () async {
                  await Utilities.delay(100);
                  AddAppointmentController.patientID = "";
                  final result = await Get.toNamed(Routes.AddAppointment)!;
                  if (result != null) {
                    await AppointmentManagementController
                        .getAppointmentListData();
                  }
                })
            : SizedBox.shrink();
      }), */
      floatingActionButton:
          GetBuilder<AppointmentManagementController>(builder: (cntler) {
        return !controller.isShowSelectAllBtn
            ? SpeedDial(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                gradientBoxShape: BoxShape.rectangle,
                icon: Icons.more_vert,
                activeIcon: Icons.close,
                iconTheme: IconThemeData(
                  color: AppTheme.nearlyWhite,
                ),
                children: [
                    SpeedDialChild(
                      backgroundColor: AppColors.PRIMARY_COLOR,
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.nearlyWhite,
                      ),
                      label: 'Add Appointment',
                      labelBackgroundColor: AppTheme.chipBackground,
                      onTap: () async {
                        await Utilities.delay(100);
                        AddAppointmentController.patientID = "";
                        final result =
                            await Get.toNamed(Routes.AddAppointment)!;
                        if (result != null) {
                          await controller.getAppointmentListData();
                        }
                      },
                    ),
                    SpeedDialChild(
                      backgroundColor: AppColors.PRIMARY_COLOR,
                      labelBackgroundColor: AppTheme.chipBackground,
                      child: const Icon(
                        Icons.arrow_circle_down_rounded,
                        color: AppTheme.nearlyWhite,
                      ),
                      label: 'Export',
                      onTap: () async {
                        await Utilities.delay(100);
                        await Get.toNamed(Routes.ExportAppointment);
                      },
                    ),
                  ])
            : SizedBox.shrink();
      }),
    );
  }
}
