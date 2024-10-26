class TableColumnModel {
  final String label;
  final String key;
  final bool sortable;
  final bool visible;
  final double? width;
  
  TableColumnModel({
    required this.label,
    required this.key,
    this.sortable = true,
    this.visible = true,
    this.width,
  });
}