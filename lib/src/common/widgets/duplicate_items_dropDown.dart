import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:yslcrm/src/utils/colors.dart';

class DuplicateItemsDropDown extends StatelessWidget {
  final String? hintText;
  final Function(String? newValue)? onChanged;
  final int? maxLines;
  final double? height;
  final List<String> items;
  final TextEditingController controller;
  final bool disableDropdown;

  DuplicateItemsDropDown(
      {required this.controller,
      required this.onChanged,
      required this.items,
      this.hintText,
      this.height = 40,
      this.maxLines,
      this.disableDropdown = true});
  @override
  Widget build(BuildContext context) {
    return duplicateItemsDropDowns();
  }

  Widget duplicateItemsDropDowns() {
    return SizedBox(
      height: height,
      child: CustomDropdown(
        excludeSelected: false,
        hintText: hintText ?? '--Select--',
        hintStyle: TextStyle(
          color: AppColors.PRIMARY_LIGHT,
          fontSize: 14,
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.PRIMARY_LIGHT,
        ),
        borderRadius: BorderRadius.circular(4),
        selectedStyle: TextStyle(
          color: AppColors.PRIMARY_LIGHT,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        listItemStyle: TextStyle(
          color: AppColors.PRIMARY_LIGHT,
          fontSize: 14,
        ),
        fieldSuffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.PRIMARY_LIGHT,
          size: 20,
        ),
        items: items,
        controller: controller,
        // isDisable: disableDropdown,
        onChanged: onChanged,
      ),
    );
  }
}
