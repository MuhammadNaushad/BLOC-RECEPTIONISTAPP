import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/controllers/add_doctor_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

enum Status { active, inactive }

class ActiveInactiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDoctorController>(builder: (cntler) {
      return Row(
        children: <Widget>[
          Row(
            children: [
              Radio<Status>(
                value: Status.active,
                groupValue: cntler.statusValue,
                onChanged: (Status? value) {
                  cntler.statusValue = value!;
                  cntler.statusToPost = 1;
                  cntler.update();
                },
              ),
              Text(
                "Active",
                style: AppTheme.title,
              ),
            ],
          ),
          Row(
            children: [
              Radio<Status>(
                value: Status.inactive,
                groupValue: cntler.statusValue,
                onChanged: (Status? value) {
                  cntler.statusValue = value!;
                  cntler.statusToPost = 0;
                  cntler.update();
                },
              ),
              Text(
                "Inactive",
                style: AppTheme.title,
              ),
            ],
          ),
        ],
      );
    });
  }
}
