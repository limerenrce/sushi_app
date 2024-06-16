import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/button.dart';
import 'package:sushi_app/cubit/auth/auth_cubit.dart';
import 'package:sushi_app/models/login.dart';
import 'package:sushi_app/services/data_service.dart';
import 'package:sushi_app/theme/colors.dart';
import 'package:sushi_app/utils/constants.dart';
import 'package:sushi_app/utils/secure_storage_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void sendLogin(context, AuthCubit authCubit) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await DataService.sendLoginData(username, password);
      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final loggedIn = Login.fromJson(data);
        await SecureStorageUtil.storage
            .write(key: tokenStoreName, value: loggedIn.accessToken);
        authCubit.login(loggedIn.accessToken);
        Navigator.pushReplacementNamed(context, "/menu-page");
      } else {
        debugPrint(
            "Failed to login: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Error sending login data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
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
                  TextField(
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
                  ),

                  const SizedBox(height: 25),

                  //password
                  TextField(
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
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: Text(
                      "Forgot password",
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),

                  const SizedBox(height: 25),

                  //GET STARTED BUTTON
                  MyButton(
                    text: "Login",
                    onTap: () {
                      //GO TO MENU PAGE
                      sendLogin(context, authCubit);
                    },
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
                      SizedBox(width: 5),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
