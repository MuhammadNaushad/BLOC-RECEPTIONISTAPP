import 'package:get/get.dart';
import 'package:yslcrm/src/bindings/bindings.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/add_appointment.dart';
import 'package:yslcrm/src/screens/appointment_management/add_appointment/controllers/add_appointment_cntler.dart';
import 'package:yslcrm/src/screens/appointment_management/appointment_management.dart';
import 'package:yslcrm/src/screens/appointment_management/controllers/appointment_management_cntler.dart';
import 'package:yslcrm/src/screens/appointment_management/edit_appointment/controllers/edit_appointment_cntler.dart';
import 'package:yslcrm/src/screens/appointment_management/edit_appointment/edit_appointment.dart';
import 'package:yslcrm/src/screens/appointment_management/export/controller/export_cntler.dart';
import 'package:yslcrm/src/screens/appointment_management/export/export_page.dart';
import 'package:yslcrm/src/screens/assign_schedules/add_slot/add_slots.dart';
import 'package:yslcrm/src/screens/assign_schedules/add_slot/controllers/add_slot_cntler.dart';
import 'package:yslcrm/src/screens/assign_schedules/assign_schedule.dart';
import 'package:yslcrm/src/screens/assign_schedules/controllers/assign_schedule_cntler.dart';
import 'package:yslcrm/src/screens/dashboard/controllers/dashboard_cntler.dart';
import 'package:yslcrm/src/screens/dashboard/dashboard.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/add_doctor.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/controllers/add_doctor_cntler.dart';
import 'package:yslcrm/src/screens/doctors_management/controllers/doctors_management_cntler.dart';
import 'package:yslcrm/src/screens/doctors_management/doctor_manage.dart';
import 'package:yslcrm/src/screens/login_&_register/login.dart';
import 'package:yslcrm/src/screens/login_&_register/login_bloc.dart';
import 'package:yslcrm/src/screens/notification/notifications.dart';
import 'package:yslcrm/src/screens/patients_management/add_patients/add_patients_BLOC.dart';
import 'package:yslcrm/src/screens/patients_management/patients_m_bloc.dart';
import 'package:yslcrm/src/screens/profile/controllers/my_profile_cntler.dart';
import 'package:yslcrm/src/screens/profile/profile.dart';
import 'package:yslcrm/src/screens/splash_screen/controllers/controller.dart';
import 'package:yslcrm/src/screens/splash_screen/splash_page.dart';

import '../screens/patients_management/add_patients/add_patients.dart';
import '../screens/patients_management/patients_management.dart';
import '../screens/patients_management/add_patients/controllers/add_patients_cntler.dart';
import '../screens/patients_management/controllers/patients_management_cntler.dart';

import '../screens/login_&_register/controllers/forget_pwd_cntler.dart';
import '../screens/login_&_register/forget_pwd_screen.dart';
import '../screens/notification/controllers/notifications_cntler.dart';

part './app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASHSCREEN;
  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => SplashScreen(),
      /* binding:
          BindingsBuilder(() => Get.lazyPut(() => SplashScreenController())), */
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreenBloc(),
      transition: Transition.downToUp,
      // binding: AllControllerBindings(),
    ),
    GetPage(
        name: Routes.ForgotPwd,
        page: () => ForgetPWDScreen(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => ForgetPWDController()))),
    GetPage(
        name: Routes.DASHBOARD,
        page: () => Dashboard(),
        binding: BindingsBuilder(() => Get.put(DashboardController()))),
    GetPage(
        name: Routes.MyProfile,
        page: () => MyProfile(),
        binding: BindingsBuilder.put(() => MyProfileController())),
    GetPage(
        name: Routes.NOTIFICATIONS,
        page: () => NotificationScreen(),
        binding: BindingsBuilder.put(() => NotificationsController())),
    GetPage(
        name: Routes.PatientManagement,
        page: () => PatientManagementBLOC(),
        binding: BindingsBuilder.put(() => PatientManagementController())),
    GetPage(
        name: Routes.AddPatient,
        page: () => AddPatientBLOC(),
        binding: BindingsBuilder.put(() => AddPatientController())),
    GetPage(
        name: Routes.DoctorManagement,
        page: () => DoctorManage(),
        binding: BindingsBuilder.put(() => DoctorManageController())),
    GetPage(
        name: Routes.AddDoctor,
        page: () => AddDoctor(),
        binding: BindingsBuilder.put(() => AddDoctorController())),
    GetPage(
        name: Routes.AssignSlotManagement,
        page: () => AssignSchedule(),
        binding: BindingsBuilder.put(() => AssignScheduleController())),
    GetPage(
        name: Routes.AddSlot,
        page: () => AddSlot(),
        binding: BindingsBuilder.put(() => AddSlotController())),
    GetPage(
        name: Routes.AppointmentManagement,
        page: () => AppointmentManagement(),
        binding: BindingsBuilder.put(() => AppointmentManagementController())),
    GetPage(
        name: Routes.AddAppointment,
        page: () => AddAppointment(),
        binding: BindingsBuilder.put(() => AddAppointmentController())),
    GetPage(
        name: Routes.EditAppointment,
        page: () => EditAppointment(),
        binding: BindingsBuilder.put(() => EditAppointmentController())),
    GetPage(
        name: Routes.ExportAppointment,
        page: () => ExportAppointment(),
        binding: BindingsBuilder.put(() => ExportController())),
  ];
}
