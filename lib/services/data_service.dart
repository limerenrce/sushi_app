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
        request.files.add(
          await http.MultipartFile.fromPath(
            'image_path',
            imagePath,
          ),
        );
      }

      // Debug prints
      print('Request URL: ${Endpoints.createMenus}');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      if (imagePath != null) {
        print('Image File: $imagePath');
      }

      // Send the request and handle the response
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Debug print response details
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check for status codes and handle accordingly
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception(
            'Failed to create menu: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to create menu: $e');
    }
  }
// static Future<void> createMenu(Menus menu) async {
//   String? token = await SecureStorageUtil.storage.read(key: tokenStoreName);

//   if (token == null) {
//     throw Exception('Token not found');
//   }
//     final response = await http.post(
//       Uri.parse(Endpoints.createMenus),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(menu.toJson()),
//     );

//     if (response.statusCode == 201) {
//       print('Issues uploaded succesfully');
//     } else {
//       throw Exception('Failed to create issues');
//     }
//   }

// ----------------------- batas ------------------------

  //   try {
  //     // Construct the multipart request
  //     var request = http.MultipartRequest('POST', Uri.parse(Endpoints.createMenus));

  //     // Add fields to the request
  //     request.fields['category'] = menu.category;
  //     request.fields['createdAt'] = menu.createdAt;
  //     request.fields['description'] = menu.description;
  //     request.fields['name'] = menu.name;
  //     request.fields['price'] = menu.price.toString();
  //     request.fields['rating'] = menu.rating.toString();
  //     request.fields['updatedAt'] = menu.updatedAt;

  //     // Add the image file if it exists
  //     if (imageFile != null) {
  //       request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  //     }

  //     // Send the request
  //     var response = await request.send();

  //     // Read the response
  //     var responseString = await response.stream.bytesToString();
  //     if (response.statusCode == 200) {
  //       print('Success: $responseString');
  //       return true;
  //     } else {
  //       print('Failed with status: ${response.statusCode}');
  //       print('Response: $responseString');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //     return false;
  //   }
  // }
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
            'image_path',
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
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final Map<String, dynamic> body = {'status': 'paid'};

  try {
    final response = await http.put(uri, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print('Order status updated successfully');
    } else {
      print('Failed to update order status. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update order status');
    }
  } catch (e) {
    print('Error updating order status: $e');
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
