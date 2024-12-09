import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../controller/export_cntler.dart';

class DoctorDropDown extends GetView<ExportController> with CommonWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constant.head1Txt('Doctor'),
        SizedBox(
          height: 6.0,
        ),
        GetBuilder<ExportController>(
          builder: (controller) => Container(
            height: 40,
            /*  margin: const EdgeInsets.only(
              top: 20.0,
            ), */
            child: DropdownSearch<String>(
              dropdownBuilder: searchDropDownStyle1,
              dropdownButtonProps:
                  DropdownButtonProps(icon: Constant.dropDownTFIconWidget()),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration:
                      searchDropdwnDecoration(isDarkBorder: false)),
              popupProps: PopupProps.menu(
                  showSearchBox: true,
                  showSelectedItems: true,
                  itemBuilder: searchDropDownStyle2,
                  searchFieldProps: TextFieldProps(
                      decoration: searchDropdwnInputDecoration())),
              items: controller.doctorDDList,
              selectedItem: controller.doctorDDCtrler.text,
              onChanged: (String? value) async {
                if (value!.isNotEmpty) {
                  controller.doctorDDCtrler.text = value;
                  print(value);
                  for (var i = 0; i < controller.doctorDDList.length; i++) {
                    if (controller.doctorDDCtrler.text ==
                        controller.doctorDDList[i]) {
                      final dId = controller.doctorDDIDList[i];
                      debugPrint(dId);
                      controller.doctorDDIdToPost = dId;
                      debugPrint(controller.doctorDDIdToPost);
                      break;
                    }
                  }
                  //await controller.exportApppointment(date: );
                  controller.update();
                } else {
                  Utilities.showToast(message: "Please select a doctor");
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
