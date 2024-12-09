import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/controllers/add_appointment_cntler.dart';
import 'package:yslcrm/src/screens/appointment_management/export/widgets/paymentmode_dropD.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';

class PaymentModeDropDown extends GetView<AddAppointmentController>
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
        /* GetBuilder<AddAppointmentController>(
          builder: (controller) => Container(
            height: 40,
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
              items: controller.paymentDDList,
              selectedItem: controller.paymentDDCtrler.text,
              onChanged: (String? value) {
                if (value!.isNotEmpty) {
                  controller.paymentDDCtrler.text = value;
                  controller.isPaymentTFEnable = true;
                  print(value);
                  if (value == "Cash") {
                    controller.paymentDDIdToPost = 'cash';
                  } else {
                    controller.paymentDDIdToPost = 'walkInOnline';
                  }
                  controller.update();
                  //find vendor id
                  //  controller.searchVendorDetailsById(value);
                } else {
                  Utilities.showToast(message: "Please select a mode");
                }
              },
            ),
          ),
        ), */
        GetBuilder<AddAppointmentController>(builder: (controller) {
          return Container(
            height: 36.5,
            margin: const EdgeInsets.only(top: 2.0, left: 0.0),
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.paymentDDIdToPost.isNotEmpty
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.PRIMARY_LIGHT,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: PopupMenuButton(
                // add icon, by default "3 dot" icon
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          controller.paymentDDCtrler.text.isNotEmpty
                              ? controller.paymentDDCtrler.text
                              : "--select--",
                          textAlign: TextAlign.left,
                          style: AppTheme.title.copyWith(
                              color: AppTheme.lightText,
                              fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Constant.dropDownTFIconWidget(),
                    SizedBox(
                      width: 3,
                    ),
                  ],
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: PopText(text: "Cash"),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: PopText(text: "Walk In Online"),
                    ),
                  ];
                },
                onSelected: (value) async {
                  print(value);
                  controller.isPaymentTFEnable = true;
                  if (value == 0) {
                    controller.paymentDDCtrler.text = "Cash";
                    controller.paymentDDIdToPost = 'cash';
                  } else {
                    controller.paymentDDCtrler.text = "Online";
                    controller.paymentDDIdToPost = 'walkInOnline';
                  }

                  controller.update();
                  //find vendor id
                  //  controller.searchVendorDetailsById(value);
                }),
          );
        }),
      ],
    );
  }
}
