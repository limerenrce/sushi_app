import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitialState());

  void setProfile(String roles, String userLogged) {
    emit(ProfileState(roles: roles, userLogged: userLogged));
  }
}
