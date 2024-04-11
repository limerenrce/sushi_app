//FOOD ITEMS
class Food {
  final String name;
  final String price;
  final String imagePath;
  final String rating;
  final String description;
  final FoodCategory category;

  Food(
      {required this.name,
      required this.price,
      required this.imagePath,
      required this.rating,
      required this.description,
      required this.category});

  String get _name => name;
  String get _price => price;
  String get _imagePath => imagePath;
  String get _rating => rating;
  String get _description => description;
}

//FOOD CATEGORIES
enum FoodCategory {
  sushi,
  ramen,
  drink,
}
