import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/primary_textfield.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';

import 'controller/change_pwd_cntler.dart';

class ChangePwd extends GetView<ChangePwdController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20.0,
              ),
              onPressed: () async {
                await Future.delayed(Duration(milliseconds: 80));
                Get.back();
              }),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          height: Get.height,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _img(),
              SizedBox(height: Get.height * 0.04),
              _text(),
              SizedBox(height: 10.0),
              _textField(),
              SizedBox(height: 6.0),
              Align(
                alignment: Alignment.centerRight,
                child: GetBuilder<ChangePwdController>(
                  builder: (controller) => controller.start == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Didn\'t receive SMS?',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 6.0),
                            // resendBtn()
                          ],
                        )
                      : Text(
                          controller.start.toString(),
                          style: TextStyle(
                              color: AppColors.SEC_COLOR,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              _button(context),
              SizedBox(height: Get.height * 0.04),
            ],
          ),
        )),
      ),
    );
  }

  Widget _img() {
    return Image.asset(
      Constant.lock_img,
      height: Get.height * .23,
      fit: BoxFit.fill,
    );
  }

  Widget _text() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification',
            style: Constant.dashCountTS(
              19,
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          Text(
            'Verification code is sent on your registered email id',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.PRIMARY_LIGHT),
          ),
        ],
      ),
    );
  }

  Widget _textField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => PrimaryTextField(
            controller: controller.pwdCtrler,
            borderedTf: true,
            obscureText: controller.obscureText.value,
            hint: "PIN",
            inputDecoration: InputDecoration(
                labelStyle:
                    TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14),
                hintStyle:
                    TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14),
                hintText: 'PIN',
                isDense: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.PRIMARY_LIGHT,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.PRIMARY_LIGHT,
                )),
                suffixIcon: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 100));
                      controller.obscureText.value =
                          !controller.obscureText.value;
                    },
                    child: Ink(
                      child: new Icon(
                        controller.obscureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => PrimaryTextField(
            controller: controller.changePwdCtrler,
            borderedTf: true,
            obscureText: controller.obscureText2.value,
            hint: "Confirm PIN",
            inputDecoration: InputDecoration(
                labelStyle:
                    TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14),
                hintStyle:
                    TextStyle(color: AppColors.PRIMARY_LIGHT, fontSize: 14),
                hintText: 'Confirm PIN',
                isDense: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.PRIMARY_LIGHT,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.PRIMARY_LIGHT,
                )),
                suffixIcon: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 100));
                      controller.obscureText2.value =
                          !controller.obscureText2.value;
                    },
                    child: Ink(
                      child: new Icon(
                        controller.obscureText2.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            PrimaryTextField(
              controller: controller.otpCtrler,
              borderedTf: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                LengthLimitingTextInputFormatter(6)
              ],
              isDense: false,
              prefixButton: Padding(
                padding: EdgeInsets.only(right: Get.width * .06),
                child: Icon(
                  Icons.password,
                  color: Colors.black87,
                ),
              ),
              hint: "Verification Code",
            ),
            // Positioned(right: 10, child: resendBtn()),
          ],
        ),
      ],
    );
  }

  Widget _button(BuildContext context) => CommonWidget.commonObsBtn(
      text: 'Submit',
      onPressed: () async {
        await Future.delayed(Duration(milliseconds: 100));
        FocusScope.of(context).unfocus();
        await controller.validation();
      },
      isLoading: ChangePwdController.isLoading);

  /*  Widget resendBtn() => Obx(() {
        return InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 100));
           /*  if (ForgetPWDController.isLoading.value == false) {
              await ForgetPWDController.forgotPwd(
                  emailId: Get.parameters['email'].toString(), isResend: false);
            } */
          },
          child: !ForgetPWDController.isLoading2.value
              ? Text(
                  'Resend',
                  style: TextStyle(
                      color: AppColors.SEC_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              : Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircularProgressIndicator(),
                ),
        );
      });
 */
}
