// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart'; 
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; 
import 'package:image_picker/image_picker.dart'; 
import 'package:sushi_app/theme/colors.dart';
import 'package:sushi_app/services/data_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../endpoints/endpoints.dart';
import '../../models/menu.dart';

class AdminUpdatemenu extends StatefulWidget {
  final Menus menu;
  const AdminUpdatemenu({super.key, required this.menu});

  @override
  // ignore: library_private_types_in_public_api
  _AdminUpdatemenuState createState() => _AdminUpdatemenuState();
}

class _AdminUpdatemenuState extends State<AdminUpdatemenu> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedOption1;
  String? _imagePath; // Store the image path or URL
  File? galleryFile; // Remove the initialization here
  final picker = ImagePicker();

  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.menu.name;
    _selectedOption1 = widget.menu.category;
    _priceController.text = widget.menu.price.toString(); // Convert price to string
    _descriptionController.text = widget.menu.description;
    _rating = widget.menu.rating;
    _imagePath = '${Endpoints.ngrok}/${widget.menu.imagePath}'; // Store the imagePath or URL

    // If _imagePath is a URL, cache the image with cached_network_image
    if (_imagePath != null && _imagePath!.startsWith('http')) {
      // Using cached_network_image to fetch and cache network images
      galleryFile = null; // Clear galleryFile since we're fetching from network
    } else {
      galleryFile = File(_imagePath!); // Assuming _imagePath is a local file path
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

  Future getImage(ImageSource img) async {
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
  void saveData(BuildContext context) async {
    final name = _titleController.text;
    final category = _selectedOption1 ?? '';
    final price = _priceController.text;
    final description = _descriptionController.text;
    final rating = _rating.toString();
    final imagePath = galleryFile?.path;

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
        imagePath,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Menu created successfully')),
        );
        Navigator.pop(context); // Navigate back after successful creation
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to create menu: ${response.statusCode} ${response.reasonPhrase}\n${response.body}')),
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
          'Update Menu',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => _showPicker(context: context),
                  child: Container(
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
                            ? const Icon(Icons.photo, size: 100, color: Colors.grey,)
                            : _imagePath != null && _imagePath!.startsWith('http')
                                ? CachedNetworkImage(
                                    imageUrl: _imagePath!,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
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
                ),
              ),

              //--------------------RATING------------
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

              // --------------- MENU NAME --------------------
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  " Menu Name",
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Insert menu name here",
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
              const SizedBox(height: 8),

              // --------------------CATEGORY------------------------
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  " Category",
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // Set the background color of the dropdown button
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade200, // Optional border color
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedOption1,
                    dropdownColor: Colors
                        .white, // Set the dropdown background color to white
                    style: const TextStyle(
                        color:
                            Colors.black), // Set text color of dropdown items
                    hint: const Center(
                      child: Text(
                        "Category",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption1 = newValue;
                      });
                    },
                    items: <String>['Sushi', 'Ramen', 'Sides']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration( 
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      border: InputBorder
                          .none, // Remove border from the input decoration
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),


              // -------------------- PRICE------------------------
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  " Price",
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
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
              const SizedBox(height: 8),


              // -------------------- PRICE------------------------
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  " Description",
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
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
              
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => saveData(context),
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
