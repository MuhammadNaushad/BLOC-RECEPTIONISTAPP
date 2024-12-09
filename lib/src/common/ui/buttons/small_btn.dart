/* import 'package:flutter/material.dart';

class SmallBtn extends StatelessWidget {
  final String? label;
  final String? subtext;
  final Function? onPressed;
  final bool isAccent;
  final double labelSize;
  final FontWeight labelWeight;
  final bool isLoading;

  const SmallBtn({
    Key? key,
    this.label,
    required this.onPressed,
    this.subtext,
    this.isAccent = false,
    this.labelSize = 14,
    this.labelWeight = FontWeight.w900,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = isAccent ? Colors.black : Colors.white;
    Color bgColor = isAccent ? Colors.grey.shade200 : Colors.black;

    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: bgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: isLoading
          ? SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(strokeWidth: 3),
            )
          : Column(
              children: [
                Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontFamily: 'HelveticaNeueLTStd',
                    fontSize: labelSize,
                    fontWeight: labelWeight,
                  ),
                ),
                subtext != null
                    ? Text(
                        subtext!,
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'RalewayBold',
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                        ),
                      )
                    : Container(),
              ],
            ),
      onPressed: onPressed,
    );
  }
}
 */