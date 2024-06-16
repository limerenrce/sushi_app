import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:sushi_app/endpoints/endpoints.dart';

import '../models/menu.dart';
import '../models/service.dart';
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

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<Response> makeLoginRequest(Map<String, dynamic> data) async {
    final Dio dio = Dio();
    return dio.post(
      Endpoints.login, // Use HTTPS
      data: data,
    );
  }
  //Future<Map<String, dynamic>> fetchUserData() async {

  // final token = Provider.of<TokenProvider>(context, listen: false).token;
  // final userId = Provider.of<TokenProvider>(context, listen: false).userId;

  // Dio dio = Dio();
  // final response = await dio.get(
  //   'http://10.0.2.2:1432/GetProfileOfCurrentUser/$userId',
  //   options: Options(
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json', // Adjust content type as needed
  //     },
  //   ),
  // );

  // if (response.statusCode == 200) {
  //   return response.data;
  // } else {
  //   throw Exception('Failed to load user data');
  // }
  // }

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

  // GET SERVICE
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

  // DELETE SERVICE
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

  // GET MENUS
  static Future<List<Menus>> getMenu() async {
    final response = await http.get(Uri.parse(Endpoints.menus));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Menus.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }
}
