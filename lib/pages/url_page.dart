// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sushi_app/endpoints/endpoints.dart';
// import 'package:sushi_app/theme/colors.dart';
// import 'package:sushi_app/utils/secure_storage_util.dart';

// class UrlPage extends StatefulWidget {
//   const UrlPage({super.key});

//   @override
//   State<UrlPage> createState() => _UrlPageState();
// }

// class _UrlPageState extends State<UrlPage> {
//   final _urlController = TextEditingController();

//   @override
//   void dispose() {
//     _urlController.dispose();
//     super.dispose();
//   }

//   void sendUrl() async {
//     if (_urlController.text.isNotEmpty) {
//       await SecureStorageUtil.storage
//           .write(key: "url_setting", value: _urlController.text);
//       await Endpoints.initialize();
//       //ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Input saved: ${_urlController.text}')),
//       );
//       _urlController.clear();
//       // ignore: use_build_context_synchronously
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter the url')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.grey[300],
//       ),
//       body: Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(width: 10),
//                   Image.asset(
//                     'assets/images/ramen_tori.png',
//                     height: 120,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Unlock Your Sushi Man Culinary',
//                           style: GoogleFonts.dmSerifDisplay(
//                             fontSize: 44,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           "Input URL API",
//                           style: TextStyle(
//                             fontStyle: FontStyle.italic,
//                             fontSize: 28,
//                             color: Colors.grey[200],
//                             height: 2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               padding: const EdgeInsets.all(30),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextField(
//                         controller: _urlController,
//                         decoration: InputDecoration(
//                           hintText: 'Input your URL here',
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 20),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide.none,
//                           ),
//                           prefixIcon: const Icon(Icons.wifi),
//                         ),
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                       const SizedBox(height: 30),
//                       //ORDER NOW BUTTON
//                       GestureDetector(
//                         onTap: () => sendUrl(), // Pass context to orderNow
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.circular(40)),
//                           margin: const EdgeInsets.only(left: 40, right: 40),
//                           padding: const EdgeInsets.all(20),
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               //TEXT
//                               Text(
//                                 "Submit",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 16),
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../endpoints/endpoints.dart';
import '../theme/colors.dart';
import '../utils/secure_storage_util.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({super.key});

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void sendUrl() async {
    if (_urlController.text.isNotEmpty) {
      await SecureStorageUtil.storage
          .write(key: "url_setting", value: _urlController.text);
      await Endpoints.initialize();
      //ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Input saved: ${_urlController.text}')),
      );
      _urlController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          'Connect to API',
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'To establish a secure connection, please enter your URL below',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        // Text(
                        //   "Input URL API",
                        //   style: TextStyle(
                        //     fontStyle: FontStyle.italic,
                        //     fontSize: 28,
                        //     color: Colors.grey[200],
                        //     height: 2,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: 'Input your URL here',
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.wifi),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
                //SUBMIT BUTTON
                GestureDetector(
                  onTap: () => sendUrl(), // Pass context to orderNow
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(40)),
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //TEXT
                        Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
