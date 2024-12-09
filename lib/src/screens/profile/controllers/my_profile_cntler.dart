// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/profile/my_profile_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/permission_alert.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../../../models/profile/vendor_category_list_model.dart';

class MyProfileController extends GetxController {
  //Vendor TF Controllers
  static final vendorCodeCtrler = TextEditingController();
  static final companyCtrler = TextEditingController();
  static final vatNoCtrler = TextEditingController();
  static final phoneCtrler = TextEditingController();
  static final websiteCtrler = TextEditingController();
  static final vendorCatCtrler = TextEditingController();
  static final currencyCtrler = TextEditingController();
  static final addressCtrler = TextEditingController();
  static final cityCtrler = TextEditingController();
  static final stateCtrler = TextEditingController();
  static final zipcodeCtrler = TextEditingController();
  static final countryCtrler = TextEditingController();
  static final bankDetailsCtrler = TextEditingController();
  static final paymentTermsCtrler = TextEditingController();
  //Billings TF Controllers
  static final streetBtCtrler = TextEditingController();
  static final cityBCtrler = TextEditingController();
  static final stateBCtrler = TextEditingController();
  static final zipCodeBCtrler = TextEditingController();
  static final CountryBCtrler = TextEditingController();
  //Shippings TF Controllers
  static final streetStCtrler = TextEditingController();
  static final citySCtrler = TextEditingController();
  static final stateSCtrler = TextEditingController();
  static final zipCodeSCtrler = TextEditingController();
  static final CountrySCtrler = TextEditingController();

  static RxBool isAvatarStored = false.obs;
  static RxString storedAvtar = ''.obs;
  static RxString fullName = ''.obs;
  static RxString email = ''.obs;

//Currency Dropdown Stuff
  List<String> currencyList = <String>[];

  //vendorCategoryList Dropdown Stuff
  List<String> vendorCategoryList = <String>[].obs;
  List<String> vendorCatIdList = [];
  List<String> vendorSelectedCatNameList = [];
  List<String> vendorCatIdListtoPost = [];
  ProfileData? profileDataObj;

  @override
  void onReady() async {
    super.onReady();
    await [getProfileData()];
  }

  static Future<void> checkAvatarCondition(String? image) async {
    isAvatarStored.value =
        await Preferences.getString(Preferences.login_avtar) != '';
    if (isAvatarStored.value) {
      storedAvtar.value = await Preferences.getString(Preferences.login_avtar);
    }
  }

  Future<void> getProfileData() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final result = await HttpHelper.executeGet(HttpHelper.profile, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == true) {
          if (result["data"] != null) {
            // final data = result["data"]["profile"];
            //Assigning Values
            final dataT = result["data"]["client"];
            vendorCodeCtrler.text = dataT["vendor_code"] ?? "";
            companyCtrler.text = dataT["company"] ?? "";
            vatNoCtrler.text = dataT["vat"] ?? "";
            phoneCtrler.text = dataT["phonenumber"] ?? "";
            websiteCtrler.text = dataT["website"] ?? "";
            // vendorCatCtrler.text = dataT["category"] ?? [""];
            currencyCtrler.text = dataT["default_currency"] ?? "";
            addressCtrler.text = dataT["address"] ?? "";
            cityCtrler.text = dataT["city"] ?? "";
            stateCtrler.text = dataT["state"] ?? "";
            zipcodeCtrler.text = dataT["zip"] ?? "";
            countryCtrler.text = dataT["country"] ?? "";
            bankDetailsCtrler.text = dataT["bank_detail"] ?? "";
            streetBtCtrler.text = dataT["billing_street"] ?? "";
            cityBCtrler.text = dataT["billing_city"] ?? "";
            stateBCtrler.text = dataT["billing_state"] ?? "";
            zipCodeBCtrler.text = dataT["billing_zip"] ?? "";
            CountryBCtrler.text = dataT["billing_country"] ?? "";
            streetStCtrler.text = dataT["shipping_street"] ?? "";
            citySCtrler.text = dataT["shipping_city"] ?? "";
            stateSCtrler.text = dataT["shipping_state"] ?? "";
            zipCodeSCtrler.text = dataT["shipping_zip"] ?? "";
            CountrySCtrler.text = dataT["shipping_country"] ?? "";
            //CurrencyStuff
            final MyProfileModel profileModelObj =
                MyProfileModel.fromJson(result);
            if (profileModelObj.data != null) {
              profileDataObj = profileModelObj.data;
              if (profileModelObj.data!.currencyList != null &&
                  profileModelObj.data!.currencyList!.isNotEmpty) {
                for (var element in profileModelObj.data!.currencyList!) {
                  debugPrint(element.toString());
                  currencyList.add(element.text.toString());
                }
                //currencyCtrler.text = "--select--";
                debugPrint(currencyList.toString());
              }
              update();
              if (profileModelObj.data!.vendorCategory != null &&
                  profileModelObj.data!.vendorCategory!.isNotEmpty) {
                for (var element in profileModelObj.data!.vendorCategory!) {
                  debugPrint(element.toString());
                  vendorCategoryList.add(element.categoryName.toString());
                  //Matching the Category IDs
                  for (var i = 0;
                      i < profileModelObj.data!.client!.category!.length;
                      i++) {
                    debugPrint(profileModelObj.data!.client!.category![i]);
                    if (element.id ==
                        profileModelObj.data!.client!.category![i]) {
                      debugPrint(profileModelObj.data!.client!.category![i]
                          .toString());
                      vendorCatIdList
                          .add(profileModelObj.data!.client!.category![i]);
                      vendorSelectedCatNameList.add(element.categoryName!);
                      debugPrint(vendorCatIdList.toString());
                      debugPrint(vendorSelectedCatNameList.toString());
                    }
                  }
                }
                vendorCatIdListtoPost = vendorCatIdList;
                debugPrint(vendorCategoryList.toString());
              }
            }

            update();
            /* Preferences.putString(Preferences.user_full_name, result[""]);
            var userFullName =
                await Preferences.getString(Preferences.user_full_name);
            print('User Name : $userFullName'); */
            /* Preferences.putString(Preferences.login_avtar, result['url'] ?? '');
            Preferences.putString(
                Preferences.login_first_name, data['first_name']);
            Preferences.putString(
                Preferences.login_last_name, data['last_name']);
            Preferences.putString(Preferences.login_email_id, data['email']);
            Preferences.putString(
                Preferences.login_mobile_no, data['phone_number'].toString());
            Preferences.putString(
                Preferences.login_type, data['type'].toString());
            debugPrint(await Preferences.getString(Preferences.login_avtar));
           

            //logic for profile avatar
            if (await Preferences.getString(Preferences.login_avtar) != '') {
              checkAvatarCondition(
                  await Preferences.getString(Preferences.login_avtar));
            } */
            Utilities.showToast(message: result["message"] ?? "status");
          } else {
            Utilities.hideDialog();
            Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          Utilities.hideDialog();
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
      } catch (e, s) {
        debugPrint("$e ${s.toString()}");
        Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> getVendorCategoryData() async {
    if (await Utilities.isOnline()) {
      try {
        // Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final result = await HttpHelper.executeGet(
            HttpHelper.profileVendorCategory, token);
        debugPrint(result.toString());
        // Utilities.hideDialog();
        if (result["status"] == true) {
          if (result["data"] != null) {
            final VendorCategoryNameList data =
                VendorCategoryNameList.fromJson(result);
            if (data.data != null) {
              for (var element in data.data!) {
                vendorCategoryList.add(element.categoryName!);
              }
            }
            vendorCatCtrler.text = vendorCategoryList.first;
            update();
            // Utilities.showToast(message: result["message"] ?? "status");
          } else {
            Utilities.hideDialog();
            Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          // Utilities.hideDialog();
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
        // Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> updateProfile() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "vendor_code": vendorCodeCtrler.text.trim(),
          "company": companyCtrler.text.trim(),
          'vat': vatNoCtrler.text.trim(),
          'phonenumber': phoneCtrler.text.trim(),
          'website': websiteCtrler.text.trim(),
          'category': vendorCatIdListtoPost,
          'default_currency': currencyCtrler.text.trim(),
          "address": addressCtrler.text.trim(),
          "city": cityCtrler.text.trim(),
          "state": stateCtrler.text.trim(),
          "zip": zipcodeCtrler.text.trim(),
          "country": countryCtrler.text.trim(),
          "bank_detail": bankDetailsCtrler.text.trim(),
          "payment_terms": paymentTermsCtrler.text.trim(),
          "billing_street": streetBtCtrler.text.trim(),
          "billing_city": cityBCtrler.text.trim(),
          "billing_state": stateBCtrler.text.trim(),
          "billing_zip": zipCodeBCtrler.text.trim(),
          "billing_country": CountryBCtrler.text.trim(),
          "shipping_street": streetStCtrler.text.trim(),
          "shipping_city": citySCtrler.text.trim(),
          "shipping_state": stateSCtrler.text.trim(),
          "shipping_zip": zipCodeSCtrler.text.trim(),
          "shipping_country": CountrySCtrler.text.trim(),
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePostforJson(
            jsonObject, HttpHelper.updateProfile, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == true) {
          if (result["data"] != null) {
            Utilities.showToast(
                message: result["message"] ?? "Updated Successfully");
          } else {
            Utilities.hideDialog();
            Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          Utilities.hideDialog();
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
        Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

//
  static CroppedFile? croppedFile;

  static Future<void> picPhoto(
      BuildContext? context, ImageSource? source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source!);
    if (pickedFile == null) return;
    final ic = ImageCropper();

    croppedFile =
        await ic.cropImage(sourcePath: pickedFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.PRIMARY_COLOR,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ]);
    final token = await Preferences.getString(Preferences.login_token);
    if (croppedFile != null) {
      try {
        Utilities.showDialog(Get.context!);
        final result = await HttpHelper.postFormData(HttpHelper.updateProfile,
            data: {'file': croppedFile}, token: token);
        debugPrint('$result');
        if (result != null) {
          if (result["status"]) {
            Utilities.hideDialog();
            final data = result['data'];
            await Preferences.putString(
                Preferences.user_id, data['fos_user_id'].toString());
            final String newAvtar = data['url'];
            await Preferences.putString(Preferences.login_avtar, newAvtar);
            final String login_avtar =
                await Preferences.getString(Preferences.login_avtar);
            print(login_avtar);
            if (login_avtar.length > 0) {
              storedAvtar.value = login_avtar;
            }
            Utilities.showToast(
                message: result['message'] ?? "Profile Uploaded Successfully!");
          } else {
            Utilities.hideDialog();
            Utilities.showToast(
                message: result['message'] ??
                    "Unable to update profile, Please try again.");
          }
        } else {
          Utilities.hideDialog();
          Utilities.showToast(message: "Unable to process, Please try again.");
        }
      } catch (e) {
        Utilities.hideDialog();
        debugPrint(e.toString());
      }
    }
  }

  static Future<void> cameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isPermanentlyDenied) {
      PermissionAlert.CameraDeniedForever(Get.context!);
      return;
    }
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (status.isPermanentlyDenied) {
        PermissionAlert.CameraDeniedForever(Get.context!);
        return;
      }
      if (!status.isGranted) {
        PermissionAlert.CameraDenied(Get.context!, () => cameraPermission());
        return;
      }
    }
    picPhoto(Get.context, ImageSource.camera);
  }

  static Future<void> gallaryPermission() async {
    PermissionStatus status = await Permission.photos.status;
    if (status.isPermanentlyDenied) {
      PermissionAlert.StorageDeniedForever(Get.context!);
      return;
    }
    if (!status.isGranted) {
      status = await Permission.photos.request();
      if (status.isPermanentlyDenied) {
        PermissionAlert.StorageDeniedForever(Get.context!);
        return;
      }
      if (!status.isGranted) {
        PermissionAlert.StorageDenied(Get.context!, () => gallaryPermission());
        return;
      }
    }
    picPhoto(Get.context, ImageSource.gallery);
  }

  Future<void> validation() async {
    if (vendorCodeCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter vendor code');
    } else if (companyCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter company name');
    } else {
      await updateProfile();
    }
  }

  void searchVendorCatId(List<String> vendorCatList) {
    for (var element in vendorCatList) {
      debugPrint(element);
      for (var i = 0; i < profileDataObj!.vendorCategory!.length; i++) {
        if (element == profileDataObj!.vendorCategory![i].categoryName) {
          debugPrint(
              "selectedIdTPost : ${profileDataObj!.vendorCategory![i].id}");
          vendorCatIdListtoPost
              .add(profileDataObj!.vendorCategory![i].id.toString());
        }
      }
      vendorCatIdListtoPost = vendorCatIdListtoPost.toSet().toList();
      debugPrint("selectedIdLisTPost : $vendorCatIdListtoPost");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
