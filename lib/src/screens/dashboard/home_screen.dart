import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/models/dashboard/homelist.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/doctors_management/doctor_manage.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import 'widgets/grid_view_element.dart';
import 'widgets/meals_list_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*  var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light; */
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return GridView(
                            padding: const EdgeInsets.only(
                                top: 15, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              3,
                              (int index) {
                                final int count = homeList.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController?.forward();
                                return Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () async {
                                      await Utilities.delay(250);
                                      if (index == 0) {
                                        Get.toNamed(Routes.PatientManagement);
                                      } /* else if (index == 1) {
                                        Get.toNamed(Routes.DoctorManagement,
                                            arguments: true);
                                      } */
                                      else if (index == 1) {
                                        Get.toNamed(
                                            Routes.AppointmentManagement,
                                            arguments: false);
                                      } else {
                                        Get.toNamed(Routes.DoctorManagement,
                                            arguments: false);
                                      }
                                    },
                                    child: Ink(
                                      child: DahsboardView(
                                        mealsListData: mealsListData[index],
                                        animation: animation,
                                        animationController:
                                            animationController!,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 12.0,
                              childAspectRatio: 1.6,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    /* var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light; */
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w700,
                ),
              ),

              /*  Container(
                height: 30,
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  Constant.app_Logo,
                  fit: BoxFit.cover,
                  color: AppTheme.dark_grey,
                ),
              ), */
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                color: AppTheme.white,
                child: null),
          ),
        ],
      ),
    );
  }
}
