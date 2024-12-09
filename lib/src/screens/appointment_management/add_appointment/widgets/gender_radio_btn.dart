import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

enum Gender { male, female, other }

class GenderWidget extends StatefulWidget {
  const GenderWidget({Key? key}) : super(key: key);
  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  Gender _gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    final AddPatientController cntler = Get.find<AddPatientController>();
    cntler.genderToPost = "Male";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            Radio<Gender>(
              value: Gender.male,
              groupValue: _gender,
              onChanged: (Gender? value) {
                setState(() {
                  _gender = value!;
                  cntler.genderToPost = "Male";
                });
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
              groupValue: _gender,
              onChanged: (Gender? value) {
                setState(() {
                  _gender = value!;
                  cntler.genderToPost = "Female";
                });
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
              groupValue: _gender,
              onChanged: (Gender? value) {
                setState(() {
                  _gender = value!;
                  cntler.genderToPost = "Other";
                });
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
  }
}
