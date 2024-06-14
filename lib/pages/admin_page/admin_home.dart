import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/pages/admin_page/admin_addMenu.dart';
import 'package:sushi_app/theme/colors.dart';

import '../../components/bottom_up_transition.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Text(
          'Hi, Admin',
          textAlign: TextAlign.center,
        ),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //PROMO BANNER
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      "January's Sales Recap",
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sushi",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "143",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ramen",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "47",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Drinks",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "90",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "280",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              //Menu Category
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Menu Category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //IMAGE
                              Image.asset(
                                'assets/images/salmon_sushi.png',
                                height: 105,
                              ),
                              SizedBox(height: 8),

                              //TEXT
                              Text(
                                "Sushi",
                                style: GoogleFonts.dmSerifDisplay(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //IMAGE
                              Image.asset(
                                'assets/images/ramen_tori.png',
                                height: 105,
                              ),
                              SizedBox(height: 8),

                              //TEXT
                              Text(
                                "Ramen",
                                style: GoogleFonts.dmSerifDisplay(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(left: 25),
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //IMAGE
                              Image.asset(
                                'assets/images/orange_juice.png',
                                height: 105,
                              ),
                              SizedBox(height: 8),

                              //TEXT
                              Text(
                                "Drinks",
                                style: GoogleFonts.dmSerifDisplay(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(context, BottomUpRoute(page: const AdminAddMenu()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
