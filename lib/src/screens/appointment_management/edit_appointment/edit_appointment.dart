import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../../../common/ui/common.dart';
import '../../../common/widgets/appBar.dart';
import 'controllers/edit_appointment_cntler.dart';
import 'widgets/edit_appointment_form.dart';

class EditAppointment extends GetView<EditAppointmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          viewType: EditAppointmentController.patientID.isNotEmpty
              ? 'Update Appointment'
              : 'Update Appointment'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [EditAppointmentForm()],
          ),
        ),
      )),
      bottomNavigationBar:
          GetBuilder<EditAppointmentController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              color: AppTheme.nearlyWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                topLeft: Radius.circular(0.0),
              )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: GetBuilder<EditAppointmentController>(builder: (cntler) {
              return CommonWidget.commonButton(
                  text: 'Update',
                  onPressed: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (controller.formKey.currentState!.validate()) {
                      if (controller.slotsDDIdToPost.isEmpty) {
                        Utilities.showToast(message: "Slots not selected");
                      } else if (controller
                              .appointmentDDValueToPostServer.isEmpty ||
                          controller.appointmentDDValueToPostServer ==
                              "--Select--") {
                        Utilities.showToast(
                            message: "Appointment status not selected");
                      } else if (controller.tokenDDValueToPostServer.isEmpty ||
                          controller.tokenDDValueToPostServer == "--Select--") {
                        Utilities.showToast(
                            message: "Token status not selected");
                      } else {
                        await controller.updateAppointment();
                      }
                    }
                  });
            }),
          ),
        );
      }),
    );
  }
}
