import 'package:flutter/material.dart';

/**
 * Created by Abdullah on 20/1/25.
 */
/*class CategoryDisplay extends StatelessWidget {
  final String rawData;

  const CategoryDisplay({super.key, required this.rawData});

  @override
  Widget build(BuildContext context) {
    final categories = parseCategories(rawData);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade50,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.category,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTotalItem(
                          'Primary Total',
                          category.primaryTotal,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTotalItem(
                          'Secondary Total',
                          category.secondaryTotal,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '0' : value,
            style: TextStyle(
              fontSize: 16,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}*/
/*class CategoryDisplay extends StatelessWidget {
  final String rawData;

  const CategoryDisplay({super.key, required this.rawData});

  @override
  Widget build(BuildContext context) {
    final categories = parseCategories(rawData);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildCompactTotal(
                    'Primary',
                    category.primaryTotal,
                    Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildCompactTotal(
                    'Secondary',
                    category.secondaryTotal,
                    Colors.green,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompactTotal(String label, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$label: ',
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.8),
                ),
              ),
              Text(
                value.isEmpty ? '0' : value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}*/

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