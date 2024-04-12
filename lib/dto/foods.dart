class Foods {
  late int? id;
  late String name;
  late String price;
  late String rating;
  late String description;
  late String category;

  Foods(this.id, this.name, this.price, this.rating, this.description,
      this.category);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'description': description,
      'category': category,
    };
    return map;
  }

  Foods.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    rating = map['rating'];
    description = map['description'];
    category = map['category'];
  }
}
