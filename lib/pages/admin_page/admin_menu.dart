import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/pages/admin_page/admin_addMenu.dart';
import 'package:sushi_app/theme/colors.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  //ADD TO CART
  void deleteMenu() {
    //LET THE USER KNOW IT WAS SUCCESSFUL
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              Icon(Icons.restore_from_trash,
                  color: Colors.green[800], size: 78),
              const SizedBox(height: 8),
              const Text(
                "Are you sure you want to delete?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "You can not restore the item",
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
              Text(
                "once you delete it.",
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          //OKAY BUTTON
          Row(
            children: [
              GestureDetector(
                onTap: okayDelete,
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(40)),
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  padding: const EdgeInsets.all(15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TEXT
                      Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //POP ONCE TO REMOVE DIALOG BOX
                  Navigator.pop(context);

                  //POP AGAIN TO GO TO PREVIOUS SCREEN
                  // Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(40)),
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  padding: const EdgeInsets.all(15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TEXT
                      Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //ADD TO CART
  void okayDelete() {
    //ONLY ADD TO CART IF THERE IS SOMETHING IN THE CART

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              Icon(Icons.check_circle_outline,
                  color: Colors.green[800], size: 78),
              const SizedBox(height: 8),
              const Text(
                "Menu delete successful",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Menu has been successfully deleted",
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          //OKAY BUTTON
          GestureDetector(
            onTap: () {
              //POP ONCE TO REMOVE DIALOG BOX
              Navigator.pop(context);

              //POP AGAIN TO GO TO PREVIOUS SCREEN
              // Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(40)),
              margin: const EdgeInsets.only(left: 50, right: 50),
              padding: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TEXT
                  Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminAddMenu(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ),

                                //BIN
                                IconButton(
                                  onPressed: deleteMenu,
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
