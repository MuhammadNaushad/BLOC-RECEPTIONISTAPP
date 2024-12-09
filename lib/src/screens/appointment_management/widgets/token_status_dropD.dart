import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/appointment_management/controllers/appointment_management_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import '../export/widgets/paymentmode_dropD.dart';

class TokenStatusDropDown extends GetView<AppointmentManagementController>
    with CommonWidget {
  final int appointmmentId;
  TokenStatusDropDown({required this.appointmmentId});
  @override
  Widget build(BuildContext context) {
    return Container(
      /*   height: 40,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.lightText,
          ),
          borderRadius: BorderRadius.all(Radius.circular(6))), */
      child: GetBuilder<AppointmentManagementController>(builder: (context) {
        return /* CustomDropdownButton1(
          buttonWidth: Get.width,
          hint: 'Token Status',
          icon: Constant.dropDownTFIconWidget(color: Colors.white),
          dropdownItems: context.tokenDDList,
          value: context.tokenDDValueToPost,
          hintTS: TextStyle(color: Colors.white),
          onChanged: (value) async {
            controller.tokenDDValueToPost = value!;
            if (value == "Active") {
              controller.tokenDDValueToPostServer = "1";
            } else if (value == "InProgress") {
              controller.tokenDDValueToPostServer = "2";
            } else if (value == "Completed") {
              controller.tokenDDValueToPostServer = "0";
            } else {
              controller.tokenDDValueToPostServer = "3";
            }
            if (value != "--Select--") {
              await controller.changeStokenStatus();
            }
            controller.update();
          },
        ); */
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextIcon(
                          text: "Token Status",
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
                    PopupMenuItem<int>(
                      value: 1,
                      child: PopText(text: "InProgress"),
                    ),
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
                    controller.tokenDDValueToPost = "Active";
                  } else if (value == 1) {
                    controller.tokenDDValueToPost = "InProgress";
                  } else if (value == 2) {
                    controller.tokenDDValueToPost = "Completed";
                  } else {
                    controller.tokenDDValueToPost = "Cancelled";
                  }

                  if (value == 0) {
                    controller.tokenDDValueToPostServer = "1";
                  } else if (value == 1) {
                    controller.tokenDDValueToPostServer = "2";
                  } else if (value == 2) {
                    controller.tokenDDValueToPostServer = "0";
                  } else {
                    controller.tokenDDValueToPostServer = "3";
                  }
                  await controller.changeStokenStatus();
                  controller.update();
                });
      }),
    );
  }
}
