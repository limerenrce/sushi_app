class Service {
  final int idCustomerService;
  final String nim;
  final String titleIssues;
  final String descriptionIssues;
  final int rating;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Service({
    required this.idCustomerService,
    required this.nim,
    required this.titleIssues,
    required this.descriptionIssues,
    required this.rating,
    this.imageUrl,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      idCustomerService: json["id_customer_service"] as int,
      nim: json["nim"] as String,
      titleIssues: json["title_issues"] as String,
      descriptionIssues: json["description_issues"] as String,
      rating: json["rating"] as int,
      imageUrl: json["image_url"] as String?,
      createdAt: DateTime.parse(json["created_at"] as String),
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"] as String)
          : null,
      deletedAt: json["deleted_at"] != null
          ? DateTime.parse(json["deleted_at"] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id_customer_service": idCustomerService,
        "nim": nim,
        "title_issues": titleIssues,
        "description_issues": descriptionIssues,
        "rating": rating,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
