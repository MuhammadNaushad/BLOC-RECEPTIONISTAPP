import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/widgets/shimmers.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/assign_schedules/controllers/assign_schedule_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/hex_color.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../add_doctors/controllers/add_doctor_cntler.dart';
import '../controllers/doctors_management_cntler.dart';
import 'doctors_listview.dart';

class DoctorsListMain extends GetView<DoctorManageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !DoctorManageController.isLoading.value
          ? !DoctorManageController.isDataNotFound.value
              ? ListView.builder(
                  itemCount: DoctorManageController.doctorsList!.isNotEmpty
                      ? DoctorManageController.doctorsList!.length
                      : 0,
                  padding: EdgeInsets.only(top: 8, bottom: Get.height * 0.1),
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final int count =
                        DoctorManageController.doctorsList!.length > 10
                            ? 10
                            : DoctorManageController.doctorsList!.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: controller.animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    controller.animationController?.forward();
                    return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          extentRatio:
                              controller.isDoctorManagementView! ? 0.5 : 0.6,
                          motion: ScrollMotion(),
                          children: [
                            if (controller.isDoctorManagementView!) ...[
                              Expanded(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () async {
                                      await Utilities.delay(200);
                                      try {
                                        final doctor = DoctorManageController
                                            .doctorsList![index];
                                        AddDoctorController.doctorID =
                                            doctor.id.toString();
                                        final Map<String, String> doctorData = {
                                          "id": doctor.id.toString(),
                                          "name": doctor.name.toString(),
                                          "email": doctor.email.toString(),
                                          "phone":
                                              doctor.phoneNumber.toString(),
                                          "gender": doctor.gender
                                              .capitalizeFirstLetter()
                                              .toString(),
                                          "password":
                                              doctor.password.toString(),
                                          "new_consultation_fees": doctor
                                              .new_consultation_fees
                                              .toString(),
                                          "followup_consultation_fees": doctor
                                              .followup_consultation_fees
                                              .toString(),
                                          "status": doctor.status.toString()
                                        };
                                        debugPrint(doctorData.toString());
                                        final result = await Get.toNamed(
                                            Routes.AddDoctor,
                                            parameters: doctorData)!;
                                        if (result != null) {
                                          await controller.getDoctorsListData();
                                        }
                                      } catch (e) {
                                        debugPrint(e.toString());
                                        Utilities.showToast(
                                            message: "Something went wrong");
                                      }
                                    },
                                    child: Ink(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 12),
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF21B7CA),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              offset: const Offset(2.5, 2.5),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit,
                                                color: Colors.white),
                                            5.height,
                                            Text(
                                              "Edit",
                                              style: AppTheme.title.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () async {
                                      await Utilities.delay(200);
                                      showConfirmDialogCustom(
                                        Get.context!,
                                        primaryColor: AppColors.PRIMARY_COLOR,
                                        title: 'Delete',
                                        subTitle:
                                            'Are you sure you want to delete?',
                                        onAccept: (_) async {
                                          await controller.deleteDoctor(
                                            doctor_id: DoctorManageController
                                                .doctorsList![index].id
                                                .toString(),
                                          );
                                        },
                                      );
                                    },
                                    child: Ink(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 12),
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: HexColor("#FA7D82"),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              offset: const Offset(2.5, 2.5),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete,
                                                color: Colors.white),
                                            5.height,
                                            Text(
                                              "Delete",
                                              style: AppTheme.title.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              /*  SlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                onPressed: (_) async {
                                  try {
                                    final doctor = DoctorManageController
                                        .doctorsList![index];
                                    AddDoctorController.doctorID =
                                        doctor.id.toString();
                                    final Map<String, String> doctorData = {
                                      "id": doctor.id.toString(),
                                      "name": doctor.name.toString(),
                                      "email": doctor.email.toString(),
                                      "phone": doctor.phoneNumber.toString(),
                                      "gender": doctor.gender.toString(),
                                      "password": doctor.password.toString(),
                                      "new_consultation_fees": doctor
                                          .new_consultation_fees
                                          .toString(),
                                      "followup_consultation_fees": doctor
                                          .followup_consultation_fees
                                          .toString(),
                                      "status": doctor.status.toString()
                                    };
                                    debugPrint(doctorData.toString());
                                    final result = await Get.toNamed(
                                        Routes.AddDoctor,
                                        parameters: doctorData)!;
                                    if (result != null) {
                                      await controller.getDoctorsListData();
                                    }
                                  } catch (e) {
                                    debugPrint(e.toString());
                                    Utilities.showToast(
                                        message: "Something went wrong");
                                  }
                                },
                                backgroundColor: Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                backgroundColor: HexColor("#FA7D82"),
                                foregroundColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                icon: Icons.delete,
                                label: 'Delete',
                                onPressed: (BuildContext context) {
                                  showConfirmDialogCustom(
                                    Get.context!,
                                    primaryColor: AppColors.PRIMARY_COLOR,
                                    title: 'Delete',
                                    subTitle:
                                        'Are you sure you want to delete?',
                                    onAccept: (_) async {
                                      await controller.deleteDoctor(
                                        doctor_id: DoctorManageController
                                            .doctorsList![index].id
                                            .toString(),
                                      );
                                    },
                                  );
                                },
                              ),
                           */
                            ] else ...[
                              /* SlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                onPressed: (_) async {
                                  try {
                                    final doctor = DoctorManageController
                                        .doctorsList![index];
                                    final Map<String, String> doctorData = {
                                      "id": doctor.id.toString(),
                                      "name": doctor.name.toString(),
                                    };
                                    debugPrint(doctorData.toString());
                                    await Get.toNamed(Routes.AddSlot,
                                        parameters: doctorData)!;
                                    /* if (result != null) {
                                      await AssignScheduleController
                                          .getScheduleListData();
                                    } */
                                  } catch (e) {
                                    debugPrint(e.toString());
                                    Utilities.showToast(
                                        message: "Something went wrong");
                                  }
                                },
                                backgroundColor: Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.add,
                                label: 'Add Slot',
                              ),
                              SlidableAction(
                                backgroundColor: HexColor("#FA7D82"),
                                foregroundColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                icon: Icons.schedule,
                                label: 'View Schedule',
                                onPressed: (BuildContext context) async {
                                  final doctor = DoctorManageController
                                      .doctorsList![index];
                                  AssignScheduleController.doctorID =
                                      DoctorManageController
                                          .doctorsList![index].id
                                          .toString();
                                  final Map<String, String> doctorData = {
                                    "id": doctor.id.toString(),
                                    "name": doctor.name.toString(),
                                  };
                                  debugPrint(doctorData.toString());
                                  final result = await Get.toNamed(
                                      Routes.AssignSlotManagement,
                                      parameters: doctorData)!;
                                  if (result != null) {
                                    // await AssignScheduleController.getScheduleListData();
                                  }
                                },
                              ),
                             */

                              Expanded(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () async {
                                      await Utilities.delay(200);
                                      try {
                                        final doctor = DoctorManageController
                                            .doctorsList![index];
                                        final Map<String, String> doctorData = {
                                          "id": doctor.id.toString(),
                                          "name": doctor.name.toString(),
                                        };
                                        debugPrint(doctorData.toString());
                                        await Get.toNamed(Routes.AddSlot,
                                            parameters: doctorData)!;
                                        /* if (result != null) {
                                      await AssignScheduleController
                                          .getScheduleListData();
                                    } */
                                      } catch (e) {
                                        debugPrint(e.toString());
                                        Utilities.showToast(
                                            message: "Something went wrong");
                                      }
                                    },
                                    child: Ink(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 12),
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF21B7CA),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              offset: const Offset(2.5, 2.5),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add,
                                                color: Colors.white),
                                            5.height,
                                            Text(
                                              "Add Slot",
                                              textAlign: TextAlign.center,
                                              style: AppTheme.title.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () async {
                                      await Utilities.delay(200);
                                      final doctor = DoctorManageController
                                          .doctorsList![index];
                                      AssignScheduleController.doctorID =
                                          DoctorManageController
                                              .doctorsList![index].id
                                              .toString();
                                      final Map<String, String> doctorData = {
                                        "id": doctor.id.toString(),
                                        "name": doctor.name.toString(),
                                      };
                                      debugPrint(doctorData.toString());
                                      final result = await Get.toNamed(
                                          Routes.AssignSlotManagement,
                                          parameters: doctorData)!;
                                      if (result != null) {
                                        // await AssignScheduleController.getScheduleListData();
                                      }
                                    },
                                    child: Ink(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 12),
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: HexColor("#FA7D82"),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              offset: const Offset(2.5, 2.5),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.schedule,
                                                color: Colors.white),
                                            5.height,
                                            Text(
                                              "View Schedule",
                                              textAlign: TextAlign.center,
                                              style: AppTheme.title.copyWith(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        // The child of the Slidable is what the user sees when the
                        // component is not dragged.
                        child: DoctorListView(
                          callback: () {},
                          data: DoctorManageController.doctorsList![index],
                          animation: animation,
                          animationController: controller.animationController!,
                        ));
                  })
              : NoDataWidget(
                  title: "No Data Found",
                )
          : ShimmerForListView(
              height: Get.height * .16,
            ),
    );
  }
}
