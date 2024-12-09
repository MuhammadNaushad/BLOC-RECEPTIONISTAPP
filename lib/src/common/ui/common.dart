import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/utilities.dart';

mixin CommonWidget {
  //
  Widget makeInput(
      {label, obsureText = false, required TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          SizedBox(
            height: 5.0,
          ),
          TextField(
            controller: controller,
            obscureText: obsureText,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.grey,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget tfContainer({Widget? child, double? height, double? width}) {
    return SizedBox(
        width: width ?? Utilities.fullWidth * .52,
        height: height ?? Utilities.fullHeight * .055,
        child: child);
  }

  InputDecoration textFieldStyle1(
          {EdgeInsetsGeometry? cPadding,
          Widget? prefixButton,
          Widget? suffixButton}) =>
      InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
              borderSide: BorderSide(
                color: Colors.transparent,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
              borderSide: BorderSide(
                color: Colors.transparent,
              )),
          prefixIcon: prefixButton,
          suffixIcon: suffixButton,
          fillColor: AppTheme.nearlyWhite,
          contentPadding: cPadding ?? const EdgeInsets.fromLTRB(10, 0, 0, 0),
          filled: true);

  InputDecoration textFieldStyle2(
          {EdgeInsetsGeometry? cPadding,
          String? hint,
          double? hintFontSize,
          double? labelFontSize,
          bool? isDense,
          Widget? prefixButton,
          Widget? suffixButton,
          bool isError = false}) =>
      InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.PRIMARY_LIGHT, fontSize: labelFontSize ?? 13.5),
        hintStyle: TextStyle(
            color: AppColors.PRIMARY_LIGHT, fontSize: hintFontSize ?? 13.5),
        hintText: hint,
        isDense: isDense ?? true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError ? AppColors.RED : AppColors.PRIMARY_LIGHT,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError ? AppColors.RED : AppColors.PRIMARY_COLOR,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: isError ? AppColors.RED : AppColors.PRIMARY_LIGHT,
        )),
        prefixIcon: prefixButton,
        suffixIcon: suffixButton,
      );

  InputDecoration textFieldStyle3(
          {EdgeInsetsGeometry? cPadding,
          String? hint,
          double? hintFontSize,
          double? labelFontSize,
          bool? isDense,
          Widget? prefixButton,
          Widget? suffixButton,
          bool isError = false}) =>
      InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.PRIMARY_LIGHT, fontSize: labelFontSize ?? 14),
        hintStyle: TextStyle(
            color: AppColors.PRIMARY_LIGHT, fontSize: hintFontSize ?? 14),
        hintText: hint,
        isDense: isDense ?? true,
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError ? AppColors.RED : AppColors.PRIMARY_LIGHT,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError ? AppColors.RED : AppColors.PRIMARY_COLOR,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: isError ? AppColors.RED : AppColors.PRIMARY_LIGHT,
        )),
        prefixIcon: prefixButton,
        suffixIcon: suffixButton,
      );

  InputDecoration loginTFStyle(
          {EdgeInsetsGeometry? cPadding,
          String? hint,
          Widget? prefixButton,
          Widget? suffixButton}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Theme.of(Get.context!).disabledColor,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        prefixIcon: prefixButton,
        suffixIcon: suffixButton,
      );

  InputDecoration searchDropdwnInputDecoration({bool isDarkBorder = false}) =>
      InputDecoration(
        hintText: "Search",
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkBorder
                ? AppColors.PRIMARY_COLOR
                : AppColors.PRIMARY_LIGHT,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkBorder
                ? AppColors.PRIMARY_COLOR
                : AppColors.PRIMARY_LIGHT,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color:
              isDarkBorder ? AppColors.PRIMARY_COLOR : AppColors.PRIMARY_LIGHT,
        )),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      );
  InputDecoration searchDropdwnDecoration(
          {bool isDarkBorder = false, String? hint}) =>
      InputDecoration(
        hintText: hint ?? "",
        hintStyle: TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkBorder
                ? AppColors.PRIMARY_Medium_LIGHT
                : AppColors.PRIMARY_LIGHT,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkBorder
                ? AppColors.PRIMARY_Medium_LIGHT
                : AppColors.PRIMARY_LIGHT,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: isDarkBorder
              ? AppColors.PRIMARY_Medium_LIGHT
              : AppColors.PRIMARY_LIGHT,
        )),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      );
  Widget searchDropDownStyle1(BuildContext context, String? selectedItem) {
    return Text(
      selectedItem!,
      style: TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14.2),
    );
  }

  Widget searchDropDownStyle2(
      BuildContext context, String? item, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Text(
        item!,
        style: TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14.2),
      ),
    );
  }

  Widget searchDropDownStyle3(
      BuildContext context, String? item, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Text(
        item!,
        style: TextStyle(color: Colors.black87, fontSize: 14.2),
      ),
    );
  }

  Widget searchDropDownStyle4(BuildContext context, String? selectedItem) {
    return Text(
      selectedItem!,
      style: TextStyle(color: Colors.black87, fontSize: 14.2),
    );
  }

  InputDecoration inputDecorations(
      {Widget? prefixIcon, String? labelText, double? borderRadius}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
      labelText: labelText,
      labelStyle: secondaryTextStyle(),
      alignLabelWithHint: true,
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: BorderSide(color: Colors.red, width: 0.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
      errorMaxLines: 2,
      border: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      errorStyle: primaryTextStyle(color: Colors.red, size: 12),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 0.0),
      ),
      filled: true,
      fillColor: Get.context!.cardColor,
    );
  }

  //
  static Widget commonButton(
          {required String text,
          required Function()? onPressed,
          double? height,
          double? width}) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize:
                Size(width ?? double.infinity, height ?? Get.height * .068),
            backgroundColor: AppColors.PRIMARY_COLOR,
            foregroundColor: AppColors.WHITE),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: AppColors.WHITE),
        ),
        onPressed: onPressed,
      );

  static Widget commonObsBtn(
          {required String text,
          required Function()? onPressed,
          double? height,
          double? width,
          required RxBool isLoading}) =>
      Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, Get.height * .068),
              backgroundColor: AppColors.SEC_COLOR,
              foregroundColor: AppColors.PRIMARY_COLOR),
          child: !isLoading.value
              ? Text(
                  text,
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.PRIMARY_COLOR),
                )
              : CircularProgressIndicator(),
          onPressed: onPressed,
        ),
      );
}

abstract class UtilitiesAbstract {
  Future<void> onRefresh();
}
