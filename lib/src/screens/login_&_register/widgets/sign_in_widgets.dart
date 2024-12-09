import 'package:flutter/material.dart';

class SignInText extends StatelessWidget {
  const SignInText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome!",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 36),
            textAlign: TextAlign.left,
          ),
          Text(
            "Login to Admin Dashboard",
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
