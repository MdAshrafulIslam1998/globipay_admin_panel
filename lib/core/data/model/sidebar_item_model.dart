class SidebarItemModel {
  final String title;
  final String route;
  final String? icon;
  final List<SidebarItemModel>? children;

  SidebarItemModel({
    required this.title,
    required this.route,
    this.icon,
    this.children,
  });
}