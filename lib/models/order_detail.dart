import 'package:intl/intl.dart';

class OrderDetail {
  DateTime? createdAt;
  dynamic deletedAt;
  int idOrder;
  int itemTotal;
  String menuName;
  int menuPrice;
  int quantity;
  String status;
  DateTime? updatedAt;
  String username;

  OrderDetail({
    this.createdAt,
    required this.deletedAt,
    required this.idOrder,
    required this.itemTotal,
    required this.menuName,
    required this.menuPrice,
    required this.quantity,
    required this.status,
    this.updatedAt,
    required this.username,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    final DateFormat format = DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'');
    return OrderDetail(
      createdAt: json["created_at"] != null ? format.parse(json["created_at"]) : null,
      deletedAt: json["deleted_at"],
      idOrder: json["id_order"] ?? 0,
      itemTotal: json["item_total"] ?? 0,
      menuName: json["menu_name"] ?? '',
      menuPrice: json["menu_price"] ?? 0,
      quantity: json["quantity"] ?? 0,
      status: json["status"] ?? '',
      updatedAt: json["updated_at"] != null ? format.parse(json["updated_at"]) : null,
      username: json["username"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat format = DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'');
    return {
      "created_at": createdAt != null ? format.format(createdAt!) : null,
      "deleted_at": deletedAt,
      "id_order": idOrder,
      "item_total": itemTotal,
      "menu_name": menuName,
      "menu_price": menuPrice,
      "quantity": quantity,
      "status": status,
      "updated_at": updatedAt != null ? format.format(updatedAt!) : null,
      "username": username,
    };
  }

  void updateStatus(String newStatus) {
    status = newStatus;
  }
}
