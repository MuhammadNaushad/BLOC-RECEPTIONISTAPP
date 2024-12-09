import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';

import '../controllers/edit_appointment_cntler.dart';
import 'appointment_status_dropD.dart';
import 'date_widget.dart';
import 'slots_dropD.dart';
import 'token_status_dropD.dart';

class EditAppointmentForm extends GetView<EditAppointmentController>
    with CommonWidget {
  const EditAppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: controller.formKey,
          child: GetBuilder<EditAppointmentController>(builder: (cntler) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateWidget(),
                  13.height,
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 3.0),
                    child: Text(
                      "Slots *",
                      style: AppTheme.title,
                    ),
                  ),
                  SlotsDropDown(),
                  13.height,
                  RoundedTextField(
                    readOnly: true,
                    controller: controller.priceCtrler,
                    hintText: "Amount *",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    /* validator: (val) {
                        if (controller.fNameCtrler.text.isEmpty) {
                          return "Please enter price";
                        } else {
                          return null;
                        }
                      }, */
                  ),
                  13.height,
                  AppointmentStatusDropDown(),
                  13.height,
                  TokenStatusDropDown(
                    appointmmentId: 0,
                  ),
                ]);
          }),
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {super.key,
      required this.controller,
      this.hintText = "",
      this.maxLines,
      this.inputFormatters,
      this.validator,
      this.onTap,
      this.readOnly = false,
      this.enabled = true,
      this.keyboardType});

  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool? readOnly;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            hintText!,
            style: AppTheme.title,
          ),
        ),
        5.height,
        Container(
          child: TextFormField(
              controller: controller,
              enabled: this.enabled,
              keyboardType: this.keyboardType,
              maxLines: maxLines ?? 1,
              inputFormatters: this.inputFormatters,
              style: AppTheme.captionText(
                fontSize: 14.3,
              ),
              onTap: onTap,
              readOnly: this.readOnly!,
              decoration: InputDecoration(
                isDense: true,
                /*  label: Text(
                hintText!,
                style: AppTheme.caption,
              ), */
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.lightText,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: AppColors.PRIMARY_LIGHT,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: AppColors.PRIMARY_COLOR,
                    )),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
              validator: validator),
        ),
      ],
    );
  }
}
