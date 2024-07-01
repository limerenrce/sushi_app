// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/data_service.dart';
import '../theme/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void sendRegister() async {
    final name = _nameController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await DataService.sendRegister(name, username, password);
    if (response.statusCode == 201) {
      debugPrint('Regiter success');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Register success')));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login-page');
    } else {
      debugPrint('failed ${response.statusCode}');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Register failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'Create Your Account',
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 28, color: primaryColor),
                  ),
                  Text(
                    'Create your account to start your order',
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

                  //name
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Name"),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),

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

                  const SizedBox(height: 25),

                  //SIGN UP BUTTON
                  GestureDetector(
                    onTap: () {
                      //REGISTER ACCOUNT
                      sendRegister();
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
                            "Sign Up",
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
                        "Already have an account?",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/login-page');
                        },
                        child: const Text(
                          "Login",
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
    );
  }
}
