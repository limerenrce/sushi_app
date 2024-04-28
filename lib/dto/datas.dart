class Datas {
  int idDatas;
  String name;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Datas({
    required this.idDatas,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        idDatas: json["id_datas"],
        name: json["name"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_datas": idDatas,
        "name": name,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
