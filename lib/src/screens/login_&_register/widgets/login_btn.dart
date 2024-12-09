import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/screens/login_&_register/cubit/login_cubit.dart';
import 'package:yslcrm/src/utils/colors.dart';

import '../controllers/login_cntler.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController pwd;
  const LoginButton({
    super.key,
    required this.formKey,
    required this.email,
    required this.pwd,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        debugPrint('$state');
        if (state is LoginSuccess) {
          Get.offAllNamed(Routes.DASHBOARD, parameters: state.data);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login Successful!')));
        } else if (state is LoginFailure) {
          // Clear the text fields
          email.clear();
          pwd.clear();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Failed: ${state.message}')));
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: Get.height * 0.05),
          child: TextButton(
            onPressed: () async {
              await Future.delayed(Duration(milliseconds: 100));
              if ((state != LoginInProgress)) {
                FocusManager.instance.primaryFocus?.unfocus();
                if (formKey.currentState!.validate()) {
                  context
                      .read<LoginCubit>()
                      .login(email: this.email.text, password: this.pwd.text);
                }
                // await controller.validation();
              }
            },
            child: AnimatedContainer(
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
                    AppColors.PRIMARY_COLOR,
                    AppColors.PRIMARY_COLOR,
                  ])),
              padding: const EdgeInsets.all(0),
              duration: Duration(milliseconds: 100),
              child: (state is LoginInProgress)
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
