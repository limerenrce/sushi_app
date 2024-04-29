import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/models/restaurant.dart';
import 'package:sushi_app/pages/cart_page.dart';
import 'package:sushi_app/pages/datas_page.dart';
import 'package:sushi_app/pages/menu_page.dart';
import 'package:sushi_app/pages/intro_page.dart';
import 'package:sushi_app/pages/profile_page.dart';
import 'package:sushi_app/theme/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //RESTAURANT PROVIDER
        ChangeNotifierProvider(
          create: (context) => Restaurant(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      routes: {
        '/intro-page': (context) => const IntroPage(),
        '/main-page': (context) => const Main(),
        '/menu-page': (context) => const MenuPage(),
        '/cart-page': (context) => const CartPage(),
        '/datas-page': (context) => const DatasPage(),
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MenuPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        elevation: 50,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
              color: primaryColor,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: primaryColor,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
