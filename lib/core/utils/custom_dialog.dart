import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';

/**
 * Created by Abdullah on 21/8/24.
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/*

showCustomDialog(
    String message,
    {String? title,
      String? positiveButtonText,
      String? negativeButtonText,
      bool isCancelable = true,
      Function()? positiveButtonAction,
      Function()? negativeButtonAction,
      bool willPopOnPositiveAction = true,
      bool willPopOnNegativeAction = true,
      GlobalKey? key}) {

  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: "Dialog",
    barrierColor: Colors.black.withOpacity(0.65),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          return;
        },
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 560,
              maxHeight: 800,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        offset: const Offset(0, 12),
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title Section with Close Button
                      if (title != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A1A1A),
                                    letterSpacing: -0.5,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              if (isCancelable)
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => AppRoutes.pop(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 24),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.grey.shade700,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                      // Message Section
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(40, title != null ? 24 : 40, 40, 40),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            height: 1.6,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),

                      // Action Buttons
                      Container(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (negativeButtonAction != null || isCancelable)
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: _HoverButton(
                                  onPressed: () {
                                    AppRoutes.pop();
                                    negativeButtonAction?.call();
                                  },
                                  backgroundColor: Colors.grey.shade50,
                                  hoverColor: Colors.grey.shade100,
                                  borderColor: Colors.grey.shade200,
                                  child: Text(
                                    negativeButtonText ?? "Cancel",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            if (negativeButtonAction != null || isCancelable)
                              const SizedBox(width: 16),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: _HoverButton(
                                onPressed: () {
                                  AppRoutes.pop();
                                  positiveButtonAction?.call();
                                },
                                backgroundColor: const Color(0xFF3B82F6),
                                hoverColor: const Color(0xFF2563EB),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      positiveButtonText ?? "OK",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.0).animate(
          CurvedAnimation(
            parent: anim1,
            curve: Curves.easeOutExpo,
          ),
        ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1.0).animate(
            CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOut,
            ),
          ),
          child: child,
        ),
      );
    },
    context: AppNavigatorService.navigatorKey.currentContext!,
  );
}

// Custom Hover Button Widget
class _HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color? hoverColor;
  final Color? borderColor;

  const _HoverButton({
    required this.child,
    required this.onPressed,
    required this.backgroundColor,
    this.hoverColor,
    this.borderColor,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHovered ? widget.hoverColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor!)
              : null,
          boxShadow: isHovered && widget.borderColor == null
              ? [
            BoxShadow(
              color: widget.backgroundColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
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