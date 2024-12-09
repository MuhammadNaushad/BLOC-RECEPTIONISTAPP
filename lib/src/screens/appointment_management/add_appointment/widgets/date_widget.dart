import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/widgets/primary_textfield.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/controllers/add_appointment_cntler.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import 'add_appointment_form.dart';

class DateWidget extends GetView<AddAppointmentController> {
  const DateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: controller.dateCtrler,
      enabled: controller.isDateEnable,
      hintText: "Date *",
      keyboardType: TextInputType.name,
      validator: (val) {
        if (controller.dateCtrler.text.isEmpty) {
          return "Please enter date";
        } else {
          return null;
        }
      },
      readOnly: true,
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
