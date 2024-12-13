import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DashboardScreenBuilder extends StatefulWidget {
    @override
    _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreenBuilder> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body:Expanded(
                child: _buildMainDashboard(),
            ),
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
                                Row(
                                    children: [
                                        IconButton(
                                            icon: Icon(Icons.search),
                                            onPressed: () {},
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.notifications_outlined),
                                            onPressed: () {},
                                        ),
                                    ],
                                ),
                            ],
                        ),

                        SizedBox(height: 30),

                        // Top Cards
                        Row(
                            children: [
                                _buildStatCard(
                                    title: 'Total Balance',
                                    value: '\$24,563.45',
                                    icon: Icons.account_balance_wallet,
                                    color: Colors.blue,
                                ),
                                SizedBox(width: 20),
                                _buildStatCard(
                                    title: 'Total Income',
                                    value: '\$5,230.00',
                                    icon: Icons.trending_up,
                                    color: Colors.green,
                                ),
                                SizedBox(width: 20),
                                _buildStatCard(
                                    title: 'Total Expenses',
                                    value: '\$3,450.75',
                                    icon: Icons.trending_down,
                                    color: Colors.red,
                                ),
                            ],
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
            child: Column(
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
                    // Transaction List
                    ...List.generate(5, (index) {
                        return ListTile(
                            leading: CircleAvatar(
                                backgroundColor: index % 2 == 0 ? Colors.green[100] : Colors.red[100],
                                child: Icon(
                                    index % 2 == 0 ? Icons.arrow_upward : Icons.arrow_downward,
                                    color: index % 2 == 0 ? Colors.green : Colors.red,
                                ),
                            ),
                            title: Text('Transaction ${index + 1}'),
                            subtitle: Text('Category Name'),
                            trailing: Text(
                                index % 2 == 0 ? '+\$1,500.00' : '-\$450.25',
                                style: TextStyle(
                                    color: index % 2 == 0 ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                        );
                    }),
                ],
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
                                _buildActionButton(Icons.person, 'Users'),
                                _buildActionButton(Icons.add, 'Level'),
                                _buildActionButton(Icons.messenger_outline, 'Chat'),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }

    Widget _buildActionButton(IconData icon, String label) {
        return Column(
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