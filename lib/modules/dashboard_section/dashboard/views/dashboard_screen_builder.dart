import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/core/theme/app_colors.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
import 'package:globipay_admin_panel/data/services/message_listener.dart';
import 'package:globipay_admin_panel/data/services/supabase_service.dart';
import 'package:globipay_admin_panel/modules/dashboard_section/dashboard/controller/dashboard_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

class DashboardScreenBuilder extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState
    extends BaseViewState<DashboardScreenBuilder, DashboardController> {
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  void dispose() {
    MessagesListener().dispose();
    super.dispose();
  }

  @override
  Widget body(BuildContext context) {

    return Scaffold(
      body: _buildMainDashboard(),
    );
  }

  Widget _buildMainDashboard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard Overview',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Top Cards
            Obx(
              () => Row(
                children: [
                  _buildStatCard(
                    title: 'Total Transaction',
                    value:
                        '${controller.dashboardBalance.value?.total_transactions.toCurrencyFormat() ?? 0.0}',
                    icon: Icons.account_balance_wallet,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 20),
                  _buildStatCard(
                    title: 'Total Primary',
                    value:
                        '${controller.dashboardBalance.value?.total_primary.toCurrencyFormat() ?? 0.0}',
                    icon: Icons.trending_up,
                    color: Colors.green,
                  ),
                  SizedBox(width: 20),
                  _buildStatCard(
                    title: 'Total Secondary',
                    value:
                        '${controller.dashboardBalance.value?.total_secondary.toCurrencyFormat() ?? 0.0}',
                    icon: Icons.trending_down_outlined,
                    color: Colors.red,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Detailed Sections
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Transactions Section
                Expanded(
                  flex: 3,
                  child: _buildTransactionsSection(),
                ),

                SizedBox(width: 20),

                // Quick Actions and Chat
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildQuickActionsSection(),
                      SizedBox(height: 20),
                      _buildRecentChatsSection(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 40),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('View All'),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.recentTransactions.value.length,
                itemBuilder: (context, index) {
                  final item = controller.recentTransactions.value[index];
                  return ListTile(
                    leading: const Icon(Icons.monetization_on, color: Colors.green),
                    title: Text(item.name ?? ''),
                    subtitle: Text(
                        controller.recentTransactions[index].categoryName ??
                            ''),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.primaryAmount.toCurrencyFormat() ?? '',
                          style:  TextStyle(color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          item.secondaryAmount.toCurrencyFormat(),
                          style: TextStyle(color: Colors.green[400]),
                        ),
                      ],
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(Icons.person, 'Users', onTap: () {
                  AppRoutes.pushNamed(RoutePath.activeUsersNew);
                }),
                _buildActionButton(Icons.add, 'Level', onTap: () {
                  AppRoutes.pushNamed(RoutePath.userLevels);
                }),
                _buildActionButton(Icons.messenger_outline, 'Chat', onTap: () {
                  AppRoutes.pushNamed(RoutePath.chatMessageList);

                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(15),
            child: Icon(icon, color: Colors.deepPurple),
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildRecentChatsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Chats',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('View All'),
                ),
              ],
            ),
          ),
          // Chat List
          ...List.generate(4, (index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
              title: Text('Contact Name'),
              subtitle: Text('Last message preview...'),
              trailing: Text(
                '2m ago',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }),
        ],
      ),
    );
  }
}
