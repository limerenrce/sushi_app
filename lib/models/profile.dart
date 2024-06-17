class Profile {
  final String message;
  final String roles;
  final String userLogged;

  Profile(
      {required this.message, required this.roles, required this.userLogged});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      message: json['message'],
      roles: json['roles'],
      userLogged: json['user_logged'],
    );
  }
}
