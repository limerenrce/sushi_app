// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/bottom_up_transition.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sushi_app/dto/datas.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/pages/datas_page.dart';
import 'package:sushi_app/pages/form_page.dart';
import 'package:sushi_app/services/data_service.dart';

class DataDetailScreen extends StatelessWidget {
  final Datas data;

  const DataDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.imageUrl != null)
              Image.network(
                Uri.parse('${Endpoints.baseURLLive}/public/${data.imageUrl!}')
                    .toString(),
                fit: BoxFit.fitWidth,
                width: 350,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            SizedBox(height: 20),
            Text(
              'Name: ${data.name}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ID: ${data.idDatas}',
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the edit screen when edit button is pressed
                    // Navigator.push(
                    //   context,
                    //   //MaterialPageRoute(
                    //     //builder: (context) => EditDataScreen(data: data),
                    //   //),
                    // );
                  },
                  child: Text('Edit'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    // Confirm and delete data when delete button is pressed
                    final bool confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Data'),
                        content:
                            Text('Are you sure you want to delete this data?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                await DataService.deleteDatas(data.idDatas);
                                // After successful deletion, navigate back to the previous screen
                                Navigator.of(context).pop(true);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete data: $e'),
                                  ),
                                );
                              }
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      // Show snackbar or navigate back
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DatasPage(),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Data deleted successfully'),
                        ),
                      );
                    }
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
