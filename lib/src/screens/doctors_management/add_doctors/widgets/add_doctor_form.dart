import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/controllers/add_doctor_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';

import 'active_inactive_radio.dart';
import 'gender_radio_btn.dart';

class AddDoctorForm extends GetView<AddDoctorController> with CommonWidget {
  const AddDoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: controller.formKey,
          child: GetBuilder<AddDoctorController>(builder: (cntler) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedTextField(
                    controller: controller.fNameCtrler,
                    hintText: "Name *",
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (controller.fNameCtrler.text.isEmpty) {
                        return "Please enter full name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.height,
                  RoundedTextField(
                    controller: controller.emailCtrler,
                    hintText: "Email *",
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (controller.emailCtrler.text.isEmpty ||
                          !controller.emailCtrler.text.isEmail) {
                        return "Please enter valid email id";
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.height,
                  RoundedTextField(
                    controller: controller.phoneCtrler,
                    hintText: "Mobile Number *",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: (val) {
                      if (controller.phoneCtrler.text.isEmpty ||
                          controller.phoneCtrler.text.length < 10) {
                        return "Please enter 10 digit mobile no.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.height,
                  Obx(
                    () => RoundedTextField(
                      controller: controller.pwdCtrler,
                      hintText: "Password *",
                      keyboardType: TextInputType.name,
                      obscureText: controller.obscureText.value,
                      /*  validator: (val) {
                        if (controller.pwdCtrler.text.isEmpty ||
                            controller.pwdCtrler.text.length < 8) {
                          return "Password must be atleast of 8 characters";
                        } else {
                          return null;
                        }
                      }, */
                      suffixWidget: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 100));
                            controller.obscureText.value =
                                !controller.obscureText.value;
                          },
                          child: Ink(
                            child: new Icon(
                              controller.obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      "Gender",
                      style: AppTheme.title,
                    ),
                  ),
                  GenderWidget(),
                  10.height,
                  RoundedTextField(
                    controller: controller.newConsultationFeeCtrler,
                    hintText: "New Consultation Fees*",
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    ],
                    validator: (val) {
                      if (controller.newConsultationFeeCtrler.text.isEmpty) {
                        return "Please enter new consultation fees";
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.height,
                  RoundedTextField(
                    controller: controller.followUpConsultationFeeCtrler,
                    hintText: "FollowUp Consultation Fees*",
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    ],
                    validator: (val) {
                      if (controller
                          .followUpConsultationFeeCtrler.text.isEmpty) {
                        return "Please enter follow up consultation fees";
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      "Status ",
                      style: AppTheme.title,
                    ),
                  ),
                  ActiveInactiveWidget(),
                  10.height,
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
      this.hintText,
      this.maxLines,
      this.inputFormatters,
      this.validator,
      this.suffixWidget,
      this.obscureText = false,
      this.keyboardType});

  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final bool? obscureText;

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
        TextFormField(
            controller: controller,
            keyboardType: this.keyboardType,
            maxLines: maxLines ?? 1,
            inputFormatters: this.inputFormatters,
            style: AppTheme.captionText(
              fontSize: 14.3,
            ),
            obscureText: this.obscureText!,
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
                suffixIcon: suffixWidget),
            validator: validator),
      ],
    );
  }
}
