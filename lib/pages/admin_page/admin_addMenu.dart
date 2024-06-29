// ignore_for_file: file_names, unused_element, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sushi_app/theme/colors.dart';
import 'package:sushi_app/services/data_service.dart';

class AdminAddMenu extends StatefulWidget {
  const AdminAddMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminAddMenuState createState() => _AdminAddMenuState();
}

class _AdminAddMenuState extends State<AdminAddMenu> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedOption1;
  File? galleryFile;
  final picker = ImagePicker();

  double _rating = 0;

  // Method to show the bottom sheet for image picking
  void _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to get image from camera or gallery
  Future<void> getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    setState(() {
      if (pickedFile != null) {
        galleryFile = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  // Method to save data
  void saveData() async {
    final name = _titleController.text;
    final category = _selectedOption1 ?? '';
    final price = _priceController.text;
    final description = _descriptionController.text;
    final rating = _rating.toString();

    if (name.isEmpty ||
        category.isEmpty ||
        price.isEmpty ||
        description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields')),
      );
      return;
    }

    try {
      final response = await DataService.createMenus(
        name,
        price,
        rating,
        description,
        category,
        galleryFile,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Menu created successfully')),
        );
        Navigator.pop(context); // Navigate back after successful creation
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create menu')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        title: const Text(
          'New Menu',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Menu Name",
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownButtonFormField<String>(
                  value: _selectedOption1,
                  hint: const Center(
                    child: Text(
                      "Category",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption1 = newValue;
                    });
                  },
                  items: <String>['Sushi', 'Ramen', 'Drinks']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _priceController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Price",
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _descriptionController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(
                    child: galleryFile == null
                        ? const Text(
                            "Insert Image",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Image.file(
                            galleryFile!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: saveData,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(40)),
                    padding: const EdgeInsets.all(15),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ok",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:sushi_app/endpoints/endpoints.dart';
// import 'package:sushi_app/models/menu.dart';
// import 'package:sushi_app/services/data_service.dart';
// import 'package:sushi_app/theme/colors.dart';

// class AdminAddMenu extends StatefulWidget {
//   const AdminAddMenu({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AdminAddMenuState createState() => _AdminAddMenuState();
// }

// class _AdminAddMenuState extends State<AdminAddMenu> {
//   // final _titleController = TextEditingController();
//   // final _categoryController = TextEditingController();
//   // final _priceController = TextEditingController();

//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();

//   String? _selectedOption1;
//   File? galleryFile;
//   final picker = ImagePicker();

//   double _rating = 0;

//   //Rating
//   static Future<void> sendRating(double rating) async {
//     final response = await http.post(
//       Uri.parse(Endpoints.service),
//       body: {'rating': rating.toString()},
//     );

//     if (response.statusCode == 200) {
//       debugPrint('Rating sent successfully!');
//     } else {
//       debugPrint('Error sending rating: ${response.statusCode}');
//     }
//   }

//   // Method to show the bottom sheet for image picking
//   void _showPicker({required BuildContext context}) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Photo Library'),
//                 onTap: () {
//                   getImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   getImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to get image from camera or gallery
//   Future<void> getImage(ImageSource img) async {
//     final pickedFile = await picker.pickImage(source: img);
//     setState(() {
//       if (pickedFile != null) {
//         galleryFile = File(pickedFile.path);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Nothing is selected')),
//         );
//       }
//     });
//   }

//   // Method to save data
//   void saveData() async {
//     // Create a new menu object
//     final newMenu = Menus(
//       category: _selectedOption1 ?? '',
//       createdAt: DateTime.now().toIso8601String(),
//       deletedAt: null,
//       description: _descriptionController.text,
//       idMenus: 0, // This will be set by the backend
//       imagePath: '',
//       name: _titleController.text,
//       price: int.parse(_priceController.text),
//       rating: _rating,
//       updatedAt: DateTime.now().toIso8601String(),
//     );

//     // Call the service to add the menu
//     final success = await DataService.createMenu(newMenu, galleryFile);
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Menu added successfully')),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to add menu')),
//       );
//     }
//   }

//   // Method to save data
//   // void saveData() {
//   //   debugPrint(_titleController.text);
//   // }

//   // Widget build for UI
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey[800],
//         elevation: 0,
//         title: const Text(
//           'New Menu',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: _titleController,
//                   textAlign: TextAlign
//                       .center, // Menengahkan teks (termasuk placeholder)
//                   decoration: InputDecoration(
//                     hintText: "Menu Name",
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     fillColor: Colors
//                         .white, // Menambahkan warna background putih di dalam outline
//                     filled:
//                         true, // Mengaktifkan warna background yang ditentukan oleh fillColor
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     // Update state on text change
//                     setState(() {
//                       // No need to update _title here, just use _titleController.text directly
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: DropdownButtonFormField<String>(
//                   value: _selectedOption1,
//                   hint: const Center(
//                     child: Text(
//                       "Category",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedOption1 = newValue;
//                     });
//                   },
//                   items: <String>['Sushi', 'Ramen', 'Drinks']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   decoration: InputDecoration(
//                     isDense: true,
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 12),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: _priceController,
//                   textAlign: TextAlign
//                       .center, // Menengahkan teks (termasuk placeholder)
//                   decoration: InputDecoration(
//                     hintText: "Price",
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     fillColor: Colors
//                         .white, // Menambahkan warna background putih di dalam outline
//                     filled:
//                         true, // Mengaktifkan warna background yang ditentukan oleh fillColor
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     // Update state on text change
//                     setState(() {
//                       // No need to update _price here, just use _priceController.text directly
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: _descriptionController,
//                   textAlign: TextAlign
//                       .center, // Menengahkan teks (termasuk placeholder)
//                   decoration: InputDecoration(
//                     hintText: "Description",
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     fillColor: Colors
//                         .white, // Menambahkan warna background putih di dalam outline
//                     filled:
//                         true, // Mengaktifkan warna background yang ditentukan oleh fillColor
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 60.0), // Menambah tinggi TextField
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     // Update state on text change
//                     setState(() {
//                       // No need to update _price here, just use _priceController.text directly
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               //-----R A T I N G-----

//               Center(
//                 child: RatingBar.builder(
//                   initialRating: _rating,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: false,
//                   itemCount: 5,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {
//                     setState(() {
//                       _rating = rating;
//                     });
//                     sendRating(rating);
//                   },
//                 ),
//               ),

//               const SizedBox(height: 20),
//               // Center(
//               //   child: galleryFile == null
//               //       ? Text(
//               //           "No image selected",
//               //           style: TextStyle(color: Colors.grey),
//               //         )
//               //       : Image.file(
//               //           galleryFile!,
//               //           height: 200,
//               //           width: 200,
//               //           fit: BoxFit.cover,
//               //         ),
//               // ),

//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white, // Background putih
//                   borderRadius: BorderRadius.circular(8), // Sudut yang membulat
//                   border: Border.all(
//                     color: Colors.grey.shade200, // Warna border yang serupa
//                     width: 2.0, // Lebar border
//                   ),
//                 ),
//                 // Mengatur padding internal untuk membuat Container lebih tinggi
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 60.0),
//                   child: Center(
//                     // Mengatur agar konten berada di tengah
//                     child: galleryFile == null
//                         ? const Text(
//                             "Insert Image",
//                             style: TextStyle(color: Colors.grey), // Warna teks
//                           )
//                         : Image.file(
//                             galleryFile!,
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.cover, // Menutupi kotak dengan gambar
//                           ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),
//               //OKAY BUTTON
//               GestureDetector(
//                 onTap: () {
//                   //POP ONCE TO REMOVE DIALOG BOX
//                   saveData();

//                   //POP AGAIN TO GO TO PREVIOUS SCREEN
//                   // Navigator.pop(context);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(40)),
//                     padding: const EdgeInsets.all(15),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         //TEXT
//                         Text(
//                           "Ok",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                         SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _titleController.dispose(); // Dispose of controllers when widget is removed
//     _descriptionController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }
// }


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:sushi_app/endpoints/endpoints.dart';
// import 'package:sushi_app/models/menu.dart';
// import 'package:sushi_app/services/data_service.dart';
// import 'package:sushi_app/theme/colors.dart';

// class AdminAddMenu extends StatefulWidget {
//   const AdminAddMenu({super.key});

//   @override
//   _AdminAddMenuState createState() => _AdminAddMenuState();
// }

// class _AdminAddMenuState extends State<AdminAddMenu> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();

//   String? _selectedOption1;
//   File? galleryFile;
//   final picker = ImagePicker();
//   double _rating = 0;

//   static Future<void> sendRating(double rating) async {
//     final response = await http.post(
//       Uri.parse(Endpoints.service),
//       body: {'rating': rating.toString()},
//     );

//     if (response.statusCode == 200) {
//       debugPrint('Rating sent successfully!');
//     } else {
//       debugPrint('Error sending rating: ${response.statusCode}');
//     }
//   }

//   void _showPicker({required BuildContext context}) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Photo Library'),
//                 onTap: () {
//                   getImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   getImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> getImage(ImageSource img) async {
//     final pickedFile = await picker.pickImage(source: img);
//     setState(() {
//       if (pickedFile != null) {
//         galleryFile = File(pickedFile.path);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Nothing is selected')),
//         );
//       }
//     });
//   }

//   void saveData() async {
//     try {
//       final newMenu = Menus(
//         category: _selectedOption1 ?? '',
//         createdAt: DateTime.now().toIso8601String(),
//         deletedAt: null,
//         description: _descriptionController.text,
//         idMenus: 0,
//         imagePath: '',
//         name: _titleController.text,
//         price: int.parse(_priceController.text),
//         rating: _rating,
//         updatedAt: DateTime.now().toIso8601String(),
//       );

//       final success = await DataService.createMenu(newMenu, galleryFile);
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Menu added successfully')),
//         );
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to add menu')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey[800],
//         elevation: 0,
//         title: const Text(
//           'New Menu',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: _titleController,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     hintText: "Menu Name",
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: DropdownButtonFormField<String>(
//                   value: _selectedOption1,
//                   hint: const Center(
//                     child: Text(
//                       "Category",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedOption1 = newValue;
//                     });
//                   },
//                   items: <String>['Sushi', 'Ramen', 'Drinks']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   decoration: InputDecoration(
//                     isDense: true,
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 12),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: _priceController,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     hintText: "Price",
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: _descriptionController,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     hintText: "Description",
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     fillColor: Colors.white,
//                     filled: true,
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 60.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: RatingBar.builder(
//                   initialRating: _rating,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: false,
//                   itemCount: 5,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {
//                     setState(() {
//                       _rating = rating;
//                     });
//                     sendRating(rating);
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: Colors.grey.shade200,
//                     width: 2.0,
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 60.0),
//                   child: Center(
//                     child: galleryFile == null
//                         ? const Text(
//                             "Insert Image",
//                             style: TextStyle(color: Colors.grey),
//                           )
//                         : Image.file(
//                             galleryFile!,
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: saveData,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(40)),
//                     padding: const EdgeInsets.all(15),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Ok",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                         SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }
// }
