import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/appointment_management/edit_appointment/controllers/edit_appointment_cntler.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import 'edit_appointment_form.dart';

class DateWidget extends GetView<EditAppointmentController> {
  const DateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: controller.dateCtrler,
      hintText: "Date *",
      keyboardType: TextInputType.name,
      validator: (val) {
        if (controller.dateCtrler.text.isEmpty) {
          return "Please enter date";
        } else {
          return null;
        }
      },
      onTap: () async {
        controller.dateCtrler.text = await Utilities()
            .selectDate(Get.context!, tfcntler: controller.dateCtrler.text);
        print(controller.dateCtrler.text);
        if (controller.dateCtrler.text.isNotEmpty) {
          await controller.checkSlots();
          controller.update();
        }
      },
    );
  }
}
