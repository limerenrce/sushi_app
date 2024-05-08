import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sushi_app/dto/service.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/pages/serviceLog_page.dart';
import 'package:sushi_app/theme/colors.dart';

class CustomersupportPage extends StatefulWidget {
  final Service? service;

  const CustomersupportPage({super.key, this.service});

  @override
  // ignore: library_private_types_in_public_api
  _CustomersupportPageState createState() => _CustomersupportPageState();
}

class _CustomersupportPageState extends State<CustomersupportPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nimController = TextEditingController();
  final _idController = TextEditingController();

  late String _id;
  late String _nim;
  late String _title;
  late String _description;

  File? galleryFile = null;
  final picker = ImagePicker();

  double _rating = 0;

  String? _selectedDivision;
  String? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedDivision = 'IT';
    _selectedPriority = 'Low';
    _id = '';
    _nim = '';
    _title = '';
    _description = '';
    // Pre-fill fields with received data if available (for edit mode)
    if (widget.service != null) {
      _idController.text = widget.service!.idCustomerService.toString();
      _titleController.text = widget.service!.titleIssues;
      _descriptionController.text = widget.service!.descriptionIssues;
      _nimController.text = widget.service!.nim;
      _rating = widget.service!.rating.toDouble();
    }
  }

  _showPicker({
    required BuildContext context,
  }) {
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

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose(); // Dispose of controller when widget is removed
    _descriptionController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  //Post
  Future<void> _postDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.service));
    request.fields['title_issues'] = _titleController.text;
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['nim'] = _nimController.text;
    request.fields['rating'] = _rating.toString();

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pushReplacementNamed(context, '/services-page');
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
        // Add additional error handling if needed
      }
    }).catchError((error) {
      debugPrint('Error posting data: $error');
      // Handle error if request.send() fails
    });
  }

  //Update
  Future<void> _putDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = http.MultipartRequest('POST',
        Uri.parse('${Endpoints.service}/${widget.service!.idCustomerService}'));
    request.fields['title_issues'] = _titleController.text;
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['nim'] = _nimController.text;
    request.fields['rating'] = _rating.toString();

    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('Data and image updated successfully!');
      Navigator.pushReplacementNamed(context, '/services-page');
    } else {
      debugPrint('Error posting data: ${response.statusCode}');
      // Add additional error handling if needed
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        title: Text(
            widget.service != null ? 'Edit Support Log' : 'Customer Support'),
      ),
      // ignore: sized_box_for_whitespace
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Get support for your inconvenience",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Let us know every problem you encounter. We are always ready to help. Add picture to enhance our understanding about your problem.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Learn more",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ServiceLogPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "See your previous log",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //-----N   I   M-----
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextField(
                              controller: _nimController,
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 138, 60, 55),
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  labelText: "NIM",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 138, 60, 55)),
                                  hintText: "Input NIM here..",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                              onChanged: (value) {
                                // Update state on text change
                                setState(
                                  () {
                                    _nim =
                                        value; // Update the _title state variable
                                  },
                                );
                              },
                            ),
                          ),

                          //-----D I V I S I O N-----
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: DropdownButton<String>(
                              value: _selectedDivision,
                              hint: Text('Select a division'),
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 138, 60, 55)),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDivision = newValue;
                                });
                              },
                              items: <String?>[
                                'IT',
                                'Billing',
                                'Help Desk',
                              ].map<DropdownMenuItem<String>>((String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value!),
                                );
                              }).toList(),
                            ),
                          ),

                          //-----P R I O R I T Y-----
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: DropdownButton<String>(
                              hint: Text('Select a priority'),
                              value: _selectedPriority,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 138, 60, 55)),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPriority = newValue;
                                });
                              },
                              items: <String?>[
                                'Low',
                                'Medium',
                                'High'
                              ].map<DropdownMenuItem<String>>((String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value!),
                                );
                              }).toList(),
                            ),
                          ),

                          //-----T I T L E   I S S U E-----
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                      labelText: "Issue Title",
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 138, 60, 55)),
                                      hintText: "Input title here..",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    // Update state on text change
                                    setState(() {
                                      _title =
                                          value; // Update the _title state variable
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          //-----U P L O A D   I M A G E-----
                          GestureDetector(
                            onTap: () {
                              _showPicker(context: context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: double.infinity, // Fill available space
                                height: 175, // Adjust height as needed
                                // color: Colors.grey[200], // Placeholder color
                                child: galleryFile == null
                                    ? Center(
                                        child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey,
                                        size: 50,
                                      ))
                                    : Center(
                                        child: Image.file(galleryFile!),
                                      ), // Placeholder text
                              ),
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
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
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

                          //-----D E S K R I P S I   I S S U E-----
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  labelText: "Problem Description",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 138, 60, 55)),
                                  hintText: "Input description here..",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                              onChanged: (value) {
                                // Update state on text change
                                setState(
                                  () {
                                    _description =
                                        value; // Update the _title state variable
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {
          // Determine whether to create or update based on received data
          if (widget.service != null) {
            // Update mode
            _putDataWithImage(context);
          } else {
            // Create mode
            _postDataWithImage(context);
          }
        },
        child: Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
