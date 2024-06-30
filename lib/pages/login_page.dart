import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/bottom_up_transition.dart';
import 'package:sushi_app/cubit/auth/auth_cubit.dart';
import 'package:sushi_app/models/login.dart';
import 'package:sushi_app/pages/url_page.dart';
import 'package:sushi_app/services/data_service.dart';
import 'package:sushi_app/theme/colors.dart';
import 'package:sushi_app/utils/constants.dart';
import 'package:sushi_app/utils/secure_storage_util.dart';

import '../cubit/profile/profile_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void sendLogin(
      context, AuthCubit authCubit, ProfileCubit profileCubit) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await DataService.sendLoginData(username, password);
    if (response.statusCode == 200) {
      debugPrint("sending success");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Successfully')));
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage
          .write(key: tokenStoreName, value: loggedIn.accessToken);
      authCubit.login(loggedIn.accessToken);
      getProfile(profileCubit, loggedIn.accessToken, context);
      //Navigator.pushReplacementNamed(context, "/menu-page");

      debugPrint(loggedIn.accessToken);
    } else {
      debugPrint('failed ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.statusCode == 400
              ? 'fill in the username and password fields'
              : 'Incorrect username or password')));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('login failed')));
    }
  }

  void getProfile(
      ProfileCubit profileCubit, String? accessToken, BuildContext context) {
    if (accessToken == null) {
      debugPrint('Access token is null');
      return;
    }

    DataService.fetchProfile(accessToken).then((profile) {
      debugPrint(profile.toString());
      profileCubit.setProfile(profile.roles, profile.userLogged);
      profile.roles == 'admin'
          ? Navigator.pushReplacementNamed(context, '/adminHome-page')
          : Navigator.pushReplacementNamed(context, '/menu-page');
    }).catchError((error) {
      debugPrint('Error fetching profile: $error');
      // Show a user-friendly message here
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  //FOOD NAME
                  Text(
                    'Welcome Back,',
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 28, color: primaryColor),
                  ),
                  Text(
                    'Login to continue your order',
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 15, color: primaryColor),
                  ),
                  //IMAGE
                  Image.asset(
                    'assets/images/chopstick.png',
                    height: 200,
                  ),

                  const SizedBox(height: 10),
                  const SizedBox(height: 25),

                  //username
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Username"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  //password
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),

                  Center(
                    child: TextButton(
                      onPressed: () => {},
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  //LOGIN BUTTON
                  GestureDetector(
                    onTap: () {
                      //GO TO MENU PAGE
                      sendLogin(context, authCubit, profileCubit);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.all(20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TEXT
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),

                          //ICON
                          // const Icon(
                          //   Icons.arrow_forward,
                          //   color: Colors.white,
                          // )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/signUp-page');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(context, BottomUpRoute(page: const UrlPage()));
        },
        child: const Icon(Icons.wifi),
      ),
    );
  }
}
