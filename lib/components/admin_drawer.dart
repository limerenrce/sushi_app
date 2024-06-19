import 'package:flutter/material.dart';
import 'package:sushi_app/pages/admin_page/admin_home.dart';
import 'package:sushi_app/pages/admin_page/admin_menu.dart';
import 'package:sushi_app/pages/admin_page/admin_orderList.dart';
import 'package:sushi_app/pages/login_page.dart';
import 'package:sushi_app/pages/support_pages/customersupport_page.dart';
import 'package:sushi_app/theme/colors.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          //APP LOGO
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.sailing,
              size: 80,
              color: primaryColor,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(color: secondaryColor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "CUSTOMER SUPPORT",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.support_agent,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomersupportPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "LOG OUT",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "Admin Menu",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminMenu(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "Admin Home",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminHome(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "Admin Order List",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminOrderList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
