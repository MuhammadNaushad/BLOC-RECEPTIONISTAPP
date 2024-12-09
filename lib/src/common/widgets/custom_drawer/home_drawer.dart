import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/screens/dashboard/controllers/dashboard_cntler.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';
import 'package:yslcrm/src/utils/hex_color.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';
import 'package:yslcrm/src/themes/app_theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  String fullName = "User";
  @override
  void initState() {
    setDrawerListArray();

    super.initState();
  }

  void setDrawerListArray() async {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      /*  DrawerList(
        index: DrawerIndex.Doctor,
        labelName: 'Doctor Management',
        icon: Icon(Icons.person),
      ), */
      DrawerList(
        index: DrawerIndex.Patient,
        labelName: 'Patient Management',
        isAssetsImage: false,
        icon: Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.Appointment,
        labelName: 'Appointment Management',
        icon: Icon(Icons.task_sharp),
      ),
      DrawerList(
        index: DrawerIndex.AssignSchedule,
        labelName: 'Assign Schedule',
        icon: Icon(Icons.schedule_send),
      ),
    ];
  }

  void getFullName() async {
    fullName = "${await Preferences.getString(Preferences.user_first_name)}";
  }

  @override
  Widget build(BuildContext context) {
    getFullName();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: /* Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset(Constant.profileIcon),
                            ),
                          ), */
                              DashboardController.profilePic.value == ''
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(60.0)),
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          /* boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: AppTheme.grey
                                                    .withOpacity(0.6),
                                                offset: const Offset(2.0, 4.0),
                                                blurRadius: 1),
                                          ], */
                                          image: DecorationImage(
                                              image: AssetImage(
                                                Constant.profileIcon,
                                              ),
                                              fit: BoxFit.fill),
                                        ),
                                        /* child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(60.0)),
                                          child: Image.asset(
                                            Constant.profileIcon,
                                            height: 120,
                                            width: 120,
                                          ), */
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          DashboardController.profilePic.value,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          new Image.asset(
                                            Constant.profileIcon,
                                            height: 120,
                                            width: 120,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          new Image.asset(
                                            Constant.profileIcon,
                                            height: 120,
                                            width: 120,
                                          )),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 4),
                    child: Text(
                      fullName.capitalizeFirst!,
                      style: TextStyle(
                        color: AppColors.LIGHT_BLACK,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  onTapped();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void onTapped() async {
    await Utilities.delay(150);
    Alerts.showLogOutAlertDialog(context); // Print to console.
  }

  Widget inkwell(DrawerList listData, {int? index}) {
    print(index);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4.0, 4.0, 4, 4),
                  ),
                  listData.isAssetsImage
                      ? Image.asset(listData.imageName,
                          scale: 1.05,
                          color: widget.screenIndex == listData.index
                              ? AppColors.PRIMARY_COLOR
                              : Colors.black)
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? AppColors.PRIMARY_COLOR
                              : Colors.black),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  /* Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: AppTheme.fontName,
                      fontSize: 17.4,
                      color: widget.screenIndex == listData.index
                          ? AppColors.PRIMARY_COLOR
                          : Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ), */
                  Expanded(
                    child: TextIcon(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppTheme.fontName,
                        fontSize: 17.4,
                        color: widget.screenIndex == listData.index
                            ? AppColors.PRIMARY_COLOR
                            : Colors.black,
                      ),

                      text:
                          "${listData.labelName}", //providerData.email.validate(),
                      expandedText: true,
                      useMarquee: true,
                    ),
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //  MediaQuery.of(context).size.width * 0.75 - 64,//
                            height: 46,
                            decoration: BoxDecoration(
                              //  color: Colors.blue.withOpacity(0.2),
                              color: AppColors.PRIMARY_COLOR.withOpacity(0.25),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
    debugPrint("OnDrawerTapped");
  }
}

enum DrawerIndex {
  HOME,
  // Doctor,
  Patient,
  Appointment,
  AssignSchedule,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
