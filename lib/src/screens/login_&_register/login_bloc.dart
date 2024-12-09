import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/screens/dashboard/widgets/fitness_app_theme.dart';
import 'package:yslcrm/src/screens/login_&_register/controllers/login_cntler.dart';
import 'package:yslcrm/src/screens/login_&_register/cubit/login_cubit.dart';
import 'package:yslcrm/src/utils/colors.dart';
import 'package:yslcrm/src/utils/hex_color.dart';

import 'widgets/login_btn.dart';
import 'widgets/sign_in_widgets.dart';

class LoginScreenBloc extends StatefulWidget {
  @override
  State<LoginScreenBloc> createState() => _LoginScreenBlocState();
}

class _LoginScreenBlocState extends State<LoginScreenBloc> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              key: _formkey,
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
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: "Email Address"),
                                  validator: (val) {
                                    if (_emailController.text.isEmpty ||
                                        !_emailController.text.isEmail) {
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
                                child: BlocBuilder<TogglePWDCubit, bool>(
                                  builder: (context, state) {
                                    final cubit =
                                        context.read<TogglePWDCubit>();

                                    return TextFormField(
                                      controller: _pwdController,
                                      obscureText: state,
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
                                                await Future.delayed(Duration(
                                                    milliseconds: 100));
                                                cubit.togglePasswordVisibility(
                                                    state);
                                              },
                                              child: Ink(
                                                child: new Icon(
                                                  state
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          )),
                                      validator: (val) {
                                        if (_pwdController.text.isEmpty ||
                                            _pwdController.text.length < 6) {
                                          return "Please enter at least 6 characters.";
                                        } else {
                                          return null;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              //ForgotPwdButton(),
                              SizedBox(height: Get.height * 0.03),
                              LoginButton(
                                  formKey: this._formkey,
                                  email: this._emailController,
                                  pwd: this._pwdController),

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

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }
}
