import 'package:flutter/material.dart';
import 'package:sushi_app/components/drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/flat_img.png'),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Text(
                  'Satya Uttami',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  'uttami@gmail.com',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Center(
                child:
                    TextButton(onPressed: () {}, child: Text('Edit Profile'))),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            NumbersWidget(),
                            const SizedBox(height: 48),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 48),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'About',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'like to eat!',
                                    style: TextStyle(fontSize: 16, height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4.8', 'Ranking'),
          buildDivider(),
          buildButton(context, '35', 'Following'),
          buildDivider(),
          buildButton(context, '50', 'Followers'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
