import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';
import '../controllers/appointment_management_cntler.dart';

class DoctorDropDown extends GetView<AppointmentManagementController>
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
        GetBuilder<AppointmentManagementController>(
          builder: (controller) => Container(
            height: 40,
            margin: const EdgeInsets.only(top: 2.0, left: 10, right: 10),
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
                  controller.page = 1;
                  await controller.getAppointmentListData(
                      search: controller.searchCtrler.text.trim(),
                      doctorId: controller.doctorDDIdToPost);
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
