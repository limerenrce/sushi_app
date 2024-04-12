import 'package:flutter/material.dart';
import 'package:sushi_app/dto/foods.dart';
import 'package:sushi_app/services/db_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sushi_app/theme/colors.dart';

class FoodsPage extends StatefulWidget {
  const FoodsPage({super.key});

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Foods>>? foods;
  late String _name;
  late String _price;
  late String _rating;
  late String _description;
  late String _category;
  bool isUpdate = false;
  late int? foodIdForUpdate;
  late DBHelper dbHelper;
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _ratingController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshFoodLists();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    dbHelper.close();
    super.dispose();
  }

  void cancelTextEditing() {
    _nameController.text = '';
    _priceController.text = '';
    _ratingController.text = '';
    _descriptionController.text = '';
    _categoryController.text = '';
    setState(() {
      isUpdate = false;
      foodIdForUpdate = null;
    });
    closeKeyboard();
  }

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> refreshFoodLists() async {
    try {
      await dbHelper.initDatabase();
      setState(() {
        foods = dbHelper.getFoods();
        isUpdate = false;
      });
    } catch (error) {
      debugPrint('Error fetching foods: $error');
    }
  }

  void createOrUpdateFoods() {
    _formStateKey.currentState?.save();
    if (!isUpdate) {
      dbHelper
          .add(Foods(null, _name, _price, _rating, _description, _category));
    } else {
      dbHelper.update(Foods(
          foodIdForUpdate, _name, _price, _rating, _description, _category));
    }
    _nameController.text = '';
    _priceController.text = '';
    _ratingController.text = '';
    _descriptionController.text = '';
    _categoryController.text = '';
    refreshFoodLists();
  }

  void editFormFood(BuildContext context, Foods food) {
    setState(() {
      isUpdate = true;
      foodIdForUpdate = food.id!;
    });
    _nameController.text = food.name;
    _priceController.text = food.price;
    _ratingController.text = food.rating;
    _descriptionController.text = food.description;
    _categoryController.text = food.category;
  }

  void deleteFood(BuildContext context, int foodID) {
    setState(() {
      isUpdate = false;
    });
    _nameController.text = '';
    _priceController.text = '';
    _ratingController.text = '';
    _descriptionController.text = '';
    _categoryController.text = '';
    dbHelper.delete(foodID);
    refreshFoodLists();
  }

  @override
  Widget build(BuildContext context) {
    var nameFormField = TextFormField(
      onSaved: (value) {
        _name = value!;
      },
      autofocus: false,
      controller: _nameController,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isUpdate ? primaryColor : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid)),
          labelText: !isUpdate ? 'Add Name' : 'Edit Name',
          fillColor: Colors.white,
          labelStyle: TextStyle(color: !isUpdate ? primaryColor : Colors.blue),
          hintText: "Fill food name here.."),
    );
    var priceFormField = TextFormField(
      onSaved: (value) {
        _price = value!;
      },
      autofocus: false,
      controller: _priceController,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isUpdate ? primaryColor : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid)),
          labelText: !isUpdate ? 'Add Price' : 'Edit Price',
          fillColor: Colors.white,
          labelStyle: TextStyle(color: !isUpdate ? primaryColor : Colors.blue),
          hintText: "Example: 20.000"),
    );
    var ratingFormField = TextFormField(
      onSaved: (value) {
        _rating = value!;
      },
      autofocus: false,
      controller: _ratingController,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isUpdate ? primaryColor : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid)),
          labelText: !isUpdate ? 'Add Rating' : 'Edit Rating',
          fillColor: Colors.white,
          labelStyle: TextStyle(color: !isUpdate ? primaryColor : Colors.blue),
          hintText: "Example: 4.5"),
    );

    var descriptionFormField = TextFormField(
      onSaved: (value) {
        _description = value!;
      },
      autofocus: false,
      controller: _descriptionController,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isUpdate ? primaryColor : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid)),
          labelText: !isUpdate ? 'Add Description' : 'Edit Description',
          fillColor: Colors.white,
          labelStyle: TextStyle(color: !isUpdate ? primaryColor : Colors.blue),
          hintText: "Fill description here.."),
    );

    var categoryFormField = TextFormField(
      onSaved: (value) {
        _category = value!;
      },
      autofocus: false,
      controller: _categoryController,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isUpdate ? primaryColor : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid)),
          labelText: !isUpdate ? 'Add Category' : 'Edit Category',
          fillColor: Colors.white,
          labelStyle: TextStyle(color: !isUpdate ? primaryColor : Colors.blue),
          hintText: "Sushi / Ramen / Drink"),
    );
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey[800],
          title: const Text("CRUD Food List"),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
                key: _formStateKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          nameFormField,
                          priceFormField,
                          ratingFormField,
                          descriptionFormField,
                          categoryFormField,
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        createOrUpdateFoods();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isUpdate
                            ? primaryColor
                            : Colors.blue, // Set background color
                        foregroundColor: Colors.white,
                      ),
                      child: !isUpdate
                          ? const Text('Save')
                          : const Text('Update')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        cancelTextEditing();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor, // Set background color
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cancel')),
                ],
              ),
            ),
            Text(
              "Food List",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey[800],
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: foods,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('No Data');
                }
                if (snapshot.hasData) {
                  return generateList(snapshot.data!);
                }
                return const CircularProgressIndicator();
              },
            ))
          ],
        ));
  }

  Widget generateList(List<Foods> foods) {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) => Slidable(
        // Customize appearance and behavior as needed
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) => editFormFood(context, foods[index]),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.grey[800],
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) => deleteFood(context, foods[index].id!),
              backgroundColor: Colors.transparent,
              foregroundColor: primaryColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ), // Assuming each food has a unique id
        child: ListTile(
          title: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //IMAGE
                    // Image.asset(
                    //   'assets/images/salmon_eggs.png',
                    //   height: 60,
                    // ),

                    const SizedBox(width: 20),

                    //NAME AND PRICE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //NAME
                        Text(
                          foods[index].name,
                          // style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                        ),

                        const SizedBox(height: 10),

                        //PRICE
                        Text(
                          foods[index].price,
                          style: TextStyle(color: Colors.grey[700]),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                    ),
                    Text(
                      foods[index].rating,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
