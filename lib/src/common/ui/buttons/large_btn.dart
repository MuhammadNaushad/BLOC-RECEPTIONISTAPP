/* import 'package:flutter/material.dart';

class LargeBtn extends StatelessWidget {
  final String label;
  final String topText;
  final Function onPressed;
  final double labelSize;
  final FontWeight labelWeight;
  final bool isLoading;
  final EdgeInsets padding;

  const LargeBtn({
    Key key,
    this.label,
    this.onPressed,
    this.topText,
    this.labelSize = 22,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
    this.labelWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: IntrinsicWidth(
          child: RaisedButton(
            padding: padding,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                children: [
                  topText != null
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            topText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'RalewayBold',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : Container(),
                  isLoading == false
                      ? Text(
                          label,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'HelveticaNeueLTStd',
                            fontSize: labelSize,
                            fontWeight: labelWeight,
                          ),
                        )
                      : SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Colors.black,
                          ),
                        ),
                ],
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
 */