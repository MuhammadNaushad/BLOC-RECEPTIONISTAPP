import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/widgets/appBar.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/screens/patients_management/widgets/patients_searchbar.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';

import '../../utils/utilities.dart';
import 'controllers/patients_management_cntler.dart';
import 'widgets/patient_list_main.dart';

class PatientManagement extends GetView<PatientManagementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(viewType: 'Patients Management'),
      body: SafeArea(
          child: RefreshIndicator(
        color: AppColors.PRIMARY_COLOR,
        onRefresh: controller.onRefresh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: Column(children: [
            // PatientSearchBar(),
            Obx(
              () => !PatientManagementController.isDataNotFound.value
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                        child: Text(
                          "Swipe left for more actions",
                          style: TextStyle(
                              color: AppColors.LIGHT_BLACK.withOpacity(0.8)),
                        ),
                      ))
                  : SizedBox.shrink(),
            ),
            /* Expanded(
              child: PatientsListMain(
                data: PatientManagementController.patientsList!,
                hasMore: false,
                hasMoreFetchError: false,
              ),
            ) */
          ]),
        ),
      )),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Icon(
            Icons.add,
            color: AppTheme.nearlyWhite,
          ),
          onPressed: () async {
            await Utilities.delay(100);
            AddPatientController.patientID = "";
            final result = await Get.toNamed(Routes.AddPatient)!;
            if (result != null) {
              await controller.getPatientListData();
            }
          }),
    );
  }
}
