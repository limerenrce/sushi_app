import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/components/auth_wrapper.dart';
import 'package:sushi_app/cubit/cart/cart_cubit.dart';
import 'package:sushi_app/cubit/profile/profile_cubit.dart';
import 'package:sushi_app/cubit/search/search_cubit.dart';
import 'package:sushi_app/pages/admin_page/admin_addMenu.dart';
import 'package:sushi_app/pages/admin_page/admin_home.dart';
import 'package:sushi_app/pages/admin_page/admin_orderList.dart';
import 'package:sushi_app/pages/admin_page/menu/ramen_menu.dart';
import 'package:sushi_app/pages/admin_page/menu/sides_menu.dart';
import 'package:sushi_app/pages/admin_page/menu/sushi_menu.dart';
import 'package:sushi_app/pages/login_page.dart';
import 'package:sushi_app/pages/signUp_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'cubit/auth/auth_cubit.dart';
import 'pages/cart_page.dart';
import 'pages/menu_page.dart';
import 'pages/profile_page.dart';
import 'pages/splash_page.dart';
import 'pages/support_pages/serviceLog_page.dart';
import 'theme/colors.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  _requestLocalNotifPermision();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Request permission to receive notifications (Android only)
  if (defaultTargetPlatform == TargetPlatform.android) {
    NotificationSettings? settings = await messaging.requestPermission();
    debugPrint("${settings.authorizationStatus}");
  }

  // Listen to incoming messages in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "Received message in foreground: ${message.notification?.title}");
    // Use this data to display a notification or take other actions
    _showNotification(message);
    debugPrint("show notification here");
  });

  // Listen to incoming messages when the app is in background or terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint(
        "Received message when app was closed: ${message.notification?.title}");
    // Handle notification tap event (optional)
  });

  // Get the registration token for this device
  String? token = await messaging.getToken();
  debugPrint("Registration token: $token");
  runApp(const MyApp());
}

Future<void> _requestLocalNotifPermision() async {
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await androidImplementation?.requestNotificationsPermission();
}

void _showNotification(RemoteMessage message) {
  // Customize notification based on your needs
  RemoteNotification? notification = message.notification;
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('sushiman-app-1', 'sushiman-app',
          channelDescription: 'Only for demonstrate notification',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  if (notification != null) {
    flutterLocalNotificationsPlugin.show(notification.hashCode,
        notification.title, notification.body, notificationDetails);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        // BlocProvider<MenuCubit>(create: (context) => MenuCubit()),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        routes: {
          '/main-page': (context) => const Main(),
          '/splash-page': (context) => const SplashPage(),
          '/login-page': (context) => const LoginPage(),
          '/signUp-page': (context) => const SignUpPage(),
          '/menu-page': (context) => const AuthWrapper(child: MenuPage()),
          '/cart-page': (context) => const AuthWrapper(child: CartPage()),
          '/adminHome-page': (context) => const AuthWrapper(child: AdminHome()),
          '/adminSushi-page': (context) =>
              const AuthWrapper(child: SushiMenu()),
          '/adminRamen-page': (context) =>
              const AuthWrapper(child: RamenMenu()),
          '/adminSides-page': (context) =>
              const AuthWrapper(child: SidesMenu()),
          '/adminAddMenu-page': (context) =>
              const AuthWrapper(child: AdminAddMenu()),
          '/adminOrderList-page': (context) =>
              const AuthWrapper(child: AdminOrderList()),
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
