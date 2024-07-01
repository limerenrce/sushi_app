import '../utils/secure_storage_util.dart';

class Endpoints {
  static late String ngrok;
  static const String baseURLLive = "https://simobile.singapoly.com";
  static const String nim = "2215091065";
  static const String localFlask = "http://192.168.1.7:5000";
  // static const String ngrok = "https://73de-180-249-185-160.ngrok-free.app";
  static const String service = "$baseURLLive/api/customer-service/$nim";

  //static const String login = "$baseURLLive/api/auth/login";
  //static const String logout = "$baseURLLive/api/auth/logout";

  // Panggil metode ini selama inisialisasi aplikasi
  static Future<void> initialize() async {
    final urlInput = await SecureStorageUtil.storage.read(key: 'url_setting');
    ngrok = urlInput ?? "default_url_if_not_found";
  }

  // static const String login = "$localFlask/api/v1/auth/login";
  // static const String logout = "$localFlask/api/v1/auth/logout";
  // static const String protected = "$localFlask/api/v1/protected";
  // static const String menus = "$localFlask/api/v1/menus";
  // static const String img = "$localFlask/static/assets/img";

  static String login = "$ngrok/api/v1/auth/login";
  static String logout = "$ngrok/api/v1/auth/logout";
  static String register = "$ngrok/api/v1/auth/register";
  static String profile = "$ngrok/api/v1/protected/data";
  static String getMenus = "$ngrok/api/v1/menus/read";
  static String getMenusName = "$ngrok/api/v1/menus/name";
  static String createMenus = "$ngrok/api/v1/menus/create";
  static String updateMenus = "$ngrok/api/v1/menus/update";
  static String deleteMenus = "$ngrok/api/v1/menus/delete";
  static String img = "$ngrok/static/assets/img";
  static String getOrders = "$ngrok/api/v1/orders/read";
  static String createOrders = "$ngrok/api/v1/orders/create";
  static String updateOrders = "$ngrok/api/v1/orders/update";
}
