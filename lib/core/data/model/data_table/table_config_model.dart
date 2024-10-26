class TableConfigModel {
  final bool showSearch;
  final bool showPagination;
  final bool showActions;
  final List<int> rowsPerPageOptions;
  final int defaultRowsPerPage;
  
  TableConfigModel({
    this.showSearch = true,
    this.showPagination = true,
    this.showActions = true,
    this.rowsPerPageOptions = const [10, 25, 50, 100],
    this.defaultRowsPerPage = 10,
  });
}
