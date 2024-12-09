import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/customize_dropDown_text_field.dart';
import 'package:yslcrm/src/screens/appointment_management/edit_appointment/controllers/edit_appointment_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class AppointmentStatusDropDown extends GetView<EditAppointmentController>
    with CommonWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constant.head1Txt('Appointment Status'),
        SizedBox(
          height: 5.0,
        ),
        GetBuilder<EditAppointmentController>(builder: (context) {
          return Container(
            height: 38,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.lightText,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: CustomDropdownButton1(
              buttonWidth: Get.width * .5,
              hint: 'Appointment Status',
              dropdownDecoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              //icon: Constant.dropDownTFIconWidget(),
              dropdownItems: context.appointmentDDList,
              value: context.appointmentDDValueToPost,
              itemWidth: Get.width * .5,
              onChanged: (value) async {
                if (value != "--Select--") {
                  controller.appointmentDDValueToPost = value!;
                  if (value == "Active") {
                    controller.appointmentDDValueToPostServer = "0";
                  } else {
                    controller.appointmentDDValueToPostServer = value;
                  }
                  /* if (value != "--Select--") {
                  await controller.changeAppointmentStatus();
                } */
                } else {
                  Utilities.showToast(message: "Please select a status");
                }
                controller.update();
              },
            ),
          );
        }),

        /*  GetBuilder<EditAppointmentController>(
          builder: (controller) => Container(
            height: 40,
            width: Get.width * .6,
            margin: const EdgeInsets.only(top: 2.0),
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
              items: controller.appointmentDDList,
              selectedItem: controller.appointmentDDCtrler.text,
              onChanged: (String? value) {
                if (value!.isNotEmpty) {
                  controller.appointmentDDCtrler.text = value;

                  print(value);
                  if (value == "Cash") {
                    controller.appointmentDDIdToPost = 'cash';
                  } else {
                    controller.appointmentDDIdToPost = 'walkInOnline';
                  }
                  controller.update();
                  //find vendor id
                  //  controller.searchVendorDetailsById(value);
                } else {
                  Utilities.showToast(message: "Please select a patient");
                }
              },
            ),
          ),
        ),
     */
      ],
    );
  }
}
