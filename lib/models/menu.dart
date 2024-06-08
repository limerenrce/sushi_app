class Menus {
  String category;
  String createdAt;
  dynamic deletedAt;
  String description;
  int idMenus;
  String imagePath;
  String name;
  int price;
  double rating;
  String updatedAt;

  Menus({
    required this.category,
    required this.createdAt,
    required this.deletedAt,
    required this.description,
    required this.idMenus,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    required this.updatedAt,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        category: json["category"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        description: json["description"],
        idMenus: json["id_menus"],
        imagePath: json["image_path"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "description": description,
        "id_menus": idMenus,
        "image_path": imagePath,
        "name": name,
        "price": price,
        "rating": rating,
        "updated_at": updatedAt,
      };
}
