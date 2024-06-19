import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/theme/colors.dart';

class AdminAddMenu extends StatefulWidget {
  const AdminAddMenu({Key? key}) : super(key: key);

  @override
  _AdminAddMenuState createState() => _AdminAddMenuState();
}

class _AdminAddMenuState extends State<AdminAddMenu> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedOption1;
  File? galleryFile;
  final picker = ImagePicker();

  double _rating = 0;

  //Rating
  static Future<void> sendRating(double rating) async {
    final response = await http.post(
      Uri.parse(Endpoints.service),
      body: {'rating': rating.toString()},
    );

    if (response.statusCode == 200) {
      print('Rating sent successfully!');
    } else {
      print('Error sending rating: ${response.statusCode}');
    }
  }

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
  void saveData() {
    debugPrint(_titleController.text);
  }

  // Widget build for UI
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
                  textAlign: TextAlign
                      .center, // Menengahkan teks (termasuk placeholder)
                  decoration: InputDecoration(
                    hintText: "Menu Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors
                        .white, // Menambahkan warna background putih di dalam outline
                    filled:
                        true, // Mengaktifkan warna background yang ditentukan oleh fillColor
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
                  onChanged: (value) {
                    // Update state on text change
                    setState(() {
                      // No need to update _title here, just use _titleController.text directly
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownButtonFormField<String>(
                  value: _selectedOption1,
                  hint: Center(
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  textAlign: TextAlign
                      .center, // Menengahkan teks (termasuk placeholder)
                  decoration: InputDecoration(
                    hintText: "Price",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors
                        .white, // Menambahkan warna background putih di dalam outline
                    filled:
                        true, // Mengaktifkan warna background yang ditentukan oleh fillColor
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
                  onChanged: (value) {
                    // Update state on text change
                    setState(() {
                      // No need to update _price here, just use _priceController.text directly
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  textAlign: TextAlign
                      .center, // Menengahkan teks (termasuk placeholder)
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors
                        .white, // Menambahkan warna background putih di dalam outline
                    filled:
                        true, // Mengaktifkan warna background yang ditentukan oleh fillColor
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 60.0), // Menambah tinggi TextField
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
                  onChanged: (value) {
                    // Update state on text change
                    setState(() {
                      // No need to update _price here, just use _priceController.text directly
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              //-----R A T I N G-----

              Center(
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                    sendRating(rating);
                  },
                ),
              ),

              SizedBox(height: 20),
              // Center(
              //   child: galleryFile == null
              //       ? Text(
              //           "No image selected",
              //           style: TextStyle(color: Colors.grey),
              //         )
              //       : Image.file(
              //           galleryFile!,
              //           height: 200,
              //           width: 200,
              //           fit: BoxFit.cover,
              //         ),
              // ),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white, // Background putih
                  borderRadius: BorderRadius.circular(8), // Sudut yang membulat
                  border: Border.all(
                    color: Colors.grey.shade200, // Warna border yang serupa
                    width: 2.0, // Lebar border
                  ),
                ),
                // Mengatur padding internal untuk membuat Container lebih tinggi
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(
                    // Mengatur agar konten berada di tengah
                    child: galleryFile == null
                        ? Text(
                            "Insert Image",
                            style: TextStyle(color: Colors.grey), // Warna teks
                          )
                        : Image.file(
                            galleryFile!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover, // Menutupi kotak dengan gambar
                          ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              //OKAY BUTTON
              GestureDetector(
                onTap: () {
                  //POP ONCE TO REMOVE DIALOG BOX
                  Navigator.pop(context);

                  //POP AGAIN TO GO TO PREVIOUS SCREEN
                  // Navigator.pop(context);
                },
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose(); // Dispose of controllers when widget is removed
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
