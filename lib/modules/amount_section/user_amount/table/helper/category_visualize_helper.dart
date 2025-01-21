import 'package:flutter/material.dart';

/**
 * Created by Abdullah on 20/1/25.
 */

class CategoryDisplay extends StatelessWidget {
  final String rawData;

  const CategoryDisplay({super.key, required this.rawData});

  @override
  Widget build(BuildContext context) {
    final categories = parseCategories(rawData);

    return Column(
      children: [
        // Header Row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  '#',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Primary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Secondary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Data Rows
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.category,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: _buildValue(category.primaryTotal, Colors.blue)),
                    ),
                    Expanded(
                      child: _buildValue(category.secondaryTotal, Colors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildValue(String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.3,
        ),
      ),
      child: Text(
        value.isEmpty ? '0' : value,
        style: TextStyle(
          fontSize: 13,
          color: color,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
class CategoryData {
  final String category;
  final String primaryTotal;
  final String secondaryTotal;

  CategoryData({
    required this.category,
    required this.primaryTotal,
    required this.secondaryTotal,
  });
}

List<CategoryData> parseCategories(String input) {
  List<CategoryData> categories = [];

  // Split by newline
  final lines = input.split('\n');

  for (var line in lines) {
    // Split category and values
    final parts = line.split(':');

    // Skip if category is null or 'null'
    if (parts[0] == 'null' || parts[0].isEmpty) continue;

    // Extract category
    final category = parts[0].trim();

    // Extract primary and secondary totals
    final values = parts.sublist(1).join(':').split('|');
    final primaryTotal = RegExp(r'primary_total:\s*(\d+)')
        .firstMatch(values[0])
        ?.group(1) ?? '';
    final secondaryTotal = RegExp(r'secondary_total:\s*(\d+)')
        .firstMatch(values[1])
        ?.group(1) ?? '';

    categories.add(CategoryData(
      category: category,
      primaryTotal: primaryTotal,
      secondaryTotal: secondaryTotal,
    ));
  }

  return categories;
}