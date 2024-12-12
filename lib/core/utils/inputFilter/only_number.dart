import 'package:flutter/services.dart';

class OnlyNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
String newText = newValue.text.replaceAll(RegExp(r'[^\d]|\s+'), '');

    int newCursorPosition = newValue.selection.baseOffset;
    int oldTextLength = newValue.text.length;
    int newTextLength = newText.length;
    int lengthDifference = oldTextLength - newTextLength;
    int adjustedCursorPosition = newCursorPosition - lengthDifference;

    if (adjustedCursorPosition < 0) {
      adjustedCursorPosition = 0;
    } else if (adjustedCursorPosition > newTextLength) {
      adjustedCursorPosition = newTextLength;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: adjustedCursorPosition),
    );
  }
}
