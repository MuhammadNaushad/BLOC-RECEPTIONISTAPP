import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/controllers/add_appointment_cntler.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class SlotsDropDown extends GetView<AddAppointmentController>
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
              enabled: controller.isSlotDDEnable,
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
              items: controller.slotsDDList,
              selectedItem: controller.slotsDDCtrler.text,
              onChanged: (String? value) {
                if (value!.isNotEmpty) {
                  controller.slotsDDCtrler.text = value;
                  debugPrint(value);
                  for (var i = 0; i < controller.slotsDDList.length; i++) {
                    if (controller.slotsDDCtrler.text ==
                        controller.slotsDDList[i]) {
                      final dId = controller.slotsDDIDList[i];
                      controller.slotsDDIdToPost = dId;
                      debugPrint("SLOTID: ${controller.slotsDDIdToPost}");
                      break;
                    }
                  }
                  controller.update();
                  //find vendor id
                  //  controller.searchVendorDetailsById(value);
                } else {
                  Utilities.showToast(message: "Please select a slot");
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
