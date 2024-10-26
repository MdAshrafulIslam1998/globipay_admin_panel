class TableColumnModel {
  final String key;
  final String label;
  final bool sortable;
  final double? width;

  TableColumnModel({
    required this.key,
    required this.label,
    this.sortable = false,
    this.width,
  });
}