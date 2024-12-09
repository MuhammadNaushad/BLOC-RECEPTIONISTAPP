import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/routes/app_pages.dart';

import '../widgets/background.dart';
import 'controller/change_pwd_cntler.dart';

class ChangePWDScreen extends GetView<ChangePwdController> {
  ChangePWDScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Change Password?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Obx(
                () => TextField(
                  controller: controller.pwdCtrler,
                  obscureText: controller.obscureText.value,
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(10)
                  ],
                  decoration: InputDecoration(
                      labelText: "Old Password",
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
            ),
            SizedBox(height: Get.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Obx(
                () => TextField(
                  controller: controller.pwdCtrler,
                  obscureText: controller.obscureText.value,
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(10)
                  ],
                  decoration: InputDecoration(
                      labelText: "New Password",
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
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  Get.offNamed(Routes.LOGIN);
                },
                child: Container(
                  width: Get.width * .15,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Sign In?",
                    style: TextStyle(fontSize: 13, color: Color(0XFF2661FA)),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child: TextButton(
                onPressed: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  FocusScope.of(context).unfocus();
                  /*  if (controller.isLoading2.value == false) {
                    await controller.validation(type: 'pwd');
                  } */
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: Get.width * 0.46,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "SEND",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            /* Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  /*  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterScreen())) */
                },
                child: Text(
                  "Don't Have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}
