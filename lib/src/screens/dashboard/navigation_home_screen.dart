import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/widgets/custom_drawer/drawer_user_controller.dart';
import 'package:yslcrm/src/screens/appointment_management/appointment_management.dart';
import 'package:yslcrm/src/screens/appointment_management/controllers/appointment_management_cntler.dart';
import 'package:yslcrm/src/screens/assign_schedules/add_slot/controllers/add_slot_cntler.dart';
import 'package:yslcrm/src/screens/assign_schedules/assign_schedule.dart';
import 'package:yslcrm/src/screens/assign_schedules/controllers/assign_schedule_cntler.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/controllers/add_doctor_cntler.dart';
import 'package:yslcrm/src/screens/doctors_management/controllers/doctors_management_cntler.dart';
import 'package:yslcrm/src/screens/doctors_management/doctor_manage.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import 'package:yslcrm/src/screens/patients_management/controllers/patients_management_cntler.dart';
import 'package:yslcrm/src/screens/dashboard/controllers/dashboard_cntler.dart';
import 'package:yslcrm/src/screens/profile/controllers/my_profile_cntler.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import '../../common/widgets/custom_drawer/home_drawer.dart';
import '../patients_management/patients_management.dart';
import 'home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          Get.delete<MyProfileController>(force: true);
          Get.delete<PatientManagementController>(force: true);
          Get.delete<AddPatientController>(force: true);
          Get.delete<AssignScheduleController>(force: true);
          Get.delete<AddSlotController>(force: true);
          Get.delete<DoctorManageController>(force: true);
          Get.delete<AddDoctorController>(force: true);
          Get.delete<AppointmentManagementController>(force: true);

          Get.put(DashboardController());

          setState(() {
            screenView = const MyHomePage();
          });

          break;
        /*  case DrawerIndex.Profile:
          /*  Get.delete<DashboardController>(force: true);
          Get.delete<PatientManagementController>(force: true);
          Get.delete<AddPatientController>(force: true);

          Get.put(MyProfileController());
           */
          setState(() {});
          break; */
        /* case DrawerIndex.Doctor:
          Get.delete<MyProfileController>(force: true);
          Get.delete<DashboardController>(force: true);
          Get.delete<PatientManagementController>(force: true);
          Get.delete<AddPatientController>(force: true);
          Get.delete<AssignScheduleController>(force: true);
          Get.delete<AddSlotController>(force: true);
          Get.delete<DoctorManageController>(force: true);
          Get.delete<AddDoctorController>(force: true);
          Get.delete<AppointmentManagementController>(force: true);
          Get.put(DoctorManageController());
          setState(() {
            screenView = DoctorManage(isDoctorManagementView: true);
          });
          break; */
        case DrawerIndex.Patient:
          Get.delete<MyProfileController>(force: true);
          Get.delete<DashboardController>(force: true);
          Get.delete<AssignScheduleController>(force: true);
          Get.delete<AddSlotController>(force: true);
          Get.delete<DoctorManageController>(force: true);
          Get.delete<AddDoctorController>(force: true);
          Get.delete<AppointmentManagementController>(force: true);
          Get.put(PatientManagementController());
          setState(() {
            screenView = PatientManagement();
          });
          break;

        case DrawerIndex.Appointment:
          Get.delete<MyProfileController>(force: true);
          Get.delete<DashboardController>(force: true);
          Get.delete<PatientManagementController>(force: true);
          Get.delete<AddPatientController>(force: true);
          Get.delete<DoctorManageController>(force: true);
          Get.delete<AddDoctorController>(force: true);
          Get.put(AppointmentManagementController());
          setState(() {
            screenView = AppointmentManagement();
          });
          setState(() {});
          break;
        case DrawerIndex.AssignSchedule:
          Get.delete<MyProfileController>(force: true);
          Get.delete<DashboardController>(force: true);
          Get.delete<PatientManagementController>(force: true);
          Get.delete<AddPatientController>(force: true);
          Get.delete<DoctorManageController>(force: true);
          Get.delete<AddDoctorController>(force: true);
          Get.delete<AppointmentManagementController>(force: true);
          Get.put(DoctorManageController());
          setState(() {
            screenView = DoctorManage(isDoctorManagementView: false);
          });
          break;

        default:
          break;
      }
    }
  }
}
