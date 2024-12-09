import 'package:flutter/material.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'colors.dart';

class Constant {
  static const APPBAR_TITLE_NAME = "Receptionist App";

//-----------Assets----------------------------//
  static const loginbg = 'assets/images/bg.png';
  static const partner = 'assets/images/partner.png';
  static const emailIcon = 'assets/images/ic_message.png';
  static const callIcon = 'assets/images/ic_calling.png';
  static const locationIcon = 'assets/images/ic_services_address.png';
  static const personIcon = 'assets/images/ic_profile2.png';
  static const calendarIcon = 'assets/images/ic_calendar.png';
  static const whatsappIcon = 'assets/images/whatsapp.png';
  static const loginPwdIcon = 'assets/images/Icon feather-lock.png';
  static const threeDot = 'assets/images/dots.png';
  static const profileIcon = 'assets/images/profile.png';
  static const notificationIcon = 'assets/images/notification.png';
  static const vendorsIcon = 'assets/images/vendors.png';
  static const visitsIcon = 'assets/images/visits.png';
  static const order_readyIcon = 'assets/images/order_ready.png';
  static const backArrow = 'assets/images/back.png';
  static const arrow = 'assets/images/arrow.png';
  static const app_Logo = 'assets/images/app_logo.jpeg';
  static const plusIcon = 'assets/images/add.png';
  static const cross = 'assets/images/cross.png';
  static const crossCir = 'assets/images/cross_cir.png';
  static const dropDownArrow = 'assets/images/down.png';
  static const btnGradient = 'assets/images/button_gradient.png';
  static const calenderWatch = 'assets/images/calender_watch.png';
  static const addVisitCalendar = 'assets/images/Add_visit.png';
  static const filter = 'assets/images/filter.png';
  static const kyc_notify = 'assets/images/kyc_notify.png';
  static const order_ready_notify = 'assets/images/order_ready_notify.png';
  static const upload_notify = 'assets/images/upload_notify.png';
  static const lock_img = 'assets/images/lock_img.png';
  static const menu_bar = 'assets/images/menu_bar.png';
  static const chevron_up = 'assets/images/chevron_up.png';
  static const resechedule = 'assets/images/resechedule.png';
  static const my_notes = 'assets/images/my_notes.png';
  static const logo_fos_cap = 'assets/images/logo_fos_cap.png';
  static const kyc_doc = 'assets/images/document.png';
  static const fos = 'assets/images/Fos.png';
  static const delete = 'assets/images/delete.png';
  static const edit = 'assets/images/edit.png';
  static const assigned_to = 'assets/images/assigned_to.png';
  static const products = 'assets/images/products.png';
  static const reports = 'assets/images/reports.png';
  static const filter_icon = 'assets/images/filter_icon.png';
  static const reminder_toNotifi = 'assets/images/reminder.png';
  static const rescheduleVisit_toNotifi = 'assets/images/RescheduleVisit.png';
  static const vendor_assigned_toNotifi = 'assets/images/vendor_assigned.png';
  static const orders_toNotifi = 'assets/images/oders.png';
  static const qc_toNotifi = 'assets/images/oders.png';
  static const kyc_rej_notify = 'assets/images/kyc_rej_notify.png';
  static const quality_check_noti = 'assets/images/quality_check_noti.png';
  static const vendor_registered_toNotifi =
      'assets/images/vendor_registered.png';
  static const task_accepted = 'assets/images/task_accepted.png';
  static const task_rejected = 'assets/images/task_reject.png';
  static const visit_completed = 'assets/images/visit_completed.png';
  static const qc_drawer = 'assets/images/quality_check.png';

  //Please add your admin panel url here and make sure you do not add '/' at the end of the url

  static const String baseUrl =
      "https://admin.bansalhospital.health.helloyubo.com";

  static const String databaseUrl = "$baseUrl/api/";

  //Please add here your default country code
  static const String yourCountryCode = 'IN';

  static const int limitOfAPIData = 10;
  static const int limitOfStyle1 = 3;
  static const int limitOfStyle6 = 50;
  static const int limitOfAllOtherStyle = 20;

  //Facebook Login enable/disable
  static const bool fblogInEnabled = false;

  //set value for survey show after news data
  static const int surveyShow = 4;

  //set value for native ads show after news data
  static const int nativeAdsIndex = 3;

  //set value for interstitial ads show after news data
  static const int interstitialAdsIndex = 3;

  //set value for reward ads show after news data
  static const int rewardAdsIndex = 4;

  static const String appName = 'TechNest';
  static const String packageName = 'com.yu.technest';
  static const String androidLink =
      'https://play.google.com/store/apps/details?id=';
  static const String androidLbl = 'Android:';
  static const String iosLbl = 'iOS:';
  static const String iosPackage = 'com.yu.technest';
  static const String iosLink = ''; //your ios link here
  static const String appStoreId = '9876543120';

  static const String deepLinkUrlPrefix =
      'https://technest.page.link'; //example - https://xxx.page.link only - Your dynamic link from Firebase
  static const String deeplinkURL = 'https://technest.yugasa.org';

//-----------Widgets---------------------------//
  static Widget kycHeadTxt(String? txt) =>
      Text(txt!, style: Constant.kycHeadTxtTS);

  static Widget head1Txt(String? txt) =>
      Text(txt!, style: Constant.kycHead1TxtTS.copyWith(fontSize: 14.5));

  static Widget qcHeadTxt(String? txt) =>
      Text(txt!, style: Constant.qcHeadTxtTS);

  static Widget dropDownTFIconWidget({double? fontsize, Color? color}) => Icon(
        Icons.keyboard_arrow_down_rounded,
        color: color ?? AppColors.PRIMARY_LIGHT,
        size: fontsize ?? 22,
      );

//TextStyle
  static dashCountTS(
          [double? fontSize, FontWeight? fontWeight, Color? color]) =>
      TextStyle(
          fontSize: fontSize ?? 15,
          fontWeight: fontWeight ?? FontWeight.bold,
          color: color ?? AppColors.PRIMARY_COLOR);

  //TextStyle
  static textfieldLabelTS(
          [double? fontSize, FontWeight? fontWeight, Color? color]) =>
      TextStyle(
          fontSize: fontSize ?? 14.5,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? AppTheme.nearlyBlack);

  static const kycHeadTxtTS = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xff243844));
  static const kycHead1TxtTS = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.nearlyBlack);

  static final qcHeadTxtTS = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.PRIMARY_Medium_LIGHT);

  static const appBarTitleTS =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600);

  static orderReadyForInspection() => TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w700,
      color: AppColors.PRIMARY_Medium_LIGHT);

  static final cartTfTxtStyle = TextStyle(
    color: AppColors.LIGHT_BLACK,
    fontSize: 14.6,
    fontFamily: 'HelveticaNeueLTStd',
    fontWeight: FontWeight.w400,
  );
  static appbar_title_ts([double? fontSize, FontWeight? fontWeight]) =>
      TextStyle(
        color: AppTheme.nearlyBlack,
      );
}
