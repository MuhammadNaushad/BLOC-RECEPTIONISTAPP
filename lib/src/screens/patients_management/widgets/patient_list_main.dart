import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/models/patients_management/get_all_patients_model.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/cubit/add_patient_cubit.dart';
import 'package:yslcrm/src/screens/patients_management/cubit/patient_cubit.dart';
import 'package:yslcrm/src/screens/patients_management/cubit/searchbar_cubit.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../add_patients/controllers/add_patients_cntler.dart';
import 'patient_listview.dart';

class PatientsListMain extends StatelessWidget {
  final List<PatientData> data;
  final bool hasMore;
  final bool hasMoreFetchError;
  final AnimationController animationController;
  final ScrollController pController;
  final String page;

  PatientsListMain(
      {required this.data,
      required this.hasMore,
      required this.hasMoreFetchError,
      required this.animationController,
      required this.page,
      required this.pController});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context.read<PatientSearchBarCubit>().showHideCrossBtn(false);
              return context.read<PatientCubit>().getPatient(page: "1");
            },
            child: ListView.builder(
                controller: pController,
                itemCount: data.isNotEmpty ? data.length : 0,
                padding: EdgeInsets.only(top: 8, bottom: Get.height * 0.1),
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final int count = data.length > 10 ? 10 : data.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          Expanded(
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: () async {
                                  await Utilities.delay(200);
                                  try {
                                    final patient = data[index];
                                    AddPatientController.patientID =
                                        patient.id.toString();
                                    final Map<String, String> patientData = {
                                      "user_name":
                                          patient.user!.name.toString(),
                                      "patient_name": patient.name.toString(),
                                      "age": patient.age.toString(),
                                      "gender": patient.gender.toString(),
                                    };
                                    final param = {
                                      "patient_id": patient.id.toString()
                                    };

                                    debugPrint(patientData.toString());
                                    final result = await Get.toNamed(
                                        Routes.AddPatient,
                                        parameters: patientData,
                                        arguments: param)!;
                                    if (result != null) {
                                      await context
                                          .read<PatientCubit>()
                                          .getPatient(page: "1");
                                    }
                                  } catch (e) {
                                    debugPrint(e.toString());
                                    Utilities.showToast(
                                        message: "Something went wrong");
                                  }
                                },
                                child: Ink(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 15, top: 12),
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF21B7CA),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.6),
                                          offset: const Offset(2.5, 2.5),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit, color: Colors.white),
                                        5.height,
                                        Text(
                                          "Edit",
                                          style: AppTheme.title
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /*  SlidableAction(
                                        padding: EdgeInsets.all(20),
                                        borderRadius: BorderRadius.circular(10),
                                        onPressed: (_) async {
                                          try {
                                            final patient =
                                                PatientManagementController
                                                    .patientsList![index];
                                            AddPatientController.patientID =
                                                patient.id.toString();
                                            final Map<String, String>
                                                patientData = {
                                              "user_name":
                                                  patient.user!.name.toString(),
                                              "patient_name":
                                                  patient.name.toString(),
                                              "age": patient.age.toString(),
                                              "gender": patient.gender.toString(),
                                            };
                                            debugPrint(patientData.toString());
                                            final result = await Get.toNamed(
                                                Routes.AddPatient,
                                                parameters: patientData)!;
                                            if (result != null) {
                                              await controller
                                                  .getPatientListData();
                                            }
                                          } catch (e) {
                                            debugPrint(e.toString());
                                            Utilities.showToast(
                                                message: "Something went wrong");
                                          }
                                        },
                                        backgroundColor: Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      ), */
                          SizedBox(
                            width: 10,
                          ),
                          /* SlidableAction(
                                        borderRadius: BorderRadius.circular(10),
                                        backgroundColor: HexColor("#FA7D82"),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        onPressed: (BuildContext context) {
                                          showConfirmDialogCustom(
                                            Get.context!,
                                            primaryColor: AppColors.PRIMARY_COLOR,
                                            title: 'Delete',
                                            subTitle:
                                                'Are you sure you want to delete?',
                                            onAccept: (_) async {
                                              await controller.deletePatient(
                                                patient_id:
                                                    PatientManagementController
                                                        .patientsList![index].id
                                                        .toString(),
                                              );
                                            },
                                          );
                                        },
                                      ), */
                          /*  Expanded(
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () async {
                                              await Utilities.delay(200);
                                              showConfirmDialogCustom(
                                                Get.context!,
                                                primaryColor:
                                                    AppColors.PRIMARY_COLOR,
                                                title: 'Delete',
                                                subTitle:
                                                    'Are you sure you want to delete?',
                                                onAccept: (_) async {
                                                  await controller.deletePatient(
                                                    patient_id:
                                                        PatientManagementController
                                                            .patientsList![index]
                                                            .id
                                                            .toString(),
                                                  );
                                                },
                                              );
                                            },
                                            child: Ink(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 15, top: 12),
                                                height: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: HexColor("#FA7D82"),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.6),
                                                      offset:
                                                          const Offset(2.5, 2.5),
                                                      blurRadius: 3,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.delete,
                                                        color: Colors.white),
                                                    5.height,
                                                    Text(
                                                      "Delete",
                                                      style: AppTheme.title
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                   */
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PatientListView(
                            callback: () {},
                            data: data[index],
                            animation: animation,
                            animationController: animationController,
                          ),

                          // when the _loadMore function is running
                          if (index != 0 &&
                              index == data.length - 1 &&
                              data.length > 9)
                            hasMore
                                ? hasMoreFetchError
                                    ? Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8.0),
                                          child: IconButton(
                                              onPressed: () {
                                                context
                                                    .read<PatientCubit>()
                                                    .getMorePatients(context,
                                                        page: page);
                                              },
                                              icon: Icon(Icons.error,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                : SizedBox.shrink()
                        ],
                      ));
                }),
          ),
        ),
      ],
    );
  }
}
