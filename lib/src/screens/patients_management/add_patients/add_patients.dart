import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import '../../../common/ui/common.dart';
import '../../../common/widgets/appBar.dart';
import 'controllers/add_patients_cntler.dart';
import 'widgets/add_patient_form.dart';

class AddPatient extends GetView<AddPatientController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          viewType: AddPatientController.patientID.isNotEmpty
              ? 'Update Patient'
              : 'Add New Patient'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*  AddPatientForm(
                patientID: "",
              ) */
            ],
          ),
        ),
      )),
      bottomNavigationBar:
          GetBuilder<AddPatientController>(builder: (controller) {
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
                  child: GetBuilder<AddPatientController>(builder: (cntler) {
                    return CommonWidget.commonButton(
                        text: controller.patientIdToPost.isNotEmpty &&
                                controller.patientIdToPost != "0"
                            ? 'Update'
                            : 'Submit',
                        onPressed: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.isShowPatientView &&
                                controller.userIdToPost.isNotEmpty) {
                              await controller.addPatient();
                            } else if (!controller.isShowPatientView &&
                                AddPatientController.patientID.isNotEmpty) {
                              await controller.updatePatient();
                            } else {
                              await controller.addUser();
                            }
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
