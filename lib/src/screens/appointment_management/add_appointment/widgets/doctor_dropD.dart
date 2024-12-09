import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/controllers/add_appointment_cntler.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class DoctorDropDown extends GetView<AddAppointmentController>
    with CommonWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* Constant.head1Txt('Currency'),
        SizedBox(
          height: 6.0,
        ), */
        GetBuilder<AddAppointmentController>(
          builder: (controller) => Container(
            height: 40,
            margin: const EdgeInsets.only(top: 2.0),
            child: DropdownSearch<String>(
              enabled: controller.isDoctorDDEnable,
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
                  controller.isDateEnable = true;
                  controller.dateCtrler.text = "";
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
                  await controller.getPrice();
                  controller.update();
                  //find vendor id
                  //  controller.searchVendorDetailsById(value);
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
