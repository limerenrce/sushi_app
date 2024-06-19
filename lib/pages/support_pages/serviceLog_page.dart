// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/bottom_up_transition.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sushi_app/models/service.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/pages/support_pages/customersupport_page.dart';

import '../../services/data_service.dart';

class ServiceLogPage extends StatefulWidget {
  const ServiceLogPage({super.key});

  @override
  _ServiceLogPageState createState() => _ServiceLogPageState();
}

class _ServiceLogPageState extends State<ServiceLogPage> {
  Future<List<Service>>? _services;

  @override
  void initState() {
    super.initState();
    _services = DataService.fetchServices();
  }

  void _deleteService(BuildContext context, int idCustomerService) {
    debugPrint('Deleting datas with ID: $idCustomerService');
    DataService.deleteService(idCustomerService).then((value) {
      setState(() {
        _services = DataService.fetchServices();
      });
    }).catchError((error) {
      debugPrint('Failed to delete datas: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[800],
        title: const Text("Customer Support Log"),
      ),
      body: FutureBuilder<List<Service>>(
        future: _services,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Slidable(
                // Customize appearance and behavior as needed
                key: ValueKey(index),
                endActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    // SlidableAction(
                    //   // An action can be bigger than the others.
                    //   onPressed: (context) =>
                    //       form(context, data[index]),
                    //   backgroundColor: Colors.transparent,
                    //   foregroundColor: Colors.grey[800],
                    //   icon: Icons.edit,
                    //   label: 'Edit',
                    // ),
                    // SlidableAction(
                    //   // An action can be bigger than the others.
                    //   onPressed: (context) =>
                    //       delete(context, data[index].id!),
                    //   backgroundColor: Colors.transparent,
                    //   foregroundColor: primaryColor,
                    //   icon: Icons.delete,
                    //   label: 'Delete',
                    // ),
                  ],
                ), // Assuming each food has a unique id
                child: ListTile(
                  //LIST TILE OF CUSTOMER SUPPORT LOG
                  title: null,
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                fit: BoxFit.cover,
                                width: 100,
                                Uri.parse(
                                        '${Endpoints.baseURLLive}/public/${data[index].imageUrl!}')
                                    .toString(),
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons
                                        .error), // Display error icon if image fails to load
                              ),
                              const SizedBox(width: 20),

                              //RATING
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //STAR ICON
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[800],
                                  ),
                                  const SizedBox(width: 5),
                                  //RATING NUMBER
                                  Text(
                                    '${data[index].rating}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              //FOOD NAME
                              Text(
                                data[index].titleIssues,
                                style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                              ),

                              const SizedBox(height: 10),
                              //DESCRIPTION

                              Text(
                                data[index].descriptionIssues,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 36, 31, 31),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      final success = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomersupportPage(
                                                  service: data[index]),
                                        ),
                                      );
                                      if (success != null && success) {
                                        // Data was updated successfully, refresh the list
                                        setState(() {
                                          _services =
                                              DataService.fetchServices();
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteService(context,
                                          data[index].idCustomerService);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(thickness: 3),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 54, 40, 176),
        tooltip: 'Increment',
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(
              context, BottomUpRoute(page: const CustomersupportPage()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
