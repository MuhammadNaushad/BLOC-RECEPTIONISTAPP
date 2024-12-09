import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';

import '../controller/export_cntler.dart';

class PaymentModeDropDown extends GetView<ExportController> with CommonWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Constant.head1Txt('Payment Mode'),
        ),
        SizedBox(
          height: 3.0,
        ),
        /* GetBuilder<ExportController>(
          builder: (controller) => Container(
            height: 40,
            margin: const EdgeInsets.only(top: 2.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            ),
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
        GetBuilder<ExportController>(builder: (controller) {
          return Container(
            height: 36.5,
            margin: const EdgeInsets.only(top: 2.0, left: 5.0),
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
                      child: PopText(text: "Online"),
                    ),
                  ];
                },
                onSelected: (value) async {
                  print(value);
                  if (value == 0) {
                    controller.paymentDDCtrler.text = "Cash";
                    controller.paymentDDIdToPost = 'cash';
                  } else {
                    controller.paymentDDCtrler.text = "Online";
                    controller.paymentDDIdToPost = 'online';
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

class PopText extends StatelessWidget {
  final String? text;
  const PopText({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: AppColors.PRIMARY_LIGHT,
        fontSize: 14,
      ),
    );
  }
}
