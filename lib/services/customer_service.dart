import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sushi_app/dto/service.dart';
import 'package:sushi_app/endpoints/endpoints.dart';

class CustomerService {
  static Future<List<Service>> fetchService() async {
    final response = await http.get(Uri.parse(Endpoints.service));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['service'] as List<dynamic>)
          .map((item) => Service.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }
}
