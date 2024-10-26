import 'dart:math';

import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_pagination_model.dart';

class TablePagination extends StatelessWidget {
  final TablePaginationModel model;
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  
  const TablePagination({
    Key? key,
    required this.model,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<int> getVisiblePages() {
      final halfVisible = (model.visiblePages - 1) ~/ 2;
      var start = currentPage - halfVisible;
      var end = currentPage + halfVisible;
      
      if (start < 1) {
        end = end + (1 - start);
        start = 1;
      }
      
      if (end > totalPages) {
        start = start - (end - totalPages);
        end = totalPages;
      }
      
      start = max(1, start);
      end = min(totalPages, end);
      
      return List.generate(end - start + 1, (index) => start + index);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PaginationButton(
          text: 'Previous',
          active: currentPage > 1,
          onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          model: model,
        ),
        const SizedBox(width: 8),
        ...getVisiblePages().map((page) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _PaginationButton(
              text: page.toString(),
              active: page == currentPage,
              selected: page == currentPage,
              onPressed: () => onPageChanged(page),
              model: model,
            ),
          );
        }),
        const SizedBox(width: 8),
        _PaginationButton(
          text: 'Next',
          active: currentPage < totalPages,
          onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          model: model,
        ),
      ],
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final String text;
  final bool active;
  final bool selected;
  final Function()? onPressed;
  final TablePaginationModel model;
  
  const _PaginationButton({
    Key? key,
    required this.text,
    this.active = true,
    this.selected = false,
    this.onPressed,
    required this.model,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: active ? onPressed : null,
      style: TextButton.styleFrom(
        backgroundColor: selected ? model.activeColor : model.inactiveColor,
        foregroundColor: selected ? Colors.white : model.textColor,
        padding: model.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(model.borderRadius),
          side: BorderSide(
            color: selected ? model.activeColor : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
