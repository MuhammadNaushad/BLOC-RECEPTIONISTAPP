import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/controllers/add_doctor_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

enum Gender { male, female, other }

class GenderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDoctorController>(builder: (cntler) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Radio<Gender>(
                value: Gender.male,
                groupValue: cntler.genderValue,
                onChanged: (Gender? value) {
                  cntler.genderValue = value!;
                  cntler.genderToPost = "Male";
                  print(cntler.genderToPost);
                  cntler.update();
                },
              ),
              Text(
                "Male",
                style: AppTheme.title,
              ),
            ],
          ),
          Row(
            children: [
              Radio<Gender>(
                value: Gender.female,
                groupValue: cntler.genderValue,
                onChanged: (Gender? value) {
                  cntler.genderValue = value!;
                  cntler.genderToPost = "Female";
                  print(cntler.genderToPost);
                  cntler.update();
                },
              ),
              Text(
                "Female",
                style: AppTheme.title,
              ),
            ],
          ),
          Row(
            children: [
              Radio<Gender>(
                value: Gender.other,
                groupValue: cntler.genderValue,
                onChanged: (Gender? value) {
                  cntler.genderValue = value!;
                  cntler.genderToPost = "Other";
                  print(cntler.genderToPost);
                  cntler.update();
                },
              ),
              Text(
                "Other",
                style: AppTheme.title,
              ),
            ],
          ),
        ],
      );
    });
  }
}
