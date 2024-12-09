/* import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Function onPressed;

  const TextBtn({Key key, this.label, this.isLoading = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: isLoading
            ? SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontFamily: 'HelveticaNeueLTStd',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
      ),
      onTap: onPressed,
    );
  }
}
 */