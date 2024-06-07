import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sushi_app/endpoints/endpoints.dart';

import '../dto/service.dart';
import '../utils/constants.dart';
import '../utils/secure_storage_util.dart';

class DataService {
  //  LOGIN //
  static Future<http.Response> sendLoginData(
      String username, String password) async {
    final url = Uri.parse(Endpoints.login);
    final data = {'username': username, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return response;
  }

  // LOGOUT //
  static Future<http.Response> LogoutData() async {
    final url = Uri.parse(Endpoints.logout);
    final String? accessToken =
        await SecureStorageUtil.storage.read(key: tokenStoreName);
    debugPrint("Logout with $accessToken");

    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    return response;
  }

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
