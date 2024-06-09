import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/theme/colors.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({Key? key}) : super(key: key);

  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  bool _isavail = true;

  void _toggleAvail() {
    setState(() {
      if (_isavail) {
        _isavail = false;
      } else {
        _isavail = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      //drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.grey[300],
        elevation: 0,
        title: const Text(
          'Sushi',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //LIST OF SUSHI
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Row(
                      children: [
                        //IMAGE
                        Image.asset(
                          'assets/images/salmon_eggs.png',
                          height: 70,
                        ),

                        const SizedBox(width: 30),

                        //NAME AND PRICE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //NAME
                            Text(
                              "Salmon Eggs",
                              style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                            ),

                            const SizedBox(height: 5),

                            //PRICE
                            Text(
                              'RP 21.000',
                              style: TextStyle(color: Colors.grey[700]),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //PEN
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ),

                                //BIN
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ),

                                //EYE
                                IconButton(
                                  onPressed: _toggleAvail,
                                  icon: (_isavail
                                      ? Icon(
                                          Icons.remove_red_eye,
                                          color: primaryColor,
                                          size: 18,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: primaryColor,
                                          size: 18,
                                        )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
