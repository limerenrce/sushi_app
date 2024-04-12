import 'package:flutter/material.dart';
import 'package:sushi_app/components/drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        title: const Text("Profile"),
        elevation: 0,
        actions: [
          //SETTINGS BUTTON
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
