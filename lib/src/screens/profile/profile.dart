import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/appBar.dart';
import 'package:yslcrm/src/screens/profile/controllers/my_profile_cntler.dart';

import 'widgets/tabbar.dart';

class MyProfile extends GetView<MyProfileController> with CommonWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(viewType: 'My Profile'),
        body: /* SafeArea(
            child: Container(
                color: AppTheme.nearlyWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*  SizedBox(height: 20.0),
                    _profileImage(), */
                    /*  SizedBox(height: Get.height * .04),
                    Expanded(child: _textFields()), */
                    StackOver()
                  ],
                ) //.fadeAnimation(1.0),
                )) */
            ProfileTab());
  }

  /*  Widget _profileImage() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: MyProfileController.isAvatarStored.value
                      ? CachedNetworkImage(
                          alignment: Alignment.bottomRight,
                          width: 85,
                          height: 85,
                          fit: BoxFit.fill,
                          imageUrl: MyProfileController.storedAvtar.value,
                          placeholder: (context, url) => new Image.asset(
                                'assets/images/default_avatar.png',
                                width: 85,
                                height: 85,
                              ),
                          errorWidget: (context, url, error) => new Image.asset(
                                'assets/images/default_avatar.png',
                                width: 85,
                                height: 85,
                              ))
                      : Image.asset(
                          'assets/images/default_avatar.png',
                          width: 85,
                          height: 85,
                        ),
                ),
                /* Positioned(
                  bottom: 0,
                  right: -3,
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 100));
                      _showPhotoSheet(Get.context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.SEC_COLOR,
                      radius: 14,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.black,
                        size: 17,
                      ),
                    ),
                  ),
                ), */
              ],
            ),
            SizedBox(
              width: 25.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${MyProfileController.fullName.value}',
                      style: Constant.dashCountTS(
                          15.8, FontWeight.w700, Colors.white)),
                  SizedBox(
                    height: 1.0,
                  ),
                  Text('${MyProfileController.email.value}',
                      maxLines: 2,
                      style: Constant.dashCountTS(
                          15, FontWeight.w500, Colors.white)),
                  SizedBox(
                    height: 1.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.SEC_COLOR,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('4.5/5',
                          style: Constant.dashCountTS(
                              15, FontWeight.w500, AppColors.SEC_COLOR)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPhotoSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: Get.width * .25),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: new Text(
                    'Camera',
                    style: Constant.dashCountTS(
                        15.0, FontWeight.w500, AppColors.PRIMARY_LIGHT),
                  ),
                  onPressed: () async {
                    Get.back();
                    await MyProfileController.cameraPermission();
                  },
                ),
                SizedBox(
                    height: 5.0,
                    width: Get.width * .9,
                    child: Divider(color: AppColors.PRIMARY_Medium_LIGHT)),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: Get.width * .25),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: new Text(
                    'Gallery',
                    style: Constant.dashCountTS(
                        15.0, FontWeight.w500, AppColors.PRIMARY_LIGHT),
                  ),
                  onPressed: () async {
                    Get.back();
                    await MyProfileController.gallaryPermission();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _textFields() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(22.0),
            topLeft: Radius.circular(22.0),
          )),
      child: Column(
        children: [
          PrimaryTextField(
            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
            controller: MyProfileController.emailCtrler,
            isVerticalLabel: true,
            label: 'Email Id',
            keyboardType: TextInputType.text,
            inputDecoration: textFieldStyle2(),
            inputTextColor: AppColors.PRIMARY_LIGHT,
          ),
          SizedBox(height: 7.0),
          PrimaryTextField(
            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
            controller: MyProfileController.mobCtrler,
            isVerticalLabel: true,
            label: 'Mobile Number',
            keyboardType: TextInputType.text,
            inputDecoration: textFieldStyle2(),
            inputTextColor: AppColors.PRIMARY_LIGHT,
          ),
          /* SizedBox(height: 7.0),
          PrimaryTextField(
            vertAndHorHeadTxtTS: Constant.dashCountTS(),
            controller: MyProfileController.fNameCtrler,
            isVerticalLabel: true,
            label: 'Supervisor',
            keyboardType: TextInputType.text,
            readOnly: true,
            inputDecoration: textFieldStyle2(),
            inputTextColor: AppColors.PRIMARY_LIGHT,
          ), */
          SizedBox(height: 7.0),
          PrimaryTextField(
            vertAndHorHeadTxtTS: Constant.textfieldLabelTS(),
            controller: MyProfileController.areaRegionCtrler,
            isVerticalLabel: true,
            label: 'Area / Region',
            keyboardType: TextInputType.text,
            inputDecoration: textFieldStyle2(),
            inputTextColor: AppColors.PRIMARY_LIGHT,
          ),
          SizedBox(height: 20.0),
          /* CommonWidget.commonButton(
              text: 'Done',
              onPressed: () async {
                Utilities.delay(100);
                Get.back();
              }) */
        ],
      ),
    );
  }
 */
}
