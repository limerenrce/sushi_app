import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sushi_app/endpoints/endpoints.dart';

import '../models/menu.dart';
import '../models/profile.dart';
import '../models/service.dart';
import '../utils/constants.dart';
import '../utils/secure_storage_util.dart';

class DataService {
  // --------------- MODUL AUTH & PRETECTED PROFILE -------------------- //

  // LOGIN //
  static Future<http.Response> sendLoginData(
      String username, String password) async {
    final url = Uri.parse(Endpoints.login);
    // final data = {'username': username, 'password': password};

    final Map<String, dynamic> data = {
      'username': username,
      'password': password
    };

    final response = await http.post(url, body: data);
    debugPrint("Response: ${{response.statusCode}}");

    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(data),
    // );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  // PROTECTED GET PROFILE //
  static Future<Profile> fetchProfile(String? accessToken) async {
    accessToken ??= await SecureStorageUtil.storage.read(key: tokenStoreName);

    final response = await http.get(
      Uri.parse(Endpoints.profile),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    debugPrint('Profile response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body);
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }

      try {
        return Profile.fromJson(jsonResponse);
      } catch (e) {
        throw Exception('Failed to parse Profile: $e');
      }
    } else {
      // Handle error
      throw Exception(
          'Failed to load Profile with status code: ${response.statusCode}');
    }
  }

  //REGISTER NEW ACCOUNT //
  static Future<http.Response> sendRegister(
      String name, String username, String password) async {
    final url = Uri.parse(Endpoints.register);
    //final data = {'name': name, 'username': username, 'password': password};

    final Map<String, dynamic> data = {
      'name': name,
      'username': username,
      'password': password
    };

    // final response = await http.post(
    //   url,
    //   body: data,
    // );

    final response = await http.post(url, body: data);
    debugPrint("Response: ${{response.statusCode}}");

    return response;
  }

  // LOGOUT //
  static Future<http.Response> logoutData() async {
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

  // --------------- MODUL MENU -------------------- //

  // GET MENUS //
  static Future<List<Menus>> fetchMenus() async {
    final response = await http.get(Uri.parse(Endpoints.getMenus));
    debugPrint("Response: ${{response.statusCode}}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Menus.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load menu');
    }
  }

  // POST NEW MENU //
  static Future<http.Response> createMenus(
      String name,
      String price,
      String rating,
      String description,
      String category,
      File? imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Endpoints.createMenus), // Ganti dengan URL endpoint Anda
      );

      request.fields['name'] = name;
      request.fields['price'] = price;
      request.fields['rating'] = rating;
      request.fields['description'] = description;
      request.fields['category'] = category;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gambar',
            imageFile.path,
          ),
        );
      }

      var response = await request.send();
      return http.Response.fromStream(response);
    } catch (e) {
      throw Exception('Failed to create menu: $e');
    }
  }

  // UPDATE EXISTING MENU //
  static Future<http.Response> updateMenus(
      int idMenus,
      String name,
      String price,
      String rating,
      String description,
      String category,
      File? imageFile) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${Endpoints.updateMenus}$idMenus'),
      );

      request.fields['name'] = name;
      request.fields['price'] = price;
      request.fields['rating'] = rating;
      request.fields['description'] = description;
      request.fields['category'] = category;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gambar',
            imageFile.path,
          ),
        );
      }

      var response = await request.send();
      return http.Response.fromStream(response);
    } catch (e) {
      throw Exception('Failed to update menu: $e');
    }
  }

  // DELETE MENU //
  static Future<http.Response> deleteMenus(int idMenus) async {
    final url = Uri.parse('${Endpoints.deleteMenus}$idMenus');
    final response = await http.delete(url);
    return response;
  }

  // --------------- MODUL CUSTOMER SUPPORT -------------------- //

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
}
