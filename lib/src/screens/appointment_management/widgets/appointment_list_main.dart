import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/widgets/shimmers.dart';

import '../controllers/appointment_management_cntler.dart';
import 'appointment_listview.dart';

class AppointmentListMain extends GetView<AppointmentManagementController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !AppointmentManagementController.isLoading.value
          ? !AppointmentManagementController.isDataNotFound.value
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: controller.pController,
                          itemCount: AppointmentManagementController
                                  .appointmentList!.isNotEmpty
                              ? AppointmentManagementController
                                  .appointmentList!.length
                              : 0,
                          padding: EdgeInsets.only(
                              top: 8, bottom: Get.height * 0.24),
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final int count = AppointmentManagementController
                                        .appointmentList!.length >
                                    10
                                ? 10
                                : AppointmentManagementController
                                    .appointmentList!.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: controller.animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            controller.animationController?.forward();
                            return AppointmentListView(
                              callback: () {},
                              data: AppointmentManagementController
                                  .appointmentList![index],
                              animation: animation,
                              animationController:
                                  controller.animationController!,
                            );
                          }),
                    ),
                    // when the _loadMore function is running
                    GetBuilder<AppointmentManagementController>(
                        builder: (context) {
                      return controller.isLoadMoreRunning == true
                          ? Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 40),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SizedBox.shrink();
                    }),
                  ],
                )
              : NoDataWidget(
                  title: "No Data Found",
                )
          : ShimmerForListView(
              height: Get.height * .16,
            ),
    );
  }
}
