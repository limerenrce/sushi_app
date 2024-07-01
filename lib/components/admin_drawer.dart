import 'package:flutter/material.dart';
import 'package:sushi_app/pages/admin_page/admin_orderList.dart'; 
import 'package:sushi_app/theme/colors.dart';

import '../services/data_service.dart';
import '../utils/constants.dart';
import '../utils/secure_storage_util.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  
  Future<void> doLogout(context) async {
    
    final response = await DataService.logoutData();
    if (response.statusCode == 200) {
      await SecureStorageUtil.storage.delete(key: tokenStoreName);
     debugPrint('logout success');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Bye bye!')));
      Navigator.pushReplacementNamed(context, '/login-page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: SafeArea(
        child: SingleChildScrollView(
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
                    "Order List",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  leading: Icon(
                    Icons.menu_book,
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
              const SizedBox(height: 500),
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
                    doLogout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
