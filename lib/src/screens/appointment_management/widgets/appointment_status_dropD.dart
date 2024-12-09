import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/appointment_management/controllers/appointment_management_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/alerts.dart';

import '../export/widgets/paymentmode_dropD.dart';

class AppointmentStatusDropDown extends GetView<AppointmentManagementController>
    with CommonWidget {
  final int appointmmentId;
  AppointmentStatusDropDown({required this.appointmmentId});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentManagementController>(builder: (context) {
      return Container(
          /* height: 40,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.lightText,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))), */
          child: /*  CustomDropdownButton1(
          buttonWidth: Get.width * .5,
          hint: 'Appointment Status',
          dropdownDecoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          icon: Constant.dropDownTFIconWidget(),
          dropdownItems: context.appointmentDDList,
          value: context.appointmentDDValueToPost,
          itemWidth: Get.width * .5,
          onChanged: (value) async {
            controller.appointmentDDValueToPost = value!;
            if (value == "Active") {
              controller.appointmentDDValueToPostServer = "0";
            } else {
              controller.appointmentDDValueToPostServer = "Cancelled";
            }
            if (value != "--Select--") {
              await controller.changeAppointmentStatus();
            }
            controller.update();
          },
        ),
      ) */

              PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextIcon(
                            text: "Appointment Status",
                            textStyle: AppTheme.title
                                .copyWith(fontSize: 12.8, color: Colors.white),
                            useMarquee: true,
                            expandedText: true,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white)
                      ],
                    ),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: PopText(text: "Active"),
                      ),
                      /*  PopupMenuItem<int>(
                        value: 1,
                        child: PopText(text: "InProgress"),
                      ), */
                      PopupMenuItem<int>(
                        value: 2,
                        child: PopText(text: "Completed"),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        child: PopText(text: "Cancelled"),
                      ),
                    ];
                  },
                  onSelected: (value) async {
                    debugPrint("APPOINTMENT ID ::: ${appointmmentId}");
                    controller.appointmentIdListToPost.clear();
                    controller.appointmentIdListToPost
                        .add(this.appointmmentId.toString());
                    if (value == 0) {
                      controller.appointmentDDValueToPostServer = "0";
                      await controller.changeAppointmentStatus();
                    } else if (value == 2) {
                      controller.appointmentDDValueToPostServer = "Completed";
                      await controller.changeAppointmentStatus();
                    } else {
                      Alerts.showDeletImgDialog(
                          title: "Alert",
                          contenTStr:
                              "Are you sure, you want to cancel appointment?",
                          onYes: () async {
                            controller.appointmentDDValueToPostServer =
                                "Cancelled";
                            await controller.changeAppointmentStatus();
                            controller.update();
                          });
                    }

                    controller.update();
                  }));
    });
  }
}
