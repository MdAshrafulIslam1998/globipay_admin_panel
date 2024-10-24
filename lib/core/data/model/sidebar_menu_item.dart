class SidebarMenuItem {
  final String title;
  final String route;
  final dynamic icon;
  final List<SidebarMenuItem>? subItems;

  const SidebarMenuItem({
    required this.title,
    required this.route,
    required this.icon,
    this.subItems,
  });
}