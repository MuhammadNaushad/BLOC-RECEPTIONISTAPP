import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/widgets/add_appointment_form.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../controller/export_cntler.dart';

class DateWidget extends GetView<ExportController> {
  const DateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: controller.exportDateCtrler,
      hintText: "Date *",
      keyboardType: TextInputType.name,
      validator: (val) {
        if (controller.exportDateCtrler.text.isEmpty) {
          return "Please enter date";
        } else {
          return null;
        }
      },
      readOnly: true,
      onTap: () async {
        final utilsObj = Utilities();
        controller.exportDateCtrler.text = await utilsObj.selectDate(
            Get.context!,
            tfcntler: controller.exportDateCtrler.text,
            pastDates: true);
        print(controller.exportDateCtrler.text);
        if (controller.exportDateCtrler.text.isNotEmpty) {
          /*  await controller.checkSlots();
          controller.update(); */
        }
      },
    );
  }
}
