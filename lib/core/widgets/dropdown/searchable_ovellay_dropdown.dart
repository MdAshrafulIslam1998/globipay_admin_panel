/// Created by Abdullah on 16/12/24.
library;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'dart:async';
import 'package:globipay_admin_panel/core/widgets/dropdown/searchable_dropdown.dart';

class SearchableDropdownOverlay<T> extends StatelessWidget {
  // Controller with a unique tag
  final SearchableDropdownController<T> controller;

  // Item display configuration
  final Widget Function(T item) itemBuilder;
  final Widget Function(T item)? selectedItemBuilder;
  final Widget Function(T item) displayStringForItemSelection;

  // Callbacks
  final void Function(List<T> selectedItems)? onChanged;

  // Title for the dropdown
  final String title;

   SearchableDropdownOverlay({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.title,
    this.selectedItemBuilder,
    required this.displayStringForItemSelection ,
    this.onChanged,
  });

  // Show dropdown as a bottom sheet
  static Future<void> show<T>({
    required BuildContext context,
    required SearchableDropdownController<T> controller,
    required Widget Function(T item) itemBuilder,
    required String title,
    Widget Function(T item)? selectedItemBuilder,
    required Widget Function(T item) displayStringForItemSelection,
    void Function(List<T> selectedItems)? onChanged,
  }) {

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SearchableDropdownOverlay<T>(
          controller: controller,
          itemBuilder: itemBuilder,
          title: title,
          selectedItemBuilder: selectedItemBuilder,
          displayStringForItemSelection: displayStringForItemSelection,
          onChanged: onChanged,
        ),
      ),
    );
  }

  var query = "";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchableDropdownController<T>>(
      init: controller,
      tag: controller.hashCode.toString(),
      builder: (controller) {
        return Container(
          height: 500,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with title and clear button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clearSelection();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),

              // Search input
              if (controller.config.showSearchBox)
                TextField(
                  decoration: controller.config.dropdownDecoration ?? InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: controller.config.searchTextStyle,
                  onChanged: (q){
                    query = q;
                    controller.searchWithDelay(q);
                  }
                ),

              const SizedBox(height: 10),

              // Selected items display
              Obx(() {
                if (controller.selectedItems.isNotEmpty) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: controller.selectedItems.map((item) {
                      return Chip(
                        label: selectedItemBuilder != null
                            ? selectedItemBuilder!(item)
                            : displayStringForItemSelection(item),
                        onDeleted: () => controller.toggleItemSelection(item),
                      );
                    }).toList(),
                  );
                }
                return const SizedBox.shrink();
              }),

              // Search results
              Expanded(
                child: Obx(() {
                  // Loading state
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // No results
                  if (controller.searchResults.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }

                  // Results list
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.config.isPaginationEnabled
                        ? controller.searchResults.length + 1
                        : controller.searchResults.length,
                    itemBuilder: (context, index) {
                      // Pagination loader
                      if (controller.config.isPaginationEnabled &&
                          index == controller.searchResults.length) {
                        return controller.hasMoreData.value
                            ? TextButton(
                            onPressed: (){
                              controller.loadMoreData(query);
                            } ,
                            child:  const Text('Load More')
                        )
                            : const SizedBox.shrink();
                      }

                      final item = controller.searchResults[index];
                      return ListTile(
                        title: itemBuilder(item),
                        onTap: () {
                          controller.toggleItemSelection(item);
                          onChanged?.call(controller.selectedItems);
                        },
                      );
                    },
                  );
                }),
              ),

              // Confirm button for multi-select
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    onChanged?.call(controller.selectedItems);
                    Navigator.of(context).pop();
                  },
                  label: const Text('Confirm Selection'),
                ),
            ],
          ),
        );
      },
    );
  }
}