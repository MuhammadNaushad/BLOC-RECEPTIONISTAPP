import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/dashboard/widgets/fitness_app_theme.dart';
import 'package:yslcrm/src/screens/login_&_register/controllers/login_cntler.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/hex_color.dart';

import 'widgets/login_btn.dart';
import 'widgets/sign_in_widgets.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height * .47,
            decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.PRIMARY_COLOR,
                AppColors.PRIMARY_COLOR.withOpacity(1)
              ]),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.grey.withOpacity(0.6),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 50.0)),
            ),
          ),
          Container(
            //  color: Colors.indigo[800],
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: controller.formKey,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /*  CustomPaint(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    painter: HeaderCurvedContainer(),
                  ), */

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SignInText(),
                      SizedBox(height: Get.height * 0.03),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.6),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: TextFormField(
                                  controller: controller.emailCtrler,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: "Email Address"),
                                  validator: (val) {
                                    if (controller.emailCtrler.text.isEmpty ||
                                        !controller.emailCtrler.text.isEmail) {
                                      return "Please enter valid email id";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.03),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: Obx(
                                  () => TextFormField(
                                    controller: controller.pwdCtrler,
                                    obscureText: controller.obscureText.value,
                                    /* inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10)
                                    ], */
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        suffixIcon: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () async {
                                              await Future.delayed(
                                                  Duration(milliseconds: 100));
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
                                    validator: (val) {
                                      if (controller.pwdCtrler.text.isEmpty ||
                                          controller.pwdCtrler.text.length <
                                              6) {
                                        return "Please enter at least 6 characters.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              //ForgotPwdButton(),
                              SizedBox(height: Get.height * 0.03),
                              // LoginButton(controller: controller),

                              /* Container(
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.red[900],
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        offset: const Offset(2.0, 2.0),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  )) */
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
