import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

enum Status { active, inactive }

class ActiveInactiveWidget extends StatefulWidget {
  const ActiveInactiveWidget({Key? key}) : super(key: key);
  @override
  State<ActiveInactiveWidget> createState() => _ActiveInactiveWidgetState();
}

class _ActiveInactiveWidgetState extends State<ActiveInactiveWidget> {
  Status _status = Status.active;

  @override
  Widget build(BuildContext context) {
    final AddPatientController cntler = Get.find<AddPatientController>();
    cntler.statusToPost = 1;
    return Row(
      children: <Widget>[
        Row(
          children: [
            Radio<Status>(
              value: Status.active,
              groupValue: _status,
              onChanged: (Status? value) {
                setState(() {
                  _status = value!;
                  cntler.statusToPost = 1;
                });
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
              groupValue: _status,
              onChanged: (Status? value) {
                setState(() {
                  _status = value!;
                  cntler.statusToPost = 0;
                });
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
  }
}
