import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/profile/controllers/my_profile_cntler.dart';
import 'package:yslcrm/src/utils/constant.dart';

class VendorCatDropDowPage extends GetView<MyProfileController>
    with CommonWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constant.head1Txt('Vendor Category'),
        SizedBox(
          height: 6.0,
        ),
        /* GetBuilder<MyProfileController>(
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
                  constraints: const BoxConstraints(maxHeight: 200),
                  itemBuilder: searchDropDownStyle2,
                  searchFieldProps: TextFieldProps(
                      decoration: searchDropdwnInputDecoration())),
              items: controller.vendorCategoryList,
              selectedItem: MyProfileController.vendorCatCtrler.text,
              onChanged: (value) {
                if (value!.isNotEmpty) {
                  MyProfileController.vendorCatCtrler.text = value;
                  print(value);
                  controller.update();
                  //find vendor id
                  //  controller.searchVendorDetailsById(value);
                }
              },
            ),
          ),
        ), */
        Container(
          constraints: BoxConstraints(minHeight: 40),
          margin: const EdgeInsets.only(top: 2.0),
          child: GetBuilder<MyProfileController>(builder: (cntler) {
            return DropdownSearch<String>.multiSelection(
              selectedItems: controller.vendorSelectedCatNameList.isNotEmpty
                  ? controller.vendorSelectedCatNameList
                  : [],
              //dropdownBuilder: searchDropDownStyle1,
              dropdownButtonProps:
                  DropdownButtonProps(icon: Constant.dropDownTFIconWidget()),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: searchDropdwnDecoration(
                      isDarkBorder: false, hint: "--Select--")),
              popupProps: PopupPropsMultiSelection.dialog(
                  showSearchBox: true,
                  showSelectedItems: true,
                  itemBuilder: searchDropDownStyle3,
                  searchFieldProps: TextFieldProps(
                      decoration: searchDropdwnInputDecoration())),
              clearButtonProps:
                  ClearButtonProps(isVisible: false, iconSize: 20),
              items: controller.vendorCategoryList,
              enabled: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  //find vendor id
                  controller.searchVendorCatId(value);
                  controller.update();
                }
              },
            );
          }),
        )
      ],
    );
  }
}
/* @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: DropdownSearch<String>.multiSelection(
              //dropdownBuilder: searchDropDownStyle1,
              dropdownButtonProps:
                  DropdownButtonProps(icon: Constant.dropDownTFIconWidget()),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: searchDropdwnDecoration(
                      isDarkBorder: false, hint: "--Select--")),
              popupProps: PopupPropsMultiSelection.dialog(
                  showSearchBox: true,
                  showSelectedItems: true,
                  itemBuilder: searchDropDownStyle3,
                  searchFieldProps: TextFieldProps(
                      decoration: searchDropdwnInputDecoration())),
              clearButtonProps:
                  ClearButtonProps(isVisible: false, iconSize: 20),
              items: controller.supervisorNameList,
              enabled: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  //find supervisor ids
                  controller.searchSupervisorById(value);
                } else {
                  controller.supervisorSelectedIdListToPost.clear();
                }
                print(controller.supervisorSelectedIdListToPost);
              },
            ),
          ),
        ),
      ],
    );
  } */