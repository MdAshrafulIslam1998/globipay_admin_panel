/**
 * Created by Abdullah on 27/12/24.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstIndexSignInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue; // Allow empty value
    }

    // Check if the first character is + or - and the rest are digits
    final isValid = RegExp(r'^[-+]?[0-9]*$').hasMatch(text);

    // If valid, return newValue; otherwise, return oldValue
    return isValid ? newValue : oldValue;
  }
}
