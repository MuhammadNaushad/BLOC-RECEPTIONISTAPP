/* import 'package:flutter/material.dart';

class WhiteBtn extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool isLoading;

  const WhiteBtn({
    Key key,
    this.onPressed,
    this.label,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.zero,
      color: Colors.white,
      onPressed: onPressed,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
    );
  }
}
 */