import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yslcrm/src/themes/app_theme.dart';
import 'package:yslcrm/src/utils/colors.dart';

class MyWidget {
  static myRatingWidget({
    required double rating,
    required int itemCount,
    required double itemSize,
    Color? color,
    Function(double)? onRatingUpdate,
  }) {
    return RatingBar.builder(
        initialRating: rating,
        allowHalfRating: true,
        glow: false,
        direction: Axis.horizontal,
        itemBuilder: (context, index) => Icon(
              Icons.star,
              color: color ?? AppColors.SEC_COLOR,
            ),
        itemCount: itemCount,
        itemSize: itemSize,
        onRatingUpdate: onRatingUpdate!);
  }

  static showMyratingWidget(
          {required double rating,
          required int itemCount,
          required double itemSize,
          Color? color}) =>
      RatingBarIndicator(
        rating: rating,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: color ?? AppColors.SEC_COLOR,
        ),
        itemCount: itemCount,
        itemSize: itemSize,
        direction: Axis.horizontal,
      );

  static Scrollbar scrollBar({required Widget child}) {
    return Scrollbar(thickness: 3.8, child: child, interactive: true);
  }

  static Widget emptyView({String? img, String? title, String? text}) {
    return Center(
      child: Container(
        height: Get.height * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 85,
                height: 85,
                child: null,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.cover, image: AssetImage("$img")))),
            SizedBox(height: 15),
            Text('$title',
                style: TextStyle(
                    color: AppColors.RED, fontFamily: 'Raleway', fontSize: 20)),
            SizedBox(height: 10),
            Text('$text',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.LIGHT_BLACK,
                    fontFamily: 'Raleway',
                    fontSize: 15))
          ],
        ),
      ),
    );
  }

  static emptyViewWithoutImg({String? txt}) => Center(
        child: Text(txt ?? 'No Data found',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.nearlyBlack,
                fontWeight: FontWeight.normal,
                fontSize: 15)),
      );

//Date Picker
  static DateTime currentDate = DateTime.now();
  static Future<String> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      currentDate = pickedDate;
    var formatterDate = DateFormat('yyyy-MM-dd');
    formatterDate.format(currentDate);
    print(formatterDate.format(currentDate));
    return formatterDate.format(currentDate);
  }
}
