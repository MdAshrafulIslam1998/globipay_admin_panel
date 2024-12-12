import 'package:flutter/services.dart';

class OnlyEnglishFormatter extends TextInputFormatter {
  final List<String> allowedSpecialCharacters = const ['*', '-', '_', '%', '\$', '#', '@', '!', "'", "+", "/", "&", "="];

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Create a RegExp pattern for allowed characters
    final RegExp allowedPattern = RegExp(
        r'^[a-zA-Z0-9' + RegExp.escape(allowedSpecialCharacters.join()) + r' ]*$'
    );

    // If the new value matches the pattern, accept it
    if (allowedPattern.hasMatch(newValue.text)) {
      // Remove leading spaces
      if (newValue.text.startsWith(' ')) {
        final trimmedText = newValue.text.trimLeft();
        return TextEditingValue(
          text: trimmedText,
          selection: TextSelection.collapsed(offset: trimmedText.length),
        );
      }
      return newValue;
    }

    // If the new value doesn't match, keep the old value
    return oldValue;
  }
}