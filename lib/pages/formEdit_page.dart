import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sushi_app/dto/datas.dart';
import 'package:sushi_app/services/data_service.dart';

class FormEditPage extends StatefulWidget {
  final Datas data;

  const FormEditPage({Key? key, required this.data}) : super(key: key);

  @override
  _FormEditPageState createState() => _FormEditPageState();
}

class _FormEditPageState extends State<FormEditPage> {
  late TextEditingController _nameController;
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.name);
    _initializeImage();
    // You may want to initialize _image here with the existing image
  }

  Future<void> _initializeImage() async {
    if (widget.data.imageUrl != null) {
      // Download the image from the URL
      final response = await http.get(Uri.parse(widget.data.imageUrl!));
      if (response.statusCode == 200) {
        // Convert the image to a File object
        setState(() {
          _image = File(widget.data.imageUrl); // Provide the actual path
        });
      } else {
        // Handle error when downloading image
        print('Failed to download image: ${response.statusCode}');
      }
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
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          _image = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Text('No image selected.'),
            // ElevatedButton(
            //   onPressed: _getImage,
            //   child: Text('Select Image'),
            // ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateData();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateData() {
    String newName = _nameController.text;
    widget.data.name = newName; // Update the data object
    DataService.updateData(widget.data).then((value) {
      Navigator.pop(context, true); // Pop the page and indicate success
    }).catchError((error) {
      // Handle error
      print('Failed to update data: $error');
      Navigator.pop(context, false); // Pop the page and indicate failure
    });
  }
}
