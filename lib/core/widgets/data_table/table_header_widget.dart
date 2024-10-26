
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/data/model/data_table/table_config_model.dart';

class TableHeaderWidget extends StatelessWidget {
  final TableConfigModel config;
  final RxString searchQuery;
  final Function(int) onEntriesChanged;
  final Function(String) onSearch;

  const TableHeaderWidget({
    Key? key,
    required this.config,
    required this.searchQuery,
    required this.onEntriesChanged,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (config.showExport) _buildExportButtons(),
        const Spacer(),
        if (config.showSearch) _buildSearchField(),
      ],
    );
  }

  Widget _buildExportButtons() {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.file_download),
          label: const Text('CSV'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        // ... other export buttons
      ],
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 200,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
