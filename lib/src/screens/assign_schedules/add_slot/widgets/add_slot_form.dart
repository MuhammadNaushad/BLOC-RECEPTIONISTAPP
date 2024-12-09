import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/assign_schedules/add_slot/controllers/add_slot_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class AddSlotForm extends GetView<AddSlotController> with CommonWidget {
  const AddSlotForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: controller.formKey,
          child: GetBuilder<AddSlotController>(builder: (cntler) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedTextField(
                    controller: controller.dNameCtrler,
                    hintText: "Doctor Name *",
                    keyboardType: TextInputType.name,
                    enabled: false,
                    validator: (val) {
                      if (controller.dNameCtrler.text.isEmpty) {
                        return "Please enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.height,
                  if (AddSlotController.slotID.isEmpty)
                    IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: RoundedTextField(
                              controller: controller.slotStartCtrler,
                              readOnly: true,
                              hintText: "Slot Start Time *",
                              onTap: () async {
                                await controller
                                    .selectFullTime(controller.slotStartCtrler);
                              },
                              /*  constraints: const BoxConstraints(
                                  maxHeight: 60, minHeight: 60), */
                              enabled: AddSlotController.slotID.isNotEmpty
                                  ? false
                                  : true,
                              keyboardType: TextInputType.text,
                              hint: "10:30 AM",
                              validator: (val) {
                                if (controller.slotStartCtrler.text.isEmpty) {
                                  return "Enter start time";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: RoundedTextField(
                              controller: controller.slotEndCtrler,
                              readOnly: true,
                              hintText: "Slot End Time *",
                              /* constraints: const BoxConstraints(
                                  maxHeight: 60, minHeight: 60), */
                              onTap: () async {
                                if (controller.slotStartCtrler.text.isEmpty) {
                                  Utilities.showToast(
                                      message:
                                          "Please select start time first");
                                } else {
                                  await controller.selectShortTimeForEndTime(
                                      controller.slotStartCtrler);
                                }
                              },
                              enabled: AddSlotController.slotID.isNotEmpty
                                  ? false
                                  : true,
                              keyboardType: TextInputType.text,
                              hint: "2:30 PM",
                              validator: (val) {
                                if (controller.slotEndCtrler.text.isEmpty) {
                                  return "Enter end time";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    RoundedTextField(
                      controller: controller.slotCtrler,
                      hintText: "Slot *",
                      keyboardType: TextInputType.name,
                      enabled: false,
                    ),
                  10.height,
                  RoundedTextField(
                    controller: controller.noOfTokensCtrler,
                    hintText: "No. Of Tokens *",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: (val) {
                      if (controller.noOfTokensCtrler.text.isEmpty ||
                          controller.noOfTokensCtrler.text.length < 1) {
                        return "Please enter no. of tokens";
                      } else {
                        return null;
                      }
                    },
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
      this.hintText,
      this.maxLines,
      this.inputFormatters,
      this.validator,
      this.enabled,
      this.onTap,
      this.readOnly = false,
      this.hint,
      this.decoration,
      this.constraints,
      this.keyboardType});

  final TextEditingController? controller;
  final String? hintText;
  final String? hint;
  final bool? enabled;
  final bool? readOnly;

  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final InputDecoration? decoration;
  final BoxConstraints? constraints;

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
              enabled: enabled ?? true,
              readOnly: this.readOnly!,
              controller: controller,
              keyboardType: this.keyboardType,
              maxLines: maxLines ?? 1,
              inputFormatters: this.inputFormatters,
              style: AppTheme.captionText(
                fontSize: 14.3,
              ),
              onTap: this.onTap,
              decoration: this.decoration ??
                  InputDecoration(
                    constraints: this.constraints,
                    isDense: true,
                    hintText: hint ?? "",
                    hintStyle: AppTheme.caption,
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                  ),
              validator: validator),
        ),
      ],
    );
  }
}
