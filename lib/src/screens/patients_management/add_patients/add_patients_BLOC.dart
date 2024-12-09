import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/cubit/add_patient_cubit.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import '../../../common/ui/common.dart';
import '../../../common/widgets/appBar.dart';
import 'controllers/add_patients_cntler.dart';
import 'widgets/add_patient_form.dart';

class AddPatientBLOC extends StatefulWidget {
  @override
  State<AddPatientBLOC> createState() => _AddPatientBLOCState();
}

class _AddPatientBLOCState extends State<AddPatientBLOC> {
  String patientID = "";
  bool showBttomBtn = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    //Fetching Params
    if (Get.arguments != null) {
      patientID = Get.arguments["patient_id"];
      log("patientID :: $patientID");
      /* if (patientID.isNotEmpty && patientID != "0") {
        showBttomBtn = context.read<AddPatientCubit>().setState(patientID);
      } */
    }
  }

  @override
  void deactivate() {
    context.read<AddPatientCubit>().setInit();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            viewType:
                patientID.isNotEmpty ? 'Update Patient' : 'Add New Patient'),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddPatientForm(
                  patientID: this.patientID,
                  formKey: this.formKey,
                )
              ],
            ),
          ),
        )),
        bottomNavigationBar: BlocBuilder<AddPatientCubit, AddPatientState>(
          builder: (context, state) {
            return context.read<AddPatientCubit>().setState(
                    (state is AddPatientDataSuccess) ? "1" : patientID)
                ? Container(
                    decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: CommonWidget.commonButton(
                          text: patientID.isNotEmpty && patientID != "0"
                              ? 'Update'
                              : 'Submit',
                          onPressed: () async {
                            await Future.delayed(Duration(milliseconds: 100));
                            FocusManager.instance.primaryFocus?.unfocus();
                            submit();
                            /* if (controller.formKey.currentState!.validate()) {
                            if (controller.isShowPatientView &&
                                controller.userIdToPost.isNotEmpty) {
                              await controller.addPatient();
                            } else if (!controller.isShowPatientView &&
                                patientID.isNotEmpty) {
                              await controller.updatePatient();
                            } else {
                              await controller.addUser();
                            }
                          } */
                          }),
                    ),
                  )
                : SizedBox.shrink();
          },
        )
        /*   GetBuilder<AddPatientController>(builder: (controller) {
        return !controller.isShowSearchBtn
            ? Container(
                decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0.0),
                      topLeft: Radius.circular(0.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: GetBuilder<AddPatientController>(builder: (cntler) {
                    return CommonWidget.commonButton(
                        text: controller.patientIdToPost.isNotEmpty &&
                                controller.patientIdToPost != "0"
                            ? 'Update'
                            : 'Submit',
                        onPressed: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.isShowPatientView &&
                                controller.userIdToPost.isNotEmpty) {
                              await controller.addPatient();
                            } else if (!controller.isShowPatientView &&
                                patientID.isNotEmpty) {
                              await controller.updatePatient();
                            } else {
                              await controller.addUser();
                            }
                          }
                        });
                  }),
                ),
              )
            : SizedBox.shrink();
      }), */
        );
  }

  void submit() {
    if (formKey.currentState!.validate()) {}
  }
}
