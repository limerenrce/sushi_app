import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/components/auth_wrapper.dart';
import 'package:sushi_app/cubit/profile/profile_cubit.dart';
import 'package:sushi_app/pages/admin_page/admin_home.dart';
import 'package:sushi_app/pages/login_page.dart';
import 'package:sushi_app/pages/signUp_page.dart';

import 'cubit/auth/auth_cubit.dart';
import 'models/restaurant.dart';
import 'pages/cart_page.dart';
import 'pages/menu_page.dart';
import 'pages/profile_page.dart';
import 'pages/splash_page.dart';
import 'pages/support_pages/serviceLog_page.dart';
import 'theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        routes: {
          '/main-page': (context) => const Main(),
          '/splash-page': (context) => const SplashPage(),
          '/login-page': (context) => const LoginPage(),
          '/signUp-page': (context) => const SignUpPage(),
          //'/menu-page': (context) => MenuPage(),
          //'/cart-page': (context) => CartPage(),

          '/menu-page': (context) => const AuthWrapper(child: MenuPage()),
          '/cart-page': (context) => const AuthWrapper(child: CartPage()),
          '/adminHome-page': (context) => const AuthWrapper(child: AdminHome()),
          '/services-page': (context) =>
              const AuthWrapper(child: ServiceLogPage()),
        },
      ),
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
