import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class MyDrawer extends StatelessWidget {
  static var isShowFeedMenu = false.obs;
  static Widget _drawer(BuildContext context) {
    final List<String> titleArray = [
      "Profile",
      "Items",
      "Purchase Request",
      "Quotations",
      "Purchase Orders",
      "Invoices",
      "Logout",
    ];
    final List<String> iconsArry = [
      'home.png',
      'my_visit.png',
      'products.png',
      'my_profile.png',
      'feedback.png',
      'logout.png',
      'logout.png',
    ];
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: Get.height * 1.1,
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: Get.height * .15),
                        Stack(
                          children: [
                            /* Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 10, 10, 10.0),
                              child: Text(
                                'FOS',
                                style: Constant.dashCountTS(
                                  40,
                                  FontWeight.w900,
                                  AppColors.PRIMARY_COLOR,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 0,
                              child: Text(
                                'Fleet On Street',
                                style: Constant.dashCountTS(
                                  10.5,
                                  FontWeight.w600,
                                  AppColors.PRIMARY_LIGHT,
                                ),
                              ),
                            ), */
                          ],
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 1,
                          width: Get.width * .65,
                          color: AppColors.PRIMARY_Medium_LIGHT,
                        ),
                        SizedBox(height: 30),
                        for (var i = 0; i < titleArray.length; i++)
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 100));
                                switch (titleArray[i]) {
                                  case "Home":
                                    {
                                      Get.back();
                                    }
                                    break;
                                  case "My Visits":
                                    {
                                      Get.back();
                                      //Get.toNamed(Routes.UpcomingVisits);
                                    }
                                    break;
                                  case "Products":
                                    {
                                      Get.back();
                                      //Get.toNamed(Routes.ProductListScreen);
                                    }
                                    break;
                                  case "My Profile":
                                    {
                                      Get.back();
                                      // Get.toNamed(Routes.MyProfile);
                                    }
                                    break;
                                  case "Feedback":
                                    {
                                      Get.back();
                                      // Get.toNamed(Routes.Feedback);
                                    }
                                    break;

                                  default:
                                    {
                                      Get.back();
                                      Alerts.showLogOutAlertDialog(context);
                                    }
                                    break;
                                }
                              },
                              child: Ink(
                                child: Obx(
                                  () => Container(
                                    height: isShowFeedMenu.value &&
                                            titleArray[i] == 'Feedback'
                                        ? Get.height * .19
                                        : Get.height * .065,
                                    margin: const EdgeInsets.fromLTRB(
                                        18, 16.0, 0, 10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                height: 22.0,
                                                width: 22.0,
                                                child: Image.asset(
                                                  "assets/images/${iconsArry[i]}",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(width: 15.0),
                                              Text(
                                                "${titleArray[i]}",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.PRIMARY_LIGHT,
                                                    fontSize: 14.6,
                                                    fontFamily: 'Raleway',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          isShowFeedMenu.value &&
                                                  titleArray[i] == 'Feedback'
                                              ? Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      00, 0, 0.0, 5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          style: TextButton.styleFrom(
                                                              minimumSize: Size(
                                                                  50.0, 30.0),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                          onPressed: () async {
                                                            Utilities.showToast(
                                                                message:
                                                                    'coming soon');
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                Icons.circle,
                                                                size: 10,
                                                                color: AppColors
                                                                    .PRIMARY_LIGHT,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Rating Given",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .PRIMARY_LIGHT,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          )),
                                                      TextButton(
                                                          style: TextButton.styleFrom(
                                                              minimumSize: Size(
                                                                  50.0, 30.0),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0)),
                                                          onPressed: () async {
                                                            Utilities.showToast(
                                                                message:
                                                                    'coming soon');
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                Icons.circle,
                                                                size: 10,
                                                                color: AppColors
                                                                    .PRIMARY_LIGHT,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Rating Received",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .PRIMARY_LIGHT,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                right: 0.0,
                child: TextButton(
                  onPressed: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * .15, Get.height * .055),
                      padding: const EdgeInsets.all(0)),
                  child: Image.asset(
                    Constant.arrow,
                    height: Get.height * .042,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _drawer(context);
  }
}
