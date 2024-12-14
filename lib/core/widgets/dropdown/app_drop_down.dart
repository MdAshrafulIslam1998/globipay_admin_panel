
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_constant.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/constants/app_radius.dart';
import 'package:globipay_admin_panel/core/widgets/text/app_text.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';
/**
 * Created by Abdullah on 14/12/24.
 */



class AppDropdown<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(T) setItem;
  final void Function(T?) onChange;
  final TextEditingController? controller;
  final hintText;
  final bool isEnabled;
  final bool isRequired;
  final bool Function(T, String)? onFilter;
  final T? selectedItem;
  final String? emptyErrorMessage;
  const AppDropdown({
    super.key,
    required this.data,
    this.selectedItem,
    required this.onChange,
    this.controller,
    this.onFilter,
    this.hintText,
    this.isRequired = true,
    this.isEnabled = true,
    required this.setItem,
    this.emptyErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: DropdownButtonFormField2(
        isExpanded: true,
        value: selectedItem,
        items: data
            .map(
              (e) =>
                  DropdownMenuItem<T>(value: e,
                      child: setItem(e)
                  ),
        )
            .toList(),
        onChanged: (value) {
          onChange(value as T?);
        },
        hint: AppText(hintText),
        decoration: InputDecoration(
          // hintText: hintText,
          contentPadding: EdgeInsets.zero,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

          enabled: isEnabled,
          enabledBorder: Theme.of(context)
              .inputDecorationTheme
              .copyWith(
              enabledBorder: OutlineInputBorder(
                  borderSide: Theme.of(context)
                      .inputDecorationTheme
                      .enabledBorder!
                      .borderSide,
                  borderRadius: AppRadius.defaultInputBorderRadius))
              .enabledBorder,
          focusedBorder: Theme.of(context)
              .inputDecorationTheme
              .copyWith(
              enabledBorder: OutlineInputBorder(
                  borderSide: Theme.of(context)
                      .inputDecorationTheme
                      .focusedBorder!
                      .borderSide,
                  borderRadius: AppRadius.defaultInputBorderRadius))
              .focusedBorder,
          errorBorder: Theme.of(context)
              .inputDecorationTheme
              .copyWith(
              enabledBorder: OutlineInputBorder(
                  borderSide: Theme.of(context)
                      .inputDecorationTheme
                      .errorBorder!
                      .borderSide,
                  borderRadius: AppRadius.defaultInputBorderRadius))
              .errorBorder,
          border: Theme.of(context)
              .inputDecorationTheme
              .copyWith(
              enabledBorder: OutlineInputBorder(
                  borderSide: Theme.of(context)
                      .inputDecorationTheme
                      .border!
                      .borderSide,
                  borderRadius: AppRadius.defaultInputBorderRadius))
              .border,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        dropdownSearchData:
        // null,
        onFilter != null
            ? DropdownSearchData(
          searchInnerWidget: Padding(
            padding: AppEdgeInsets.all10,
            child: InputField(
              hintText:
              "Type here...",
              controller: controller,
            ),
          ),
          searchController: controller,
          searchInnerWidgetHeight: AppConstants.valueDouble58,
          searchMatchFn: (DropdownMenuItem<T?> item, sv) {
            if (onFilter != null && item.value != null) {
              return onFilter!(item.value!, sv);
            }
            return true;
          },
        )
            : null,
        validator: (value) {
          if (value == null && isRequired) {
            return "    Filed is required";
          }
          return null;
        },
      ),
    );
  }
}
