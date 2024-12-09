import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constant.dart';

class PermissionAlert {
  // ignore: non_constant_identifier_names
  static void LocationDenied(BuildContext context, Function _callback) {
    Widget cancelButton = TextButton(
      child: Text(
        "I'M SURE",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "RETRY",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        //_callback.call();
        openAppSettings();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Location Permission Denied",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        Constant.APPBAR_TITLE_NAME +
            " uses this permission to detect your current location for delivery. Are you sure you want to deney this permission?",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  static void LocationDeniedForever(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text(
        "GO TO SETTINGS",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        openAppSettings();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text(
        "It looks like you have turned off location permissions required for this feature. It can be enabled under\nPhone Settings > Apps > " +
            Constant.APPBAR_TITLE_NAME +
            " > Permissions",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  static void StorageDenied(BuildContext context, Function _callback) {
    Widget cancelButton = TextButton(
      child: Text(
        "I'M SURE",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "RETRY",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        // _callback.call();
        openAppSettings();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Storage Permission Denied",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        Constant.APPBAR_TITLE_NAME +
            " uses this permission to upload photos. Are you sure you want to deney this permission?",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  static void StorageDeniedForever(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text(
        "GO TO SETTINGS",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        openAppSettings();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text(
        "It looks like you have turned off storage permissions required for this feature. It can be enabled under\nPhone Settings > Apps > " +
            Constant.APPBAR_TITLE_NAME +
            " > Permissions",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  static void CameraDenied(BuildContext context, Function _callback) {
    Widget cancelButton = TextButton(
      child: Text(
        "I'M SURE",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "RETRY",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        openAppSettings();
        //_callback.call();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Storage Permission Denied",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        Constant.APPBAR_TITLE_NAME +
            " uses this permission to upload profile image. Are you sure you want to deney this permission?",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  static void CameraDeniedForever(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text(
        "GO TO SETTINGS",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        openAppSettings();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text(
        "It looks like you have turned off camera permissions required for this feature. It can be enabled under\nPhone Settings > Apps > " +
            Constant.APPBAR_TITLE_NAME +
            " > Permissions",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
