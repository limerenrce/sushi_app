import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sushi_app/dto/news.dart';
import 'package:sushi_app/endpoints/endpoints.dart';

class DataService {
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      //Handle error
      throw Exception('Failed to load News');
    }
  }

  static Future<News> addNews(String title, String body) async {
    final response = await http.post(
      Uri.parse(Endpoints.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      return News.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add News');
    }
  }

  static Future<News> editNews(String id, String title, String body) async {
    final response = await http.put(
      Uri.parse('${Endpoints.news}/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      return News.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to edit News');
    }
  }

  static Future<void> deleteNews(String id) async {
    final response = await http.delete(
      Uri.parse('${Endpoints.news}/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete News');
    }
  }
}
