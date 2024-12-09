import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yslcrm/src/common/ui/common.dart';

class PrimaryTextField extends StatelessWidget with CommonWidget {
  final String? hint;
  final Function(String? newValue)? onChanged;
  final Function()? onEditingComplte;
  final String? Function(String? newValue)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? label;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool isVerticalLabel;
  final bool normalTf;
  final bool borderedTf;
  final bool isHorizontalLabel;
  final EdgeInsets? verticalLabelPadding;
  final EdgeInsets? horizontalLabelPadding;
  final InputDecoration? inputDecoration;
  final TextAlign? textAlign;
  final Color? inputTextColor;
  final TextStyle? vertAndHorHeadTxtTS;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefixButton;
  final Widget? suffixButton;
  final double? hintFontSize;
  final bool? readOnly;
  final bool? isDense;
  final bool isError;
  final Function()? onTap;

  const PrimaryTextField(
      {Key? key,
      this.onChanged,
      this.onEditingComplte,
      this.validator,
      this.hint,
      this.keyboardType,
      this.maxLines = 1,
      this.label,
      this.controller,
      this.obscureText = false,
      this.isHorizontalLabel = false,
      this.isVerticalLabel = false,
      this.normalTf = false,
      this.borderedTf = false,
      this.inputTextColor,
      this.hintFontSize,
      this.vertAndHorHeadTxtTS,
      this.verticalLabelPadding,
      this.horizontalLabelPadding,
      this.textAlign = TextAlign.start,
      this.textCapitalization = TextCapitalization.none,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixButton,
      this.suffixButton,
      this.inputFormatters,
      this.readOnly = false,
      this.isDense = true,
      this.isError = false,
      this.onTap,
      this.inputDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (normalTf) {
      return TextFormField(
          scrollPadding: const EdgeInsets.only(bottom: 32.0),
          controller: controller,
          onChanged: onChanged,
          onEditingComplete: onEditingComplte,
          textAlign: textAlign!,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: inputTextColor ?? Colors.black87),
          maxLines: maxLines!,
          obscureText: obscureText!,
          textCapitalization: textCapitalization,
          decoration: inputDecoration ??
              loginTFStyle(
                  hint: hint,
                  prefixButton: prefixButton,
                  suffixButton: suffixButton));
    } else if (borderedTf) {
      return TextFormField(
          scrollPadding: const EdgeInsets.only(bottom: 32.0),
          onTap: onTap,
          controller: controller,
          readOnly: readOnly!,
          onChanged: onChanged,
          onEditingComplete: onEditingComplte,
          textAlign: textAlign!,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: inputTextColor ?? Colors.black87),
          maxLines: maxLines!,
          obscureText: obscureText!,
          textCapitalization: textCapitalization,
          decoration: inputDecoration ??
              textFieldStyle2(
                  hint: hint,
                  hintFontSize: hintFontSize,
                  suffixButton: suffixButton,
                  isDense: isDense,
                  isError: this.isError));
    } else {
      if (isVerticalLabel) {
        return Padding(
          padding: verticalLabelPadding ?? const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label!.isNotEmpty
                  ? Text(
                      label!,
                      style: vertAndHorHeadTxtTS ??
                          TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                readOnly: readOnly!,
                scrollPadding: const EdgeInsets.only(bottom: 32.0),
                controller: controller,
                onChanged: onChanged,
                textAlign: textAlign!,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    color: inputTextColor ?? Colors.black87),
                maxLines: maxLines!,
                obscureText: obscureText!,
                textCapitalization: textCapitalization,
                decoration: inputDecoration ??
                    InputDecoration(
                      isDense: true,
                      hintText: hint,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isError ? Colors.red : Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: isError ? Colors.red : Colors.grey,
                      )),
                      prefixIcon: prefixButton == null ? null : prefixButton!,
                      suffixIcon: suffixButton == null ? null : suffixButton!,
                    ),
              )
            ],
          ),
        );
      } else {
        return Padding(
          padding: horizontalLabelPadding ?? const EdgeInsets.only(right: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  label!,
                  style: vertAndHorHeadTxtTS ??
                      TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  readOnly: readOnly!,
                  scrollPadding: const EdgeInsets.only(bottom: 32.0),
                  controller: controller,
                  onChanged: onChanged,
                  textAlign: textAlign!,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: inputTextColor ?? Colors.black87),
                  maxLines: maxLines!,
                  obscureText: obscureText!,
                  textCapitalization: textCapitalization,
                  decoration: inputDecoration ??
                      InputDecoration(
                        isDense: true,
                        hintText: hint,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        prefixIcon: prefixButton == null ? null : prefixButton!,
                        suffixIcon: suffixButton == null ? null : suffixButton!,
                      ),
                ),
              )
            ],
          ),
        );
      }
    }
  }
}
