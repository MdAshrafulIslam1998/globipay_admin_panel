import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Configuration class for customizing dropdown behavior
class SearchableDropdownConfig<T> {
  // Selection flags
  final bool isMultiSelect;
  final bool isRequired;
  final bool showSearchBox;
  final bool isPaginationEnabled;

  // Selection constraints
  final int? maxSelectedItems;
  final String? Function(List<T>?)? validator;

  // Appearance customization
  final InputDecoration? dropdownDecoration;
  final TextStyle? selectedItemStyle;
  TextStyle? searchTextStyle;

   SearchableDropdownConfig({
    this.isMultiSelect = false,
    this.isRequired = false,
    this.showSearchBox = true,
    this.isPaginationEnabled = false,
    this.maxSelectedItems,
    this.validator,
    this.dropdownDecoration,
    this.selectedItemStyle,
    this.searchTextStyle,
  });
}

/// Controller for managing dropdown state and data fetching
class SearchableDropdownController<T> extends GetxController {
  // Reactive lists for search results and selections
  final RxList<T> searchResults = <T>[].obs;
  final RxList<T> selectedItems = <T>[].obs;

  // Loading and pagination states
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxString currentQuery = ''.obs;

  // Debounce timer for search
  Timer? _debounceTimer;

  // Data fetching method and configuration
  final Future<List<T>> Function(String query, int page) fetchData;
  final SearchableDropdownConfig<T> config;

  SearchableDropdownController({
    required this.fetchData,
    required this.config,
  });

  // Static method for easy controller creation and registration
  static SearchableDropdownController<T> create<T>({
    required Future<List<T>> Function(String query, int page) fetchData,
    SearchableDropdownConfig<T>? config,
  }) {
    final controller = SearchableDropdownController<T>(
      fetchData: fetchData,
      config: config ?? SearchableDropdownConfig<T>(),
    );
    Get.put(controller, tag: controller.hashCode.toString());
    return controller;
  }

  // Clear all selected items
  void clearSelection() {
    selectedItems.clear();
  }

  // Toggle item selection based on multi/single select mode
  void toggleItemSelection(T item) {
    if (config.isMultiSelect) {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        // Check max selection limit
        if (config.maxSelectedItems != null &&
            selectedItems.length >= config.maxSelectedItems!) {
          Get.snackbar(
            'Selection Limit',
            'Maximum ${config.maxSelectedItems} items can be selected',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        selectedItems.add(item);
      }
    } else {
      // Single select mode
      selectedItems.clear();
      selectedItems.add(item);
    }
  }

  final _searchQuery = ''.obs;
  // Debounced search method
  void searchWithDelay(String query) {
    _debounceTimer?.cancel();
    currentQuery.value = query; // Save the current query

    // Reset search if query is empty
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        isLoading.value = true;

        // Reset pagination for new search
        currentPage.value = 1;

        // Fetch data
        final results = await fetchData(query, currentPage.value);

        searchResults.value = results;
        hasMoreData.value = results.isNotEmpty;
      } catch (e) {
        // Error handling
        Get.snackbar(
          'Search Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
        searchResults.clear();
      } finally {
        isLoading.value = false;
      }
    });
  }

  // Load more data for pagination
  void loadMoreData(String query) async {
    if (!config.isPaginationEnabled || !hasMoreData.value) return;

    try {
      currentPage.value++;
      final moreResults = await fetchData(query, currentPage.value);

      if (moreResults.isEmpty) {
        hasMoreData.value = false;
      } else {
        searchResults.addAll(moreResults);
      }
    } catch (e) {
      Get.snackbar(
        'Load More Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

/// Searchable Dropdown Widget
class SearchableDropdown<T> extends StatelessWidget {
  // Controller with a unique tag
  final SearchableDropdownController<T> controller;

  // Item display configuration
  final Widget Function(T item) itemBuilder;
  final Widget Function(T item)? selectedItemBuilder;
  final Widget Function(T item) displayStringForItemSelection;

  // Callbacks
  final void Function(List<T> selectedItems)? onChanged;

   const SearchableDropdown({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.selectedItemBuilder,
    required this.displayStringForItemSelection ,
    this.onChanged,
  });

  // Default string representation
  static String _defaultDisplayString<T>(T item) => item.toString();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchableDropdownController<T>>(
      init: controller,
      tag: controller.hashCode.toString(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Selected items display
            Obx(() => _buildSelectedItemsDisplay(controller)),

            // Search input
            if (controller.config.showSearchBox)
              TextField(
                decoration: controller.config.dropdownDecoration ?? const InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
                style: controller.config.searchTextStyle,
                onChanged: controller.searchWithDelay,
              ),

            // Search results
            Obx(() => _buildSearchResults(context, controller)),
          ],
        );
      },
    );
  }

  // Build selected items display
  Widget _buildSelectedItemsDisplay(SearchableDropdownController<T> controller) {
    if (controller.selectedItems.isEmpty) {
      return const SizedBox.shrink();
    }

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

  // Build search results list
  Widget _buildSearchResults(
      BuildContext context,
      SearchableDropdownController<T> controller
      ) {
    // Loading state
    if (controller.isLoading.value) {
      return const LinearProgressIndicator();
    }

    // No results
    if (controller.searchResults.isEmpty) {
      return const SizedBox.shrink();
    }

    // Results list
    return Material(
      elevation: 4,
      child: ListView.builder(
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
                onPressed: () => controller.loadMoreData(controller.currentQuery.value),
                child: const Text('Load More')
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
      ),
    );
  }
}
