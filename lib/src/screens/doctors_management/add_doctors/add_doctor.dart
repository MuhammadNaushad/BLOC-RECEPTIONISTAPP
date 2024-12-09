import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import '../../../common/ui/common.dart';
import '../../../common/widgets/appBar.dart';
import 'controllers/add_doctor_cntler.dart';
import 'widgets/add_doctor_form.dart';

class AddDoctor extends GetView<AddDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          viewType: AddDoctorController.doctorID.isNotEmpty
              ? 'Update Doctor'
              : 'Add New Doctor'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [AddDoctorForm()],
          ),
        ),
      )),
      bottomNavigationBar: Container(
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
          child: GetBuilder<AddDoctorController>(builder: (cntler) {
            return CommonWidget.commonButton(
                text: controller.doctorIdToPost.isNotEmpty &&
                        controller.doctorIdToPost != "0"
                    ? 'Update'
                    : 'Submit',
                onPressed: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (controller.formKey.currentState!.validate()) {
                    if (AddDoctorController.doctorID.isNotEmpty) {
                      await controller.updateDoctor();
                    } else {
                      await controller.addDoctor();
                    }
                  }
                });
          }),
        ),
      ),
    );
  }
}
