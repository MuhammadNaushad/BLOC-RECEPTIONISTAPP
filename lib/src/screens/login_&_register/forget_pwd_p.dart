import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/common/widgets/primary_textfield.dart';
import 'package:yslcrm/src/screens/login_&_register/controllers/forget_pwd_cntler.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/constant.dart';

class ForgetPWDScreen extends GetView<ForgetPWDController> {
  ForgetPWDScreen({Key? key}) : super(key: key);

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
              //_img(),
              SizedBox(height: Get.height * 0.04),
              _text(),
              SizedBox(height: Get.height * 0.04),
              _textField(),
              SizedBox(height: Get.height * 0.12),
              _button(context),
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
            'Forget Password',
            style: Constant.dashCountTS(
              19,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            'Please enter your email id to receive a verification code',
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
        PrimaryTextField(
          controller: controller.emailCtrler,
          normalTf: true,
          keyboardType: TextInputType.text,
          prefixButton: Padding(
              padding: EdgeInsets.only(right: Get.width * .06),
              child:
                  Image.asset(Constant.emailIcon, height: 20.0, width: 20.0)),
          hint: "Email ID",
        ),
      ],
    );
  }

  Widget _button(BuildContext context) => CommonWidget.commonObsBtn(
      text: 'Next',
      onPressed: () async {
        await Future.delayed(Duration(milliseconds: 100));
        FocusScope.of(context).unfocus();
        if (ForgetPWDController.isLoading2.value == false) {
          await controller.validation(type: 'pwd');
        }
      },
      isLoading: ForgetPWDController.isLoading);
}
