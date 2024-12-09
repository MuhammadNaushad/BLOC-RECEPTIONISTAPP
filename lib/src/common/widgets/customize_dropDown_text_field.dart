import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';

class CustomDropdownButton1 extends StatelessWidget {
  final String hint;
  final TextStyle? hintTS;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight, itemWidth;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final bool? disableDropdown;
  final Offset? offset;

  const CustomDropdownButton1({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.disableDropdown = false,
    this.hintTS,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemWidth,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: new IgnorePointer(
        ignoring: disableDropdown!,
        child: DropdownButton2(
          //To avoid long text overflowing.
          isExpanded: true,
          hint: Container(
            alignment: hintAlignment,
            child: Text(hint,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: hintTS ?? Constant.kycHeadTxtTS),
          ),
          value: value,
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 22,
                color: AppColors.PRIMARY_LIGHT,
              ),
            ),
          ),
          items: dropdownItems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      alignment: valueAlignment,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: null,
                        style: TextStyle(
                          color: AppColors.PRIMARY_LIGHT,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: selectedItemBuilder,
          /*  icon: icon ?? const Icon(Icons.arrow_drop_down),
          iconSize: iconSize ?? 12,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
          buttonHeight: buttonHeight ?? 40,
          buttonWidth: buttonWidth ?? MediaQuery.of(context).size.width,
          buttonPadding:
              buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.PRIMARY_LIGHT,
                ),
              ),
          buttonElevation: buttonElevation,
          itemHeight: itemHeight ?? 40,
          //itemWidth: itemWidth ?? MediaQuery.of(context).size.width * .3,
          itemPadding:
              itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          dropdownMaxHeight: dropdownHeight ?? 200,
          dropdownPadding: dropdownPadding,
          dropdownDecoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(1),
              ),
          dropdownElevation: dropdownElevation ?? 8,
          scrollbarRadius: scrollbarRadius ?? const Radius.circular(1),
          scrollbarThickness: scrollbarThickness,
          scrollbarAlwaysShow: scrollbarAlwaysShow,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          dropdownOverButton:
              false, */ //Default is false to show menu below button
        ),
      ),
    );
  }
}
