import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../../../common/widgets/appBar.dart';
import 'controller/export_cntler.dart';
import 'widgets/date_widget.dart';
import 'widgets/doctor_dropD.dart';
import 'widgets/paymentmode_dropD.dart';

class ExportAppointment extends GetView<ExportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(viewType: 'Export Appointment'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: DateWidget()),
                  Expanded(child: PaymentModeDropDown()),
                ],
              ),
              15.height,
              DoctorDropDown(),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 100));
                        if (controller.exportDateCtrler.text.isEmpty) {
                          Utilities.showToast(message: "Please select date");
                        } else {
                          await controller.exportApppointment(
                              date: controller.exportDateCtrler.text,
                              mode: controller.paymentDDIdToPost,
                              isPDF: true);
                        }
                      },
                      textColor: Colors.white,
                      text: "Export PDF",
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500, color: AppColors.WHITE),
                      color: AppColors.PRIMARY_COLOR,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 100));
                        if (controller.exportDateCtrler.text.isEmpty) {
                          Utilities.showToast(message: "Please select date");
                        } else {
                          await controller.exportApppointment(
                              date: controller.exportDateCtrler.text,
                              mode: controller.paymentDDIdToPost,
                              isPDF: false);
                        }
                      },
                      textColor: Colors.white,
                      text: "Export Excel",
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500, color: AppColors.WHITE),
                      color: AppColors.PRIMARY_COLOR,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
