import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/constants/app_constant.dart';
import 'package:globipay_admin_panel/core/constants/app_edge_insets.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';

class AppDropdown<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(T) setItem;
  final void Function(T?) onChange;
  TextEditingController? controller;
  final hintText;
  final bool isEnabled;
  final bool isRequired;
  final bool Function(T, String)? onFilter;
  final T? selectedItem;
  AppDropdown(
      {super.key,
        required this.data,
        this.selectedItem,
        required this.onChange,
        this.controller,
        this.onFilter,
        this.hintText,
        this.isRequired = true,
        this.isEnabled = true,
        required this.setItem});

  @override
  Widget build(BuildContext context) {
    if (onFilter != null && controller == null) {
      controller = TextEditingController();
    }
    return IgnorePointer(
      ignoring: !isEnabled,
      child: DropdownButtonFormField2(
        iconStyleData: const IconStyleData(
          icon: Padding(
            padding: AppEdgeInsets.right8,
            child: Icon(
              Icons.keyboard_arrow_down,
            ),
          ),
        ),
        isExpanded: true,
        value: selectedItem,
        items: data
            .map(
              (e) => DropdownMenuItem<T>(value: e, child: setItem(e)),
        )
            .toList(),
        onChanged: (value) {
          onChange(value);
        },
        hint: Text(
          hintText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        decoration: InputDecoration(
          // hintText: hintText,
          contentPadding: EdgeInsets.zero,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

          enabled: isEnabled,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
          border: InputBorder.none,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        dropdownSearchData:
        // null,
        onFilter != null
            ? DropdownSearchData(
          searchInnerWidget: Padding(
            padding: AppEdgeInsets.all10,
            child: InputField(
              hintText: "Search...",
              controller: controller,
            ),
          ),
          searchController: controller,
          searchInnerWidgetHeight: AppConstants.valueDouble58,
          searchMatchFn: (DropdownMenuItem<T?> item, sv) {
            if (onFilter != null && item.value != null) {
              return onFilter!(item.value as T, sv);
            }
            return true;
          },
        )
            : null,
        validator: (value) {
          if (value == null && isRequired) {
            return "    Field Can't be Empty";
          }
          return null;
        },
      ),
    );
  }
}
