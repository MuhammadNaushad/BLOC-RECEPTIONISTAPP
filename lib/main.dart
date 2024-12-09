import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/data/repositories/auth/auth_repository.dart';
import 'package:yslcrm/src/screens/login_&_register/cubit/login_cubit.dart';
import 'package:yslcrm/src/screens/patients_management/cubit/patient_cubit.dart';
import 'package:yslcrm/src/screens/patients_management/cubit/searchbar_cubit.dart';
import 'package:yslcrm/src/screens/splash_screen/cubit/splash_cubit.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

import 'src/database/hive_init.dart';
import 'src/routes/app_pages.dart';
import 'src/screens/patients_management/add_patients/cubit/add_patient_cubit.dart';
import 'src/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  //await SharedPrefs.init();
  /*  
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler); */
  runApp(bloc.MultiBlocProvider(providers: [
    bloc.BlocProvider(
      create: (context) => SplashCubit(),
    ),
    bloc.BlocProvider(
      create: (_) => LoginCubit(AuthRepository()),
    ),
    bloc.BlocProvider(
      create: (_) => TogglePWDCubit(),
    ),
    bloc.BlocProvider(create: ((_) => PatientCubit())),
    bloc.BlocProvider(create: ((_) => PatientSearchBarCubit())),
    bloc.BlocProvider(
      create: (_) => AddPatientCubit(),
    )
  ], child: MyApp()));
}

/* Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
// Saving notification_type value .
  await prefs.setString(Preferences.notificationType,
      message.data['notification_type'].toString());
  debugPrint(prefs.getString(Preferences.notificationType));
  LocalNotificationService.initialize(); //need to focus
  LocalNotificationService.display(message);
}
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        /*  statusBarColor: AppColors.PRIMARY_COLOR,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark, */
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        /* statusBarBrightness:
            !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light, */
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Receptionist App',
        theme: ThemeData(
          fontFamily: AppTheme.fontName,
          primarySwatch: AppColors.PRIMARY_COLOR,
          useMaterial3: false,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: AppColors.PRIMARY_COLOR),
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.rightToLeft,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()]);
  }
}
