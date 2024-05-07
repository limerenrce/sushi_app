import 'package:flutter/material.dart';
import 'package:sushi_app/pages/customersupport_page.dart';
import 'package:sushi_app/pages/datas_page.dart';
import 'package:sushi_app/pages/food_page.dart';
import 'package:sushi_app/pages/news_page.dart';
import 'package:sushi_app/pages/serviceLog_page.dart';
import 'package:sushi_app/theme/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
                "API NEWS",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.api,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "API DATAS",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.api,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DatasPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "CRUD SQLITE",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.table_rows_rounded,
                color: Colors.grey[600],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodsPage(),
                  ),
                );
              },
            ),
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
                    builder: (context) => CustomersupportPage(),
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
