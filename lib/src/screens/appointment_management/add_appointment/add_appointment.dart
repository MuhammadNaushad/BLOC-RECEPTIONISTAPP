import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import '../../../common/ui/common.dart';
import '../../../common/widgets/appBar.dart';
import 'controllers/add_appointment_cntler.dart';
import 'widgets/add_appointment_form.dart';

class AddAppointment extends GetView<AddAppointmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          viewType: AddAppointmentController.patientID.isNotEmpty
              ? 'Add Appointment'
              : 'Add Appointment'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [AddAppointmentForm()],
          ),
        ),
      )),
      bottomNavigationBar:
          GetBuilder<AddAppointmentController>(builder: (controller) {
        return !controller.isShowSearchBtn
            ? Container(
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
                  child:
                      GetBuilder<AddAppointmentController>(builder: (cntler) {
                    return CommonWidget.commonButton(
                        text: controller.patientIdToPost.isNotEmpty &&
                                controller.patientIdToPost != "0"
                            ? 'Update'
                            : 'Submit',
                        onPressed: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (controller.formKey.currentState!.validate()) {
                            await controller.addAppointment();
                          }
                        });
                  }),
                ),
              )
            : SizedBox.shrink();
      }),
    );
  }
}
