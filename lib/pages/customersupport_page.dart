import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/pages/serviceLog_page.dart';
import 'package:sushi_app/theme/colors.dart';

class CustomersupportPage extends StatefulWidget {
  const CustomersupportPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomersupportPageState createState() => _CustomersupportPageState();
}

class _CustomersupportPageState extends State<CustomersupportPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _title = "";
  String _description = "";

  File? galleryFile;
  final picker = ImagePicker();

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
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
  }

  Future<void> _postDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.datas));
    request.fields['name'] = _titleController.text; // Add other data fields

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pushReplacementNamed(context, '/datas-screen');
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  double _rating = 0;

  //Rating
  static Future<void> sendRating(double rating) async {
    // Replace with your actual API URL and endpoint
    const String url = 'https://your-api.com/ratings';

    final response = await http.post(
      Uri.parse(url),
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
        title: const Text("Customer Support"),
      ),
      // ignore: sized_box_for_whitespace
      body: Column(
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServiceLogPage(),
                      ),
                    );
                  },
                  child: Text("See your previous log"),
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
                    children: [
                      //-----T I T L E   I S S U E-----
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade200))),
                        child: Column(
                          children: [
                            Text(
                              "Problem Title",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                  hintText: "Type here....",
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
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity, // Fill available space
                            height: 175, // Adjust height as needed
                            // color: Colors.grey[200], // Placeholder color
                            child: galleryFile == null
                                ? Center(
                                    child: Text('Pick your Image here',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[600],
                                        )))
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

                      //-----D E S K R I P S I   I S S U E-----
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade200))),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: "Problem Description",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {
          _postDataWithImage(context);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
