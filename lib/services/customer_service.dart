import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sushi_app/dto/service.dart';
import 'package:sushi_app/endpoints/endpoints.dart';

class CustomerService {
  // Get Method
  static Future<List<Service>> fetchServices() async {
    final response = await http.get(Uri.parse(Endpoints.service));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return (jsonResponse['datas'] as List<dynamic>)
          .map((item) => Service.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  // Delete Method
  static Future<void> deleteService(int id) async {
    final response = await http.delete(
      Uri.parse('${Endpoints.service}/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete service');
    }
  }
}
