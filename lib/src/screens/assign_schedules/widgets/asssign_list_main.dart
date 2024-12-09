import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/widgets/shimmers.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/hex_color.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../add_slot/controllers/add_slot_cntler.dart';
import '../controllers/assign_schedule_cntler.dart';
import 'assign_listview.dart';

class AssignScheduleListMain extends GetView<AssignScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !AssignScheduleController.isLoading.value
          ? !AssignScheduleController.isDataNotFound.value
              ? ListView.builder(
                  itemCount: AssignScheduleController.slotList!.isNotEmpty
                      ? AssignScheduleController.slotList!.length
                      : 0,
                  padding: EdgeInsets.only(top: 8, bottom: Get.height * 0.1),
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final int count =
                        AssignScheduleController.slotList!.length > 10
                            ? 10
                            : AssignScheduleController.slotList!.length;
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
                          motion: ScrollMotion(),
                          children: [
                            /*        SlidableAction(
                              borderRadius: BorderRadius.circular(10),
                              onPressed: (_) async {
                                try {
                                  final slot =
                                      AssignScheduleController.slotList![index];
                                  AddSlotController.slotID = slot.id.toString();
                                  controller.doctorData = {
                                    "id": Get.parameters["id"].toString(),
                                    "name": Get.parameters["name"].toString(),
                                    "slots": slot.timeSlots.toString(),
                                    "tokens": slot.noOfTokens.toString(),
                                  };
                                  final result = await Get.toNamed(
                                      Routes.AddSlot,
                                      parameters: controller.doctorData);

                                  if (result != null) {
                                    await AssignScheduleController
                                        .getScheduleListData();
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
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              onPressed: (BuildContext context) {
                                showConfirmDialogCustom(
                                  Get.context!,
                                  primaryColor: AppColors.PRIMARY_COLOR,
                                  title: 'Delete',
                                  subTitle: 'Are you sure you want to delete?',
                                  onAccept: (_) async {
                                    await controller.deleteSchedule(
                                      slot_id: AssignScheduleController
                                          .slotList![index].id
                                          .toString(),
                                    );
                                  },
                                );
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
                                      final slot = AssignScheduleController
                                          .slotList![index];
                                      AddSlotController.slotID =
                                          slot.id.toString();
                                      controller.doctorData = {
                                        "id": Get.parameters["id"].toString(),
                                        "name":
                                            Get.parameters["name"].toString(),
                                        "slots": slot.timeSlots.toString(),
                                        "tokens": slot.noOfTokens.toString(),
                                      };
                                      final result = await Get.toNamed(
                                          Routes.AddSlot,
                                          parameters: controller.doctorData);

                                      if (result != null) {
                                        await AssignScheduleController
                                            .getScheduleListData();
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
                                            color: Colors.grey.withOpacity(0.6),
                                            offset: const Offset(2.5, 2.5),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.edit, color: Colors.white),
                                          5.height,
                                          Text(
                                            "Edit",
                                            textAlign: TextAlign.center,
                                            style: AppTheme.title
                                                .copyWith(color: Colors.white),
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
                                        await controller.deleteSchedule(
                                          slot_id: AssignScheduleController
                                              .slotList![index].id
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
                                            color: Colors.grey.withOpacity(0.6),
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
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          5.height,
                                          Text(
                                            "Delete",
                                            textAlign: TextAlign.center,
                                            style: AppTheme.title
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // The child of the Slidable is what the user sees when the
                        // component is not dragged.
                        child: AssignScheduleListView(
                          callback: () {},
                          data: AssignScheduleController.slotList![index],
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
