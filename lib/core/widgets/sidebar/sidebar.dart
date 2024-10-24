import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/router/route_names.dart';

class Sidebar extends StatelessWidget {
  final String currentRoute;

  const Sidebar({Key? key, required this.currentRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).primaryColor.withOpacity(0.95),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Logo or Brand
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Admin Panel',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(color: Colors.white24),
          // Menu Items
          _buildMenuItem(
            context: context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            route: RouteNames.dashboard,
            isSelected: currentRoute == RouteNames.dashboard,
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.receipt_long,
            title: 'Transactions',
            route: RouteNames.transactionHistory,
            isSelected: currentRoute == RouteNames.transactionHistory,
          ),
          const Spacer(),
          // Bottom items
          const Divider(color: Colors.white24),
          _buildMenuItem(
            context: context,
            icon: Icons.settings,
            title: 'Settings',
            route: RouteNames.settings,
            isSelected: currentRoute == RouteNames.settings,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          if (!isSelected) {
            context.goNamed(route);
          }
        },
        selected: isSelected,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}