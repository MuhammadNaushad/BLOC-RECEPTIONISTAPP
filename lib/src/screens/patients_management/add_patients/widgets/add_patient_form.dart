import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/cubit/add_patient_cubit.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import 'active_inactive_radio.dart';
import 'gender_radio_btn.dart';

class AddPatientForm extends StatefulWidget with CommonWidget {
  final String patientID;
  final GlobalKey<FormState> formKey;

  const AddPatientForm(
      {super.key, required this.patientID, required this.formKey});

  @override
  State<AddPatientForm> createState() => _AddPatientFormState();
}

class _AddPatientFormState extends State<AddPatientForm> {
//AddContacts TF Controllers
  final fNameCtrler = TextEditingController();
  final userCtrler = TextEditingController();
  final ageCtrler = TextEditingController();
  final addressCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();

  var obscureText = true.obs;
  var primaryContact = false.obs;
  static bool loadContacts = false;
  static String patientID = "";
  String patientIdToPost = "";

  //Handling View Stuff
  bool isShowSearchBtn = true;
  bool isShowUserView = false;
  bool isShowPatientView = false;
  int statusToPost = 1;
  String genderToPost = "";
  String userIdToPost = "";

  ///Radio Btn
  Gender genderValue = Gender.male;
  Status statusValue = Status.active;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    patientID = widget.patientID;

    ///checking condition
    if (patientID != "0" && patientID.isNotEmpty) {
      //Assigning Initial Values for update
      patientIdToPost = patientID;
      userCtrler.text = Get.parameters["user_name"]!;
      fNameCtrler.text = Get.parameters["patient_name"]!;
      ageCtrler.text = Get.parameters["age"]!;
      genderToPost = Get.parameters["gender"]!;
      isShowSearchBtn = false;

      //Radio Btn stuff
      if (genderToPost == "Male") {
        genderValue = Gender.male;
      } else if (genderToPost == "Female") {
        genderValue = Gender.female;
      } else {
        genderValue = Gender.other;
      }
      /* if (statusToPost == 1) {
        statusValue = Status.active;
      } else {
        statusValue = Status.inactive;
      } */
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: widget.formKey,
          child: BlocListener<AddPatientCubit, AddPatientState>(
            listener: (context, state) {
              if (state is AddPatientLoading) {
                context.read<AddPatientCubit>().setState("");

                Utilities.showDialog(context);
              } else if (state is AddPatientDataSuccess) {
                /* isShowSearchBtn = false;
                isShowUserView = false;
                isShowPatientView = true; */
                context.read<AddPatientCubit>().setState("1");
                final userObj = state.data;
                debugPrint(userObj.toString());
                debugPrint(userObj.id.toString());
                userIdToPost = userObj.id.toString();
                userCtrler.text = "${userObj.id} - ${userObj.name!}";
                Utilities.hideDialog();
                Utilities.showToast(message: state.msg);
              } else if (state is AddPatientFailure) {
                Utilities.hideDialog();
                Utilities.showToast(message: state.msg);
              }
            },
            child: BlocBuilder<AddPatientCubit, AddPatientState>(
                builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (patientIdToPost.isEmpty)
                      RoundedTextField(
                        controller: phoneCtrler,
                        hintText: "Mobile Number *",
                        readOnly: !isShowSearchBtn,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        validator: (val) {
                          if (phoneCtrler.text.isEmpty ||
                              phoneCtrler.text.length < 10) {
                            return "Please enter 10 digit mobile no.";
                          } else {
                            return null;
                          }
                        },
                      ),

                    if (state is AddPatientLoading)
                      if (state.isShowSearchBtn && patientID.isEmpty) ...[
                        10.height,
                        Align(
                          alignment: Alignment.center,
                          child: AppButton(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 100));
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (widget.formKey.currentState!.validate()) {
                                await context
                                    .read<AddPatientCubit>()
                                    .checkPatient(phone_no: phoneCtrler.text);
                              }
                            },
                            textColor: Colors.white,
                            text: "Search",
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.WHITE),
                            color: AppColors.PRIMARY_COLOR,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(50))),
                          ),
                        ),
                      ],
                    //AddUser View
                    if (state is AddPatientDataSuccess)
                      if ((state).patienID.isEmpty && state.isShowUserView) ...[
                        10.height,
                        RoundedTextField(
                          controller: fNameCtrler,
                          hintText: "User Name *",
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (fNameCtrler.text.isEmpty) {
                              return "Please enter full name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        10.height,
                        RoundedTextField(
                          controller: ageCtrler,
                          hintText: "User Age *",
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (val) {
                            if (fNameCtrler.text.isEmpty) {
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
                          controller: addressCtrler,
                          hintText: "User Address",
                          maxLines: 2,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (fNameCtrler.text.isEmpty) {
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
                    if (state is AddPatientDataSuccess)
                      if (state.isShowPatientView) ...[
                        10.height,
                        RoundedTextField(
                          controller: fNameCtrler,
                          hintText: "Name *",
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (fNameCtrler.text.isEmpty) {
                              return "Please enter full name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        10.height,
                        RoundedTextField(
                          controller: userCtrler,
                          hintText: "User",
                          keyboardType: TextInputType.name,
                          readOnly: true,
                          /* validator: (val) {
                                  if (fNameCtrler.text.isEmpty) {
                                    return "Please enter user";
                                  } else {
                                    return null;
                                  }
                                }, */
                        ),
                        10.height,
                        RoundedTextField(
                          controller: ageCtrler,
                          hintText: "Age *",
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (val) {
                            if (fNameCtrler.text.isEmpty) {
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
                      ],

                    ///Update Patient View
                    if (patientID.isNotEmpty) ...[
                      10.height,
                      RoundedTextField(
                        controller: fNameCtrler,
                        hintText: "Name *",
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (fNameCtrler.text.isEmpty) {
                            return "Please enter full name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      10.height,
                      RoundedTextField(
                        controller: userCtrler,
                        hintText: "User",
                        keyboardType: TextInputType.name,
                        readOnly: true,
                        /* validator: (val) {
                                  if (fNameCtrler.text.isEmpty) {
                                    return "Please enter user";
                                  } else {
                                    return null;
                                  }
                                }, */
                      ),
                      10.height,
                      RoundedTextField(
                        controller: ageCtrler,
                        hintText: "Age *",
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        validator: (val) {
                          if (fNameCtrler.text.isEmpty) {
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
      ),
    );
  }

  Future<void> validateForSubmitBtn() async {
    if (widget.formKey.currentState!.validate()) {
      if (isShowPatientView && userIdToPost.isNotEmpty) {
        // await addPatient();
      } else if (!isShowPatientView && patientID.isNotEmpty) {
        // await updatePatient();
      } else {
        // await addUser();
      }
    }
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
      this.readOnly = false,
      this.keyboardType});

  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? readOnly;

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
              keyboardType: this.keyboardType,
              maxLines: maxLines ?? 1,
              inputFormatters: this.inputFormatters,
              readOnly: this.readOnly!,
              style: AppTheme.captionText(
                fontSize: 14.3,
              ),
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
