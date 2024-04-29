// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_app/components/bottom_up_transition.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sushi_app/dto/datas.dart';
import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/pages/dataDetail_page.dart';
import 'package:sushi_app/pages/formEdit_page.dart';
import 'package:sushi_app/pages/form_page.dart';
import 'package:sushi_app/services/data_service.dart';

class DatasPage extends StatefulWidget {
  const DatasPage({Key? key}) : super(key: key);

  @override
  _DatasPageState createState() => _DatasPageState();
}

class _DatasPageState extends State<DatasPage> {
  Future<List<Datas>>? _datas;

  @override
  void initState() {
    super.initState();
    _datas = DataService.fetchDatas();
  }

  // void _deleteDatas(int index) async {
  //   List<Datas> datas = await _datas!;
  //   await DataService.deleteData(datas[index].idDatas);
  //   setState(() {
  //     _datas = DataService.fetchDatas();
  //   });
  // }

  void _deleteDatas(BuildContext context, int idDatas) {
    print('Deleting datas with ID: $idDatas');
    DataService.deleteDatas(idDatas).then((value) {
      setState(() {
        _datas = DataService.fetchDatas();
      });
    }).catchError((error) {
      print('Failed to delete datas: $error');
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List'),
        leading: IconButton(
          icon: const Icon(Icons
              .arrow_back), // Customize icon (optional)// Customize color (optional)
          onPressed: () {
            // Your custom back button functionality here
            Navigator.pushReplacementNamed(
                context, '/'); // Default back button behavior
            // You can add additional actions here (e.g., show confirmation dialog)
          },
        ),
      ),
      body: FutureBuilder<List<Datas>>(
        future: _datas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Slidable(
                // Customize appearance and behavior as needed
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
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
                  title: data[index].imageUrl != null
                      ? Row(
                          children: [
                            Image.network(
                              fit: BoxFit.fitWidth,
                              width: 350,
                              Uri.parse(
                                      '${Endpoints.baseURLLive}/public/${data[index].imageUrl!}')
                                  .toString(),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons
                                      .error), // Display error icon if image fails to load
                            ),
                          ],
                        )
                      : null,
                  subtitle: Column(children: [
                    Text('Name : ${data[index].name}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 36, 31, 31),
                          fontWeight: FontWeight.normal,
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final success = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormEditPage(data: data[index]),
                              ),
                            );
                            if (success != null && success) {
                              // Data was updated successfully, refresh the list
                              setState(() {
                                _datas = DataService.fetchDatas();
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteDatas(context, data[index].idDatas);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                  ]),
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
          Navigator.push(context, BottomUpRoute(page: const FormPage()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
