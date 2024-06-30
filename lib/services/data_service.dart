import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sushi_app/endpoints/endpoints.dart';
import 'package:sushi_app/models/order_detail.dart';

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
  static Future<List<Menus>> fetchMenus(String category) async {
    String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
        Uri.parse('${Endpoints.getMenus}/$category'),
        headers: {'Authorization': 'Bearer $token'});
    debugPrint("Response: ${{response.statusCode}}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['data'] as List<dynamic>)
          .map((item) => Menus.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      debugPrint("Error response body: ${response.body}");
      throw Exception('Failed to load menu: ${response.reasonPhrase}');
    }
  }

  // POST NEW MENU //

  static Future<http.Response> createMenus(
    String name,
    String price,
    String rating,
    String description,
    String category,
    String? imagePath,
  ) async {
    try {
      // Fetch the token from secure storage
      String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

      if (token == null) {
        throw Exception('Token not found');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Endpoints.createMenus),
      );

      // Set the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add the fields
      request.fields['name'] = name;
      request.fields['price'] = price;
      request.fields['rating'] = rating;
      request.fields['description'] = description;
      request.fields['category'] = category;
      if (imagePath != null) {
        final multipartFile =
            await http.MultipartFile.fromPath('image', imagePath);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      // Debug prints
      debugPrint('Request URL: ${Endpoints.createMenus}');
      debugPrint('Request Headers: ${request.headers}');
      debugPrint('Request Fields: ${request.fields}');

      // Check for status codes and handle accordingly
      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('Response status ${response.statusCode}');
        // debugPrint("success");
        return http.Response.fromStream(response);
      } else {
        throw Exception(
            'Failed to create menu: ${response.statusCode} ${response.reasonPhrase}');
      }
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
      String? imagePath) async {
    try {
      // Fetch the token from secure storage
      String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

      if (token == null) {
        throw Exception('Token not found');
      }

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${Endpoints.updateMenus}/$idMenus'),
      );

      // Set the headers
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['name'] = name;
      request.fields['price'] = price;
      request.fields['rating'] = rating;
      request.fields['description'] = description;
      request.fields['category'] = category;

      if (imagePath != null) {
        final multipartFile =
            await http.MultipartFile.fromPath('image', imagePath);
        request.files.add(multipartFile);
      }

      var response = await request.send();
      // Debug prints
      debugPrint('Request URL: ${Endpoints.updateMenus}');
      debugPrint('Request Headers: ${request.headers}');
      debugPrint('Request Fields: ${request.fields}');

      // Check for status codes and handle accordingly
      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('Response status ${response.statusCode}');
        // debugPrint("success");
        return http.Response.fromStream(response);
      } else {
        throw Exception(
            'Failed to create menu: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to create menu: $e');
    }
  }

  // DELETE MENU //
  static Future<http.Response> deleteMenu(int idMenus) async {
  try {
    // Fetch the token from secure storage
    String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

    if (token == null) {
      throw Exception('Token not found');
    }

    var request = http.MultipartRequest(
      'PUT', Uri.parse('${Endpoints.deleteMenus}/$idMenus'),
    );

    // Set the headers
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200 ) {
      debugPrint('Soft deleted menu successfully. Status ${response.statusCode}');
      // Convert the streamed response to a http.Response
      return http.Response.fromStream(response);
    } else {
      throw Exception('Failed to soft delete menu: ${response.statusCode} ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to delete menu: $e');
  }
}

  //---------------- MODUL ORDERS ----------------

  //GET ORDERS
  Future<List<OrderDetail>> fetchOrder() async {
    String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse(Endpoints.getOrders),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => OrderDetail.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      debugPrint("Error response body: ${response.body}");
      throw Exception('Failed to load orders: ${response.reasonPhrase}');
    }
  }

  //UPDATE ORDERS
//   Future<void> updateOrderStatus(int orderId) async {
//   String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

//     if (token == null) {
//       throw Exception('Token not found');
//     }

//   final Uri uri = Uri.parse('${Endpoints.updateOrders}/$orderId');
//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $token',
//   };
//   final Map<String, dynamic> body = {'status': 'paid'};

//   try {
//     final response = await http.put(uri, headers: headers, body: jsonEncode(body));

//     if (response.statusCode == 200) {
//       print('Order status updated successfully');
//     } else {
//       print('Failed to update order status. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       throw Exception('Failed to update order status');
//     }
//   } catch (e) {
//     print('Error updating order status: $e');
//     throw Exception('Failed to update order status: $e');
//   }
// }
  Future<void> updateOrderStatus(int orderId) async {
    String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

    if (token == null) {
      throw Exception('Token not found');
    }
    final Uri uri = Uri.parse('${Endpoints.updateOrders}/$orderId');
    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    final Map<String, String> body = {'status': 'paid'};

    try {
      final response = await http.put(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        debugPrint('Order status updated successfully');
      } else {
        debugPrint(
            'Failed to update order status. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      debugPrint('Error updating order status: $e');
      throw Exception('Failed to update order status: $e');
    }
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
