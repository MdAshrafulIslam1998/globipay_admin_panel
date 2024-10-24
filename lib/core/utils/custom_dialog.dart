import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/router/route_utils.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

showCustomDialog(
  String message, {
  String? title,
  String? positiveButtonText,
  String? negativeButtonText,
  bool isCancelAble = true,
  Function()? positiveButtonAction,
  Function()? negativeButtonAction,
  bool willPopOnPositiveAction = true,
  bool willPopOnNegativeAction = true,
  GlobalKey? key,
}) {
  showDialog(
    barrierDismissible: isCancelAble,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => isCancelAble,
        child: CupertinoAlertDialog(
          key: key,
          title: Text(
            title ?? "",
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(message),
          ),
          actions: <Widget>[
            if (negativeButtonAction != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  if (willPopOnNegativeAction) {
                    RouteUtils.pop(context); // Updated pop method
                  }
                  negativeButtonAction?.call();
                },
                child: Text(negativeButtonText ?? "Cancel"),
              ),
            if (positiveButtonAction != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  if (willPopOnPositiveAction) {
                    RouteUtils.pop(context); // Updated pop method
                  }
                  positiveButtonAction?.call();
                },
                child: Text(positiveButtonText ?? "Ok"),
              ),
          ],
        ),
      );
    },
    context: AppNavigatorService.navigatorKey.currentContext!,
  );
}
