import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/utils/colors.dart';

class MobileOTPScreen extends StatelessWidget {
  MobileOTPScreen({Key? key}) : super(key: key);
  final otpController = TextEditingController();

  static var otpText = "".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: Get.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter the OTP send to your\n registered email',
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.04),
            /* PinCodeTextField(
              controller: otpController,
              pinBoxHeight: Get.width * .15,
              pinBoxWidth: Get.width * .15,
              pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              pinTextStyle:
                  TextStyle(fontSize: 25.0, height: 1.6, color: Colors.black),
              keyboardType: TextInputType.number,
              onTextChanged: (value) {
                otpText.value = value;
              },
            ), */
            SizedBox(height: Get.height * 0.04),
            Text(
              'Didn\'t receive OTP?',
              style: TextStyle(color: Colors.black87, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {},
              child: Text(
                'RESEND OTP',
                style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.PRIMARY_COLOR,
                ),
                onPressed: () {},
                child: Text(
                  'Verify OTP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}


/* @override
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
              SizedBox(height: Get.height * 0.04),
              _textField(),
              SizedBox(height: Get.height * 0.15),
              _button(),
              SizedBox(height: Get.height * 0.04),
              Text(
                'Didn\'t receive OTP?',
                style: TextStyle(color: Colors.black87, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(() {
                return InkWell(
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    if (ForgetPWDController.isLoading.value == false) {
                      await controller.validation();
                    }
                  },
                  child: !ForgetPWDController.isLoading2.value
                      ? Text(
                          'RESEND',
                          style: TextStyle(
                              color: AppColors.PRIMARY_COLOR,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : CircularProgressIndicator(),
                );
              }),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Password',
          style: Constant.dashCountTS(
            19,
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          'Please enter your mobile number to recieve a\nverification code',
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.PRIMARY_LIGHT),
        ),
      ],
    );
  }

  Widget _textField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryTextField(
                  controller: controller.pwdCtrler,
                  normalTf: true,
                  keyboardType: TextInputType.text,
                  prefixButton: Padding(
                      padding: EdgeInsets.only(right: Get.width * .06),
                      child: Image.asset(Constant.loginPwdIcon,
                          height: 20, width: 20)),
                  hint: "Password",
                ),
                PrimaryTextField(
                  controller: controller.changePwdCtrler,
                  normalTf: true,
                  keyboardType: TextInputType.text,
                  prefixButton: Padding(
                      padding: EdgeInsets.only(right: Get.width * .06),
                      child: Image.asset(Constant.loginPwdIcon,
                          height: 20, width: 20)),
                  hint: "Confirm Password",
                ),
                PrimaryTextField(
                  controller: controller.otpCtrler,
                  normalTf: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(6)
                  ],
                  prefixButton: Padding(
                    padding: EdgeInsets.only(right: Get.width * .06),
                    child: Icon(
                      Icons.password,
                      color: Colors.black87,
                    ),
                  ),
                  hint: "Enter OTP",
                ),
      ],
    );
  }

  Widget _button() => CommonWidget.commonObsBtn(
      text: 'Submit',
      onPressed: () async {
        await Future.delayed(Duration(milliseconds: 100));
        if (ForgetPWDController.isLoading2.value == false) {
          await controller.validation(type: 'pwd');
        }
      },
      isLoading: ForgetPWDController.isLoading); */