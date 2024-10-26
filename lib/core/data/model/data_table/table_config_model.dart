class TableConfigModel {
  final int rowsPerPage;
  final bool showActions;
  final bool showSearch;
  final bool showExport;
  final List<int> availablePageSizes;

  TableConfigModel({
    this.rowsPerPage = 10,
    this.showActions = true,
    this.showSearch = true,
    this.showExport = true,
    this.availablePageSizes = const [10, 25, 50, 100],
  });
}

