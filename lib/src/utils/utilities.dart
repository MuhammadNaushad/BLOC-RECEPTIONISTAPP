import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/pdf_utilities.dart';
import 'package:yslcrm/src/utils/preferences.dart';

import 'alerts.dart';
import 'colors.dart';

class Utilities {
  //Dynamic height
  static final double _fullHeight = Get.height;
  static double get fullHeight => _fullHeight;

  //Dynamic width
  static final double _fullWidth = Get.width;
  static double get fullWidth => _fullWidth;

//Internet checking
  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

//No Internet
  static void noInternet() {
    BotToast.showText(
      text: 'Please check your internet connection.',
      borderRadius: BorderRadius.all(Radius.circular(25)),
    );
  }

//Toast
  static void showToast({required String? message}) {
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
    /* BotToast.showText(
      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      text: message!,
      backgroundColor: Colors.transparent,
      contentColor: Colors.black.withOpacity(0.7),
      textStyle:
          TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Raleway'),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ); */
  }

  //Circular progress
  static final SimpleFontelicoProgressDialog _dialog =
      SimpleFontelicoProgressDialog(
          context: Get.context!, barrierDimisable: true);
  static void showDialog(BuildContext context, [bool? isDismissibl]) async {
    _dialog.show(
      width: Utilities.fullWidth * .78,
      height: Utilities.fullHeight * .093,
      message: 'Please wait...',
      horizontal: true,
      indicatorColor: AppColors.PRIMARY_COLOR,
      separation: 20,
      textStyle: TextStyle(
          fontFamily: AppTheme.fontName,
          color: AppTheme.nearlyBlack,
          fontSize: 15.0,
          fontWeight: FontWeight.w500),
    );
  }

  static Future<void> hideDialog() async {
    _dialog.hide();
  }

  void foo() {}
  static bool emailValid(TextEditingController tf) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(tf.text);

  //ImageContainer
  static Widget imageView(
      {required double? height,
      required String? imgName,
      bool borderRadius = false}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: borderRadius
              ? BorderRadius.only(
                  topRight: Radius.circular(0.0),
                  bottomRight: Radius.circular(22.0),
                  topLeft: Radius.circular(0.0),
                  bottomLeft: Radius.circular(22.0))
              : BorderRadius.only(
                  topRight: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(0.0),
                  bottomLeft: Radius.circular(0.0)),
          image: DecorationImage(
            image: AssetImage('$imgName'),
            fit: BoxFit.fitWidth,
          )),
      height: height ?? Utilities.fullHeight * .05,
      width: Utilities.fullWidth,
    );
  }

  static Future<void> logOut() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!, false);
        String token = await Preferences.getString(Preferences.login_token);
        final result = await HttpHelper.executeGet(HttpHelper.logout, token);
        await Utilities.hideDialog();
        debugPrint(result.toString());
        if (result["status"] == 1) {
          await Preferences.putString(Preferences.login_token, "");
          await Preferences.putString(Preferences.login_avtar, "");
          Get.offNamedUntil(Routes.LOGIN, (route) => false);
          Utilities.showToast(
              message: (result["message"] ?? "Logged Out Successfully"));
        } else {
          await Utilities.hideDialog();
          if (result["message"] == "Unauthenticated.") {
            Utilities.showToast(
                message: result["message"] ??
                    "Session expired!, Please login again.");
            Alerts.showOneBtnDialog();
          } else {
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
        }
      } catch (e) {
        print(e.toString());
        await Utilities.hideDialog();
        await Preferences.putString(Preferences.login_token, "");
        await Preferences.putString(Preferences.login_avtar, "");
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
        Utilities.showToast(message: ("Logged Out Successfully"));
      }
    }
  }
  //ReadMoreReadLess Text
  /* static Widget readMoreText({@required String txt, @required int trimLines}) =>
      ReadMoreText(
        txt,
        trimLines: trimLines ?? 1,
        colorClickableText: AppColors.PRIMARY_COLOR,
        trimMode: TrimMode.Line,
        style: Constant.bookDetailsFourIconTxtTS(13.5),
        lessStyle:
            Constant.bookDetailsFourIconTxtTS(13.5, AppColors.PRIMARY_COLOR),
        trimCollapsedText: 'read more',
        trimExpandedText: 'read less',
        moreStyle:
            Constant.bookDetailsFourIconTxtTS(13.5, AppColors.PRIMARY_COLOR),
      ); */

  static Future<void> handleControllers() async {}

//Device info
  /* static Future<Map<String, dynamic>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final Map<String, dynamic> deviceData = Map<String, dynamic>();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    deviceData['app_version'] = packageInfo.version;
    if (Platform.isAndroid) {
      var android = await deviceInfo.androidInfo;
      deviceData['device_type'] = 'A';
      deviceData['device_token'] = android.androidId;
      deviceData['device_name'] = android.model;
      deviceData['device_manufacturer'] = android.manufacturer;
      deviceData['device_id'] = android.androidId;
      deviceData['brand'] = android.brand;
      deviceData['device_version'] = android.version.codename;
      deviceData['android_version'] = android.version.release;
      deviceData['android_version_type'] = android.version.sdkInt;
      deviceData['version'] = android.id;
    } else if (Platform.isIOS) {
      var ios = await deviceInfo.iosInfo;
      deviceData['device_type'] = 'I';
      deviceData['device_token'] = ios.identifierForVendor;
      deviceData['device_name'] = ios.model;
      deviceData['device_manufacturer'] = "Apple";
      deviceData['device_id'] = ios.identifierForVendor;
      deviceData['brand'] = 'Apple';
      deviceData['device_version'] = ios.systemVersion;
    } else {
      return null;
    }
    return deviceData;
  } */

//GoogleSignIn Stuff
  /* static GoogleSignIn _googleSignIn = GoogleSignIn();


  //REvoke Api Method
  static Future<void> revoke(
      {@required String deviceTokenId, @required String revokeId}) async {
    if (await Utilities.isOnline()) {
      try {
        await NetworkController.initConnectivity();
        Utilities.showDialog(Get.context, false);
        dynamic jsonObject = {
          "revoke_id": revokeId,
          "device_token": deviceTokenId
        };
        HttpHelper httpHelper = new HttpHelper();
        final result =
            await httpHelper.executePost(jsonObject, HttpHelper.revoke);
        await Utilities.hideDialog();
        print(result);
        if (result["status"]) {
          Alerts.showOtpDialog('',
              deviceTokenId: deviceTokenId, revokeId: revokeId);
        } else {
          await Utilities.hideDialog();
          Utilities.showToast(
              message:
                  (result["msg"] ?? "Unable to process, Please try again."));
        }
      } catch (e) {
        await Utilities.hideDialog();
        Utilities.showToast(message: e.toString());
      }
    }
  }

  static Future<void> revokeCheck(
      {@required String deviceTokenId,
      @required String revokeId,
      String otp}) async {
    if (await Utilities.isOnline()) {
      try {
        await NetworkController.initConnectivity();
        Utilities.showDialog(Get.context, false);
        dynamic jsonObject = {
          "revoke_id": revokeId,
          "device_token": deviceTokenId,
          'otp_code': otp
        };
        HttpHelper httpHelper = new HttpHelper();
        final result =
            await httpHelper.executePost(jsonObject, HttpHelper.revokeCheck);
        await Utilities.hideDialog();
        print(result);
        if (result["status"]) {
          Get.back(closeOverlays: true);
          Utilities.showToast(
              message: (result["msg"] ?? "Logged Out,Successfully"));
        } else {
          Utilities.showToast(
              message:
                  (result["msg"] ?? "Unable to process, Please try again."));
        }
      } catch (e) {
        await Utilities.hideDialog();
        print(e);
      }
    }
  } */

//Convert date to
  static String getDate(String date) {
    final finalDate = date.split(' ');
    print(finalDate);
    final dateFormate = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(finalDate.first.toString()));
    return dateFormate;
  }

  static String getHTML(String tag) {
    final string = Bidi.stripHtmlIfNeeded(tag);
    return string;
  }

  /* static void shareWhatsApp(String text) async {
    try {
      var number = await Preferences.getString('PurchaseBook');
      if (number.isEmpty || number == null) {
        number = '918080253148';
      }
      await launch("https://wa.me/$number?text=$text");
    } catch (e) {
      print(e);
    }
  } */

//For delay
  static Future<dynamic> delay([int? duration = 100]) async {
    return await Future.delayed(Duration(milliseconds: duration!));
  }

  List<String> makeBase64ImageString(List<dynamic> imageList) {
    var list = <String>[];
    for (var item in imageList) {
      List<int> firstBytes = File(item.url!).readAsBytesSync();
      String base64First = base64Encode(firstBytes);
      list.add(base64First);
    }
    return list;
  }

  static String makeBase64singleImageString(String imagePath) {
    final List<int> firstBytes = File(imagePath).readAsBytesSync();
    final String base64First = base64Encode(firstBytes);
    return base64First;
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  /* Future<File> downloadFileFromUrl(String url, {String? filename}) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/" + filename!);
    print(dir.path);
    File urlFile = await file.writeAsBytes(bytes);
    return urlFile;
    //another method
    /* Utilities.showDialog(Get.context!);
                var imageId = await ImageDownloader.downloadImage(url);
                var path = await ImageDownloader.findPath(imageId!);
                Utilities.hideDialog();
                files.add(File(path!));
                for (var element in files) {
                  final CroppedFile file = CroppedFile(element.path);
                  imgList.insert(0, 2);
                  croppedFileList.insert(0, file);
                } */
  } */
  //Get current date and time
  static Map<String, String> getCurrentDateAndTime(
      String actualDate, String actualTime) {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyyy-MM-dd');
    var formatterTime = DateFormat.jm();
    actualDate = formatterDate.format(now);
    actualTime = formatterTime.format(now);
    final map = {'date': actualDate, 'time': actualTime};
    return map;
  }

  static String getShortDate(String date) {
    return DateFormat("MMM d").format(DateTime.parse(date));
  }

  static Map<String, String> convertStringToDateAndTime(String date) {
    var dateFormate = DateFormat("yyyy-MM-dd");
    var actualDate = dateFormate.format(DateTime.parse(date));
    // Conversion logic starts here
    final timeFormate = DateFormat('h:mm a');
    final stringFormat = timeFormate.format(DateTime.parse(date));
    print(stringFormat);
    var actualTime = stringFormat.toString();
    final Map<String, String> map = {'date': actualDate, 'time': actualTime};
    return map;
  }

  ///----Move to specific widget with Index---///
  static Widget moveTospecificWidget(
          {required int index,
          required Widget child,
          required AutoScrollController cntler}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: cntler,
        index: index,
        child: child,
      );

//Date Picker
  DateTime currentDate = DateTime.now();
  Future<String> selectDate(BuildContext context,
      {required String? tfcntler, bool pastDates = false}) async {
    if (tfcntler!.isNotEmpty) {
      String dateString = tfcntler;
      // currentDate = DateTime.parse(dateString);
      print(currentDate);
    }
    print(pastDates);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: pastDates ? DateTime(2010) : DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      currentDate = pickedDate;
    final formatterDate = DateFormat('yyyy-MM-dd');
    tfcntler = formatterDate.format(currentDate);

    print(tfcntler);
    return tfcntler;
  }

  ///Get current date
  static String getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    debugPrint("Current Date: $formattedDate");
    return formattedDate;
  }

  ///------------------Currency formatter -----------------------------///
  static CurrencyFormat euroSettings({dynamic amount, String? symbol}) =>
      CurrencyFormat(
        symbol: symbol ?? '₹',
        symbolSide: SymbolSide.left,
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolSeparator: ' ',
      );
  static String formateCurrency({dynamic amount, String? symbol}) {
    return CurrencyFormatter.format(amount, euroSettings(symbol: symbol),
        enforceDecimals: true);
  }

  //Calling Feature
  static Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await launchUrl(_phoneUri)) await launchUrl(_phoneUri);
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  ///Launch WhatsApp
  Future<void> launchWhatsapp(context,
      {required String mobileNo,
      required String msg,
      required String receiptNo}) async {
    debugPrint("Mobile No: ${mobileNo}");
    debugPrint("Receipt Name: ${msg}");
    final whatsappNo = "91$mobileNo";
    // var whatsappAndroid =
    //     Uri.parse("whatsapp://send?phone=$whatsapp&text=${msg.trim()}");
    try {
      // var url = "whatsapp://send?phone=$mobileNo&file=$msg";

      await PDFUtilities().downloadFile(
          url: msg, filename: "${receiptNo}", mobileNo: whatsappNo);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong, Please try again"),
        ),
      );
    }
  }
}
