import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ForgotPwdButton extends StatelessWidget {
  const ForgotPwdButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          await Future.delayed(Duration(milliseconds: 100));
          FocusManager.instance.primaryFocus?.unfocus();
          Get.toNamed(Routes.ForgotPwd);
        },
        child: Ink(
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 13),
            child: Text(
              "Forgot your password?",
              style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
            ),
          ),
        ),
      ),
    );
  }
}
