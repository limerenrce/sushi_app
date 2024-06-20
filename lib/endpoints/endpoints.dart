class Endpoints {
  static const String baseURLLive = "https://simobile.singapoly.com";
  static const String nim = "2215091065";
  static const String localFlask = "http://192.168.1.7:5000";
  static const String ngrok = "https://06b0-180-249-185-160.ngrok-free.app";
  

  //static const String login = "$baseURLLive/api/auth/login";
  //static const String logout = "$baseURLLive/api/auth/logout";
  static const String service = "$baseURLLive/api/customer-service/$nim";


  // static const String login = "$localFlask/api/v1/auth/login";
  // static const String logout = "$localFlask/api/v1/auth/logout";
  // static const String protected = "$localFlask/api/v1/protected";
  // static const String menus = "$localFlask/api/v1/menus";
  // static const String img = "$localFlask/static/assets/img";

  static const String login = "$ngrok/api/v1/auth/login";
  static const String logout = "$ngrok/api/v1/auth/logout";
  static const String register = "$ngrok/api/v1/auth/register";
  static const String profile = "$ngrok/api/v1/protected/data";
  static const String getMenus = "$ngrok/api/v1/menus/read";
  static const String createMenus = "$ngrok/api/v1/menus/create";
  static const String updateMenus = "$ngrok/api/v1/menus/update";
  static const String deleteMenus = "$ngrok/api/v1/menus/update";
  static const String img = "$ngrok/static/assets/img";
}
