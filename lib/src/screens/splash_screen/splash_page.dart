import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/splash_screen/cubit/splash_cubit.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'controllers/controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().navigateUser();
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(SplashScreenController());
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        //statusBarColor: Colors.transparent,
        /*         systemNavigationBarColor: AppColors.PRIMARY_COLOR,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark */

        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Container(
        child: Container(
          height: Get.height,
          width: Get.width,
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              Constant.app_Logo,
              fit: BoxFit.cover,
            ),
          ),
          decoration: BoxDecoration(color: AppColors.WHITE),
        ),
      ),
    );
  }
}
