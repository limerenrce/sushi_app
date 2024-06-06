class Endpoints {
  static const String baseURLLive = "https://simobile.singapoly.com";
  static const String nim = "2215091065";
  static const String localFlask = "http://127.0.0.1:5000";

  static const String login = "$baseURLLive/api/auth/login";
  static const String logout = "$baseURLLive/api/auth/logout";

  static const String service = "$baseURLLive/api/customer-service/$nim";
}
