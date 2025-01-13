import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';

import '../../constants/app_constant.dart';
import 'input_regex.dart';

/// Created by Abdullah on 22/8/24.

class InputField extends TextFormField {
  final String? header;
  final String? hintText;
  final Function(String?)? onTextChange;
  final InputDecoration? inputDecoration;
  final bool willShowCounter;
  final InputRegex? regex;
  final Function(String?)? customValidator;
  final double height;
  final bool isOptional;
  final TextStyle? hintStyle;
  final Widget? prefix, suffix, prefixIcon, suffixIcon;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  InputField(
      {this.header,
        this.regex,
        this.hintText,
        this.onTextChange,
        this.prefix,
        this.suffix,
        this.prefixIcon,
        this.suffixIcon,
        this.customValidator,
        this.height = AppConstants.valueDouble70,
        super.autocorrect,
        super.autofillHints,
        super.autofocus,
        super.autovalidateMode = AutovalidateMode.onUserInteraction,
        super.buildCounter,
        super.canRequestFocus,
        super.controller,
        super.cursorColor,
        super.cursorHeight,
        super.cursorOpacityAnimates,
        super.cursorRadius,
        super.cursorWidth,
        super.dragStartBehavior,
        super.enableIMEPersonalizedLearning,
        super.enableInteractiveSelection,
        super.enableSuggestions,
        super.enabled,
        super.expands,
        super.focusNode,
        super.initialValue,
        super.inputFormatters,
        super.scribbleEnabled,
        super.key,
        super.keyboardAppearance,
        super.keyboardType,
        super.magnifierConfiguration,
        super.maxLength = AppConstants.valueInt50,
        super.maxLengthEnforcement,
        super.maxLines,
        super.minLines,
        super.mouseCursor,
        super.obscureText,
        super.obscuringCharacter,
        super.onAppPrivateCommand,
        super.onEditingComplete,
        super.onFieldSubmitted,
        super.onSaved,
        super.onTap,
        super.readOnly,
        super.restorationId,
        super.scrollController,
        super.style,
        super.textAlign,
        super.textInputAction = TextInputAction.next,
        this.isOptional = false,
        this.inputDecoration,
        this.willShowCounter = false,
        this.hintStyle,
        this.contentPadding,
        this.fillColor = Colors.white,
        super.textDirection})
      : super(
    onTapOutside: (PointerDownEvent event) {
    },
    onChanged: onTextChange != null ? (s) => onTextChange(s) : null,
    decoration: inputDecoration ??
        InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide:  const BorderSide(color: ColorPalettes.colorPrimary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide:  const BorderSide(color: Colors.grey),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide:  const BorderSide(color: Colors.grey),
          ),
          hintText: hintText,
          counterText: willShowCounter ? null : "",
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: hintStyle,
          filled: fillColor != null,
          fillColor: fillColor ,
          prefix: prefix,
          suffix: suffix,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
    validator: (value) {
      if (isOptional && value!.isEmpty) {
        return null;
      }
      var errorMessage;
      if (customValidator != null) {
        errorMessage = customValidator(value);
      }
      if (errorMessage != null) {
        return errorMessage;
      } else {
        if (regex != null) {
          RegExp regExp = RegExp(regex.pattern);

          if (value == null || value.isEmpty) {
            return "Field can't be empty";
          } else if (!regExp.hasMatch(value)) {
            return regex.message;
          }
          return null;
        }
        return null;
      }
    },
  );
}
