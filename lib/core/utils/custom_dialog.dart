import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';

/**
 * Created by Abdullah on 21/8/24.
 */
showCustomDialog(message,
    {title,
      String? positiveButtonText,
      String? negativeButtonText,
      bool isCancelAble=true,
      Function()? positiveButtonAction,
      Function()? negativeButtonAction,
      bool willPopOnPositiveAction=true,
      bool willPopOnNegativeAction=true,
      GlobalKey? key}) {
  showDialog(
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          return;
        },
        child: CupertinoAlertDialog(
          key: key,
          title: Text(
            title ?? "",
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
             message
            ),
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
                  AppRoutes.pop();
                },
                child: Text(
                  "Cancel",
                ),
              ),
            if(isCancelAble)ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                "Ok",
              ),
              onPressed: () {
                AppRoutes.pop();
                positiveButtonAction?.call();
              },
            ),
          ],
        ),
      );
    },
    context: AppNavigatorService.navigatorKey.currentContext!,
  );
}
/*

showCustomDialog( String message, {
  String? title,
  String? positiveButtonText = "OK",
  String? negativeButtonText = "Cancel",
  bool isCancelable = true,
  Function()? positiveButtonAction,
  Function()? negativeButtonAction,
  IconData? dialogIcon, // New: Icon for the dialog
  String? imageUrl, // New: Image for illustration
  bool willPopOnPositiveAction = true,
  bool willPopOnNegativeAction = true,
  GlobalKey? key,
}) {
  showDialog(
    barrierDismissible: isCancelable,
    context: AppNavigatorService.navigatorKey.currentContext!,    builder: (BuildContext context) {
      return Dialog(
        key: key,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.4, // Responsive width
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

              // Dialog Icon
              if (dialogIcon != null)
                Icon(dialogIcon, size: 48, color: Colors.blue),

              // Image Placeholder
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Image.network(
                    imageUrl,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),

              // Title
              if (title != null)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

              // Content
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Negative Button
                    if (negativeButtonText != null)
                      TextButton(
                        onPressed: () {
                          if (willPopOnNegativeAction) {
                            Navigator.of(context).pop();
                          }
                          negativeButtonAction?.call();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          negativeButtonText,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                    // Positive Button
                    if (positiveButtonText != null)
                      ElevatedButton(
                        onPressed: () {
                          if (willPopOnPositiveAction) {
                            Navigator.of(context).pop();
                          }
                          positiveButtonAction?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          positiveButtonText,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
*/
