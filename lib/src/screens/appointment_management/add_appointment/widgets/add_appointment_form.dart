import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/widgets/doctor_dropD.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/widgets/slots_dropD.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';

import '../controllers/add_appointment_cntler.dart';
import 'active_inactive_radio.dart';
import 'date_widget.dart';
import 'gender_radio_btn.dart';
import 'patients_dropD.dart';
import 'paymentmode_dropD.dart';

class AddAppointmentForm extends GetView<AddAppointmentController>
    with CommonWidget {
  const AddAppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: controller.formKey,
          child: GetBuilder<AddAppointmentController>(builder: (cntler) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.patientIdToPost.isEmpty)
                    RoundedTextField(
                      controller: controller.phoneCtrler,
                      enabled: controller.isShowSearchBtn,
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
                  if (AddAppointmentController.patientID.isEmpty &&
                      controller.isShowSearchBtn) ...[
                    10.height,
                    Align(
                      alignment: Alignment.center,
                      child: AppButton(
                        onTap: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (controller.formKey.currentState!.validate()) {
                            await controller.checkPatient(
                                phone_no: controller.phoneCtrler.text);
                          }
                        },
                        textColor: Colors.white,
                        text: "Search",
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.WHITE),
                        color: AppColors.PRIMARY_COLOR,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50))),
                      ),
                    ),
                  ],
                  //AddUser View
                  if (AddAppointmentController.patientID.isEmpty &&
                      controller.isShowUserView) ...[
                    10.height,
                    RoundedTextField(
                      controller: controller.fNameCtrler,
                      hintText: "User Name *",
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
                      controller: controller.ageCtrler,
                      hintText: "User Age *",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (val) {
                        if (controller.fNameCtrler.text.isEmpty) {
                          return "Please enter age";
                        } else {
                          return null;
                        }
                      },
                    ),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        "Gender *",
                        style: AppTheme.title,
                      ),
                    ),
                    GenderWidget(),
                    10.height,
                    RoundedTextField(
                      controller: controller.addressCtrler,
                      hintText: "User Address *",
                      maxLines: 2,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (controller.fNameCtrler.text.isEmpty) {
                          return "Please enter address";
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
                  ],

                  ///Add Patient View
                  if (controller.isShowPatientView) ...[
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 3.0),
                      child: Text(
                        "Patient *",
                        style: AppTheme.title,
                      ),
                    ),
                    PatientsDropDown(),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 3.0),
                      child: Text(
                        "Doctor *",
                        style: AppTheme.title,
                      ),
                    ),
                    DoctorDropDown(),
                    10.height,
                    DateWidget(),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 3.0),
                      child: Text(
                        "Slots *",
                        style: AppTheme.title,
                      ),
                    ),
                    SlotsDropDown(),
                    10.height,
                    RoundedTextField(
                      controller: controller.priceCtrler,
                      hintText: "Price *",
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
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 3.0),
                      child: Text(
                        "Payment Mode *",
                        style: AppTheme.title,
                      ),
                    ),
                    PaymentModeDropDown(),
                    /* 10.height,
                    RoundedTextField(
                      controller: controller.receiptNoCtrler,
                      hintText: "Receipt No. *",
                      keyboardType: TextInputType.name,
                      enabled: controller.isPaymentTFEnable,
                      validator: controller.isPaymentTFEnable
                          ? (val) {
                              if (controller.receiptNoCtrler.text.isEmpty) {
                                return "Please enter receipt no.";
                              } else {
                                return null;
                              }
                            }
                          : null,
                    ), */
                    30.height,
                  ],

                  ///Update Patient View
                  if (AddAppointmentController.patientID.isNotEmpty) ...[
                    10.height,
                    RoundedTextField(
                      controller: controller.fNameCtrler,
                      hintText: "Recipt No. *",
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (controller.fNameCtrler.text.isEmpty) {
                          return "Please enter recipt no.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    10.height,
                    RoundedTextField(
                      controller: controller.userCtrler,
                      hintText: "User",
                      keyboardType: TextInputType.name,
                      /* validator: (val) {
                        if (controller.fNameCtrler.text.isEmpty) {
                          return "Please enter user";
                        } else {
                          return null;
                        }
                      }, */
                    ),
                    10.height,
                    RoundedTextField(
                      controller: controller.ageCtrler,
                      hintText: "Age *",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (val) {
                        if (controller.fNameCtrler.text.isEmpty) {
                          return "Please enter age";
                        } else {
                          return null;
                        }
                      },
                    ),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        "Gender *",
                        style: AppTheme.title,
                      ),
                    ),
                    GenderWidget(),
                  ]
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
