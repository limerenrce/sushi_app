class Endpoints {
  static const String baseURLLive = "https://simobile.singapoly.com";
  static const String nim = "2215091065";
  static const String localFlask = "http://10.0.2.2:5000";

  //static const String login = "$baseURLLive/api/auth/login";
  //static const String logout = "$baseURLLive/api/auth/logout";

  static const String login = "$localFlask/api/v1/auth/login";
  static const String logout = "$localFlask/api/v1/auth/login";
  static const String protected = "$localFlask/api/v1/protected";
  static const String menus = "$localFlask/api/v1/menus";
  static const String img = "$localFlask/static/assets/img";

  static const String service = "$baseURLLive/api/customer-service/$nim";
}
