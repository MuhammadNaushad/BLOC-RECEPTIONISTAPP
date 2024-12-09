import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/customize_dropDown_text_field.dart';
import 'package:yslcrm/src/screens/appointment_management/edit_appointment/controllers/edit_appointment_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class TokenStatusDropDown extends GetView<EditAppointmentController>
    with CommonWidget {
  final int appointmmentId;
  TokenStatusDropDown({required this.appointmmentId});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constant.head1Txt('Token Status'),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 38,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.lightText,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: GetBuilder<EditAppointmentController>(builder: (controller) {
            return CustomDropdownButton1(
              buttonWidth: Get.width,
              hint: 'Token Status',
              icon: Constant.dropDownTFIconWidget(color: Colors.black),
              dropdownItems: controller.tokenDDList,
              value: controller.tokenDDValueToPost,
              hintTS: TextStyle(color: Colors.white),
              onChanged: (value) async {
                if (value != "--Select--") {
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
                  /* if (value != "--Select--") {
                  await controller.changeStokenStatus();
                } */
                } else {
                  Utilities.showToast(message: "Please select a status");
                }
                controller.update();
              },
            );
            /*  PopupMenuButton(
                    // add icon, by default "3 dot" icon
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            "Token Status",
                            textAlign: TextAlign.left,
                            style: AppTheme.title
                                .copyWith(fontSize: 12.8, color: Colors.white),
                          ),
                        ),
                      ],
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
                    }); */
          }),
        ),
      ],
    );
  }
}
