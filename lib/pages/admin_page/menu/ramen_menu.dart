import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/pages/admin_page/admin_addMenu.dart';
import 'package:sushi_app/theme/colors.dart';

import '../../../endpoints/endpoints.dart';
import '../../../models/menu.dart';
import '../../../services/data_service.dart';

class RamenMenu extends StatefulWidget {
  const RamenMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RamenMenuState createState() => _RamenMenuState();
}

class _RamenMenuState extends State<RamenMenu> {
  Future<List<Menus>>? _menu;

  @override
  void initState() {
    super.initState();
    _menu = DataService.fetchMenus('ramen');
  }

  //FAVORITE BUTTON
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
          width: 350,
          height: 200,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(Icons.delete, color: primaryColor, size: 60),
              const SizedBox(height: 8),
              const Text(
                "Are you sure you want to delete?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  //POP ONCE TO REMOVE DIALOG BOX
                  Navigator.pop(context); 
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40), border: Border.all(color: primaryColor)), 
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 20, left: 20),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TEXT
                      Text(
                        "Cancel",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              //DELETE BUTTON
              GestureDetector(
                onTap: okayDelete,
                
                // (){
                //   //DELETE THE MENU
                //   okayDelete;

                //   //POP ONCE TO REMOVE DIALOG BOX
                //  // Navigator.pop(context); 
                // },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(40)),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 20, left: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TEXT
                      Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  //ADD TO CART
  void okayDelete() { 
    //LET THE USER KNOW IT WAS SUCCESSFUL 
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 350,
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
              Navigator.pop(context);
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.grey[300],
        elevation: 0,
        title: const Text(
          'Ramen',
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Menus>>(
          future: _menu,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(109, 140, 94, 91),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else if (snapshot.hasData) {
              final menu = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(menu.length, (index) {
                    final item = menu[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin:
                          const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          // IMAGE
                          Image.network(
                            '${Endpoints.ngrok}/${item.imagePath}',
                            height: 80,
                          ),
                          const SizedBox(width: 30),
                          // NAME AND PRICE
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // NAME
                                Text(
                                  item.name,
                                  style:
                                      GoogleFonts.dmSerifDisplay(fontSize: 18),
                                ),
                                const SizedBox(height: 5),
                                // PRICE
                                Text(
                                  '${item.price}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // EDIT BUTTON
                                    IconButton(
                                      onPressed: () {
                                        // Navigate to edit screen
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
                                    // DELETE BUTTON
                                    IconButton(
                                      onPressed: () => deleteMenu(),
                                      icon: Icon(
                                        Icons.delete,
                                        color: primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                    // TOGGLE AVAILABILITY BUTTON
                                    IconButton(
                                      onPressed: () => _toggleAvail,
                                      icon: Icon(
                                        _isavail
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                        color: primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(109, 140, 94, 91),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
