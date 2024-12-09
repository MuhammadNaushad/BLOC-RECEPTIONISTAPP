import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/colors.dart';

import 'preferences.dart';
import 'utilities.dart';

class Alerts with CommonWidget {
//show log out alert for login
  static void showOneBtnDialog(
      {String title = 'Alert',
      String contenTStr = 'Session is expired, Please login again',
      bool dissmissable = false,
      Widget? content}) {
    TextButton _textButton(
            {required String text, required Function()? onPressed}) =>
        TextButton(
          child: Text(text,
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.PRIMARY_COLOR,
                  fontWeight: FontWeight.w600)),
          onPressed: onPressed,
        );
    // set up the button
    Widget okButton = _textButton(
        text: 'OK',
        onPressed: () async {
          Get.back();
          await Preferences.putString(Preferences.login_token, "");
          await Preferences.putString(Preferences.login_avtar, "");
          Get.offNamedUntil(Routes.LOGIN, (route) => false);
          //await Utilities.logOut();
        });
    Get.defaultDialog(
        title: title,
        middleText: contenTStr,
        backgroundColor: Colors.white,
        barrierDismissible: dissmissable,
        content: content,
        radius: 8,
        titlePadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        confirm: okButton);
  }

  static void openOneBtnDialog({
    String? title,
    Widget? content,
    bool dissmissable = false,
  }) {
    TextButton _textButton(
            {required String text, required Function()? onPressed}) =>
        TextButton(
          child: Text(text,
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.SEC_COLOR,
                  fontWeight: FontWeight.w600)),
          onPressed: onPressed,
        );
    Widget okButton = _textButton(
        text: 'OK',
        onPressed: () async {
          Get.back();
        });
    Get.dialog(
        AlertDialog(
            title: Text(title!,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: AppColors.PRIMARY_COLOR),
                textAlign: TextAlign.center),
            content: content,
            actions: [okButton],
            actionsAlignment: MainAxisAlignment.center),
        barrierDismissible: dissmissable);
  }

//show general alert dialog
  static void showAlertDialog(
      {required String title,
      Widget? content,
      Function()? onYes,
      String? yesbtnTitle,
      String? contentTitle,
      String? nobtnTitle,
      bool isActionBtn = true}) {
    TextButton _textButton(
            {required String text, required Function()? onPressed}) =>
        TextButton(
          child: Text(text,
              style: TextStyle(
                  color: AppColors.SEC_COLOR, fontWeight: FontWeight.w600)),
          onPressed: onPressed,
        );
    // set up the button
    Widget okButton = _textButton(text: yesbtnTitle ?? 'Yes', onPressed: onYes);
    Widget cancelButton = _textButton(
        text: nobtnTitle ?? 'No',
        onPressed: () {
          Get.back();
        });
    Get.dialog(AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center),
      content: content ??
          Text(contentTitle.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
              )),
      actions: [
        isActionBtn
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  okButton,
                  cancelButton,
                ],
              )
            : SizedBox.shrink(),
      ],
    ));
  }

  /* //show log out alert for google login
  static void showLogOutAlertDialogForGoogleLogin(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      splashColor: Colors.grey,
      child: Text(
        "OK",
        style: TextStyle(color: AppColors.SEC_COLOR),
      ),
      onPressed: () {
        // _loginController.signOutGoogle();
        /*  Navigator.push(
            context, CupertinoPageRoute(builder: (context) => MyApp())); */
      },
    );
    Widget cancelButton = FlatButton(
      splashColor: Colors.grey,
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("Log Out"),
      content: Text("Are you sure to log out?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } */

  //show log out alert for login
  static void showLogOutAlertDialog(BuildContext context) {
    /* TextButton _textButton(
            {required String text, required Function()? onPressed}) =>
        TextButton(
          child: Text(text,
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  //fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600)),
          onPressed: onPressed,
        );
    //set up the button
    Widget okButton = _textButton(
        text: 'Yes',
        onPressed: () async {
          Get.back();
          //Get.offNamedUntil(Routes.LOGIN, (route) => false);
          await Utilities.logOut();
        });
    Widget cancelButton = _textButton(
        text: 'No',
        onPressed: () {
          Get.back();
        });

    Get.dialog(AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text('Log Out',
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center),
      content: Text('Are you sure to log out?',
          textAlign: TextAlign.center, style: TextStyle()),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            okButton,
            cancelButton,
          ],
        ),
      ],
    )); */
    showConfirmDialogCustom(
      context,
      primaryColor: AppColors.PRIMARY_COLOR,
      title: 'Are you sure to log out?',
      onAccept: (_) async {
        print(await Preferences.getString(Preferences.login_token));

        await Utilities.logOut();
      },
    );
  }

//show log out alert for login
  static void showDeletImgDialog(
      {required Function() onYes,
      String title = 'Delete',
      String contenTStr = 'Are you sure you want to delete?'}) {
    TextButton _textButton(
            {required String text, required Function()? onPressed}) =>
        TextButton(
          child: Text(text,
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w600,
              )),
          onPressed: onPressed,
        );
    // set up the button
    Widget okButton = _textButton(text: 'Yes', onPressed: onYes);
    Widget cancelButton = _textButton(
        text: 'No',
        onPressed: () {
          Get.back();
        });

    /* Get.dialog(AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center),
      content:
          Text(contenTStr, textAlign: TextAlign.center, style: TextStyle()),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            okButton,
            cancelButton,
          ],
        ),
      ],
    )); */

    showConfirmDialogCustom(
      Get.context!,
      primaryColor: AppColors.PRIMARY_COLOR,
      title: contenTStr,
      onAccept: (_) async {
        onYes();
      },
    );
  }

  //Exit widget
  static Future<bool> exitWidget(BuildContext context) async {
    /* showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                title: Text("Alert",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                content: Text(
                  "Are you sure you want to exit?",
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          "YES",
                          style: TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "NO",
                          style: TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox.shrink();
        }); */
    showConfirmDialogCustom(
      context,
      primaryColor: AppColors.PRIMARY_COLOR,
      title: 'Are you sure you want to exit?',
      onAccept: (_) async {
        SystemNavigator.pop();
      },
    );
    return false;
  }

  //Alert like bottom sheet
  static void showBottomSheet({required Widget widget}) async {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Padding(
          padding: MediaQuery.of(Get.context!).viewInsets,
          child: Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  widget,
                  Positioned(
                      top: 0,
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          icon: Icon(Icons.cancel),
                          color: Colors.white,
                          iconSize: Get.height * .05,
                          onPressed: () async {
                            Future.delayed(Duration(milliseconds: 400));
                            Get.back();
                          },
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

/* //show showVendorNameInputDialog
  void showVendorNameInputDialog(
      {required AddVisitController controller,
      required Function() onYes,
      required Function() onCancel,
      bool barrierDismissible = true}) async {
    await controller.getAnonymousVendorsData();
    // set up the button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, Get.height * .06),
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          foregroundColor: AppColors.PRIMARY_COLOR),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              Constant.btnGradient,
            ),
            height: Get.height * .06,
            width: double.infinity,
            fit: BoxFit.fill,
            child: InkWell(onTap: onYes),
          ),
          Text(
            'Submit',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.PRIMARY_COLOR),
          ),
        ],
      ),
      onPressed: onYes,
    );
    Widget cancelButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, Get.height * .06),
            backgroundColor: AppColors.WHITE,
            side: BorderSide(
              width: 1.0,
              color: AppColors.PRIMARY_COLOR,
            ),
            elevation: 0.0,
            foregroundColor: AppColors.PRIMARY_COLOR),
        child: Text(
          'Cancel',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.PRIMARY_COLOR),
        ),
        onPressed: onCancel);

    Get.dialog(
        AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text('New Vendor',
              style:
                  TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Please enter vendor details',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Raleway')),
                SizedBox(
                  height: 15.0,
                ),
                controller.anonymousVNameList.length > 0
                    ? GetBuilder<AddVisitController>(
                        builder: (contrler) => Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 2.0),
                            child: DropdownSearch<String>(
                              dropdownBuilder: searchDropDownStyle1,
                              dropdownButtonProps: DropdownButtonProps(
                                  icon: Constant.dropDownTFIconWidget()),
                              popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  itemBuilder: searchDropDownStyle2,
                                  searchFieldProps: TextFieldProps(
                                      decoration:
                                          searchDropdwnInputDecoration())),
                              items: controller.anonymousVNameList,
                              selectedItem:
                                  controller.anonVendorNameCtrler.text,
                              onChanged: (value) {
                                print(value);
                                controller.anonymousVType = "anonymous_vendor";
                                controller.searchAVendorDetailsById(value!,
                                    cntler: controller);
                                controller.update();
                              },
                            )))
                    : SizedBox.shrink(),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avNameCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Name",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avEmailCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Email",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avMobileCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.number,
                  hint: "Mobile No.",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avAddress1Ctrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Address1",
                  maxLines: 2,
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avAddress2Ctrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Address2",
                  maxLines: 2,
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avCityCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "City",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avStateCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "State",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avCountryCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Country",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avPostcodeCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.number,
                  hint: "Postcode",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(6)
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: okButton),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: cancelButton),
                ],
              ),
            ),
          ],
        ),
        barrierDismissible: barrierDismissible);
  }

//show showVendorNameInputDialog
  void showSupervisorVendorNameInputDialog(
      {required AddVisitSController controller,
      required Function() onYes,
      required Function() onCancel,
      bool barrierDismissible = true}) async {
    await controller.getAnonymousVendorsData();
    // set up the button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, Get.height * .06),
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          foregroundColor: AppColors.PRIMARY_COLOR),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              Constant.btnGradient,
            ),
            height: Get.height * .06,
            width: double.infinity,
            fit: BoxFit.fill,
            child: InkWell(onTap: onYes),
          ),
          Text(
            'Submit',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.PRIMARY_COLOR),
          ),
        ],
      ),
      onPressed: onYes,
    );
    Widget cancelButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, Get.height * .06),
            backgroundColor: AppColors.WHITE,
            side: BorderSide(
              width: 1.0,
              color: AppColors.PRIMARY_COLOR,
            ),
            elevation: 0.0,
            foregroundColor: AppColors.PRIMARY_COLOR),
        child: Text(
          'Cancel',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.PRIMARY_COLOR),
        ),
        onPressed: onCancel);

    Get.dialog(
        AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text('New Vendor',
              style:
                  TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Please enter vendor details',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Raleway')),
                SizedBox(
                  height: 15.0,
                ),
                controller.anonymousVNameList.length > 0
                    ? GetBuilder<AddVisitSController>(
                        builder: (controller) => DropdownSearch<String>(
                          dropdownBuilder: searchDropDownStyle1,
                          dropdownButtonProps: DropdownButtonProps(
                              icon: Constant.dropDownTFIconWidget()),
                          popupProps: PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                              itemBuilder: searchDropDownStyle2,
                              searchFieldProps: TextFieldProps(
                                  decoration: searchDropdwnInputDecoration())),
                          items: controller.anonymousVNameList,
                          selectedItem: controller.anonVendorNameCtrler.text,
                          onChanged: (value) {
                            print(value);
                            controller.anonymousVType = "anonymous_vendor";
                            controller.searchAVendorDetailsById(value!);
                            controller.update();
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avNameCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Name",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avEmailCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Email",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avMobileCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.number,
                  hint: "Mobile No.",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avAddress1Ctrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Address1",
                  maxLines: 2,
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avAddress2Ctrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Address2",
                  maxLines: 2,
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avCityCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "City",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avStateCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "State",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avCountryCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.text,
                  hint: "Country",
                ),
                SizedBox(
                  height: 6.0,
                ),
                PrimaryTextField(
                  controller: controller.avPostcodeCtrler,
                  borderedTf: true,
                  keyboardType: TextInputType.number,
                  hint: "Postcode",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(6)
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: okButton),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: cancelButton),
                ],
              ),
            ),
          ],
        ),
        barrierDismissible: barrierDismissible);
  }

  //show showVendorNameInputDialog
  static void showVisitReasonInputDialog(
      {required Function() onYes,
      required Function() onCancel,
      required AddVisitController controller}) {
    // set up the button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, Get.height * .06),
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          foregroundColor: AppColors.PRIMARY_COLOR),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              Constant.btnGradient,
            ),
            height: Get.height * .06,
            width: double.infinity,
            fit: BoxFit.fill,
            child: InkWell(onTap: onYes),
          ),
          Text(
            'OK',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.PRIMARY_COLOR),
          ),
        ],
      ),
      onPressed: onYes,
    );
    Widget cancelButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, Get.height * .06),
            backgroundColor: AppColors.WHITE,
            side: BorderSide(
              width: 1.0,
              color: AppColors.PRIMARY_COLOR,
            ),
            elevation: 0.0,
            foregroundColor: AppColors.PRIMARY_COLOR),
        child: Text(
          'Cancel',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.PRIMARY_COLOR),
        ),
        onPressed: onCancel);

    Get.dialog(AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text('Reason Of Visit',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600),
          textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please enter reason of visit',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Raleway')),
            SizedBox(
              height: 15.0,
            ),
            PrimaryTextField(
              controller: controller.avReasonOfVisitCtrler,
              borderedTf: true,
              keyboardType: TextInputType.text,
              maxLines: 3,
              hint: "Enter reason of visit",
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: okButton),
              SizedBox(
                width: 20,
              ),
              Expanded(child: cancelButton),
            ],
          ),
        ),
      ],
    ));
  }

  //Dialog For Supervisor Other Reason Input
  static void showVisitReasonInputDialogSuper(
      {required Function() onYes,
      required Function() onCancel,
      required AddVisitSController controller}) {
    // set up the button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, Get.height * .06),
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          foregroundColor: AppColors.PRIMARY_COLOR),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(
              Constant.btnGradient,
            ),
            height: Get.height * .06,
            width: double.infinity,
            fit: BoxFit.fill,
            child: InkWell(onTap: onYes),
          ),
          Text(
            'OK',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.PRIMARY_COLOR),
          ),
        ],
      ),
      onPressed: onYes,
    );
    Widget cancelButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, Get.height * .06),
            backgroundColor: AppColors.WHITE,
            side: BorderSide(
              width: 1.0,
              color: AppColors.PRIMARY_COLOR,
            ),
            elevation: 0.0,
            foregroundColor: AppColors.PRIMARY_COLOR),
        child: Text(
          'Cancel',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.PRIMARY_COLOR),
        ),
        onPressed: onCancel);

    Get.dialog(AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text('Reason Of Visit',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600),
          textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please enter reason of visit',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Raleway')),
            SizedBox(
              height: 15.0,
            ),
            PrimaryTextField(
              controller: controller.avReasonOfVisitCtrler,
              borderedTf: true,
              keyboardType: TextInputType.text,
              maxLines: 3,
              hint: "Enter reason of visit",
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: okButton),
              SizedBox(
                width: 20,
              ),
              Expanded(child: cancelButton),
            ],
          ),
        ),
      ],
    ));
  }
   */

  //
  /* static void showForgotPwdDialog(BuildContext context) {
    final LoginController _loginController = Get.find();

    Widget _submitBtn() {
      return Container(
          height: Utilities.fullHeight * .06,
          width: Utilities.fullWidth * .25,
          child: new RaisedButton(
              color: AppColors.PRIMARY_COLOR,
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(6.0)),
              onPressed: () async {
                if (_loginController.forgotPwdController.text.isEmpty ||
                    Constant.emailValid(_loginController.forgotPwdController) ==
                        false) {
                  Utilities.showToast(message: 'Please enter valid email');
                } else {
                  FocusScope.of(Get.context).unfocus();
                  await _loginController.forgotPwdOTP(
                      (_loginController.forgotPwdController.text));
                }
              }));
    }

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: FittedBox(
                      child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                        AlertDialog(
                          content: Column(children: [
                            SizedBox(height: Utilities.fullHeight * .07),
                            Text(
                              "Forgot Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.PRIMARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'Raleway'),
                            ),
                            SizedBox(height: Utilities.fullHeight * .07),
                            Container(
                              height: Utilities.fullHeight * .07,
                              child: TextFormField(
                                  controller:
                                      _loginController.forgotPwdController,
                                  style: Constant.loginTextStyle,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                      hintText: 'E-Mail Address',
                                      hintStyle: Constant.hintTextStyle,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      fillColor: Color(0xffE6E7E9),
                                      filled: true)),
                            ),
                            SizedBox(height: 13),
                            _submitBtn(),
                            SizedBox(height: 25)
                          ]),
                        ),
                        Positioned(
                            top: -10,
                            child: Container(
                                height: Utilities.fullHeight * .115,
                                child: Image.asset(
                                  "assets/images/forgeticon.png",
                                  fit: BoxFit.contain,
                                )))
                      ]))));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  } */

  //
  /* static Future<Widget> developerOptionAlert(BuildContext context,
      {String text, String cText}) {
    return Get.dialog(
        AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          titlePadding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          title: Text(
            text,
            style: TextStyle(
                fontFamily: 'HelveticaNeueLTStd',
                fontWeight: FontWeight.w400,
                fontSize: 16.3),
          ),
          content: Text(
            cText,
            style: TextStyle(
                fontFamily: 'HelveticaNeueLTStd',
                fontWeight: FontWeight.w400,
                fontSize: 16.3),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontFamily: 'HelveticaNeueLTStd',
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        barrierDismissible: false);
  } */
}
