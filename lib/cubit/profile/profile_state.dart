part of 'profile_cubit.dart';

@immutable
class ProfileState {
  final String roles;
  final String userLogged;

  const ProfileState({required this.roles, required this.userLogged});
}

final class ProfileInitialState extends ProfileState {
  const ProfileInitialState()
      : super(roles: 'customer', userLogged: 'anonymus');
}
