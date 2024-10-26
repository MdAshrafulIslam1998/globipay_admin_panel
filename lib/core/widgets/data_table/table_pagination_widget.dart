import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/data/model/pagination.dart';

class TablePaginationWidget extends StatelessWidget {
  final Pagination pagination;
  final Function(int) onPageChange;

  const TablePaginationWidget({
    Key? key,
    required this.pagination,
    required this.onPageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: (pagination.currentPage ?? 1) > 1
              ? () => onPageChange((pagination.currentPage ?? 1) - 1)
              : null,
          child: const Text('Previous'),
        ),
        ...List.generate(
          pagination.totalPages ?? 0, // default to 0 if null
          (index) => _buildPageButton(index + 1),
        ),
        TextButton(
          onPressed:
              (pagination.currentPage ?? 1) < (pagination.totalPages ?? 1)
                  ? () => onPageChange((pagination.currentPage ?? 1) + 1)
                  : null,
          child: const Text('Next'),
        ),
      ],
    );
  }

  Widget _buildPageButton(int pageNumber) {
    return TextButton(
      onPressed: pageNumber != pagination.currentPage
          ? () => onPageChange(pageNumber)
          : null,
      style: TextButton.styleFrom(
        backgroundColor:
            pageNumber == pagination.currentPage ? Colors.blue : null,
        foregroundColor:
            pageNumber == pagination.currentPage ? Colors.white : null,
      ),
      child: Text('$pageNumber'),
    );
  }
}
