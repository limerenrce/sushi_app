// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/menu.dart';
import '../../services/data_service.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(const MenuState.initial());
  void fetchMenu(String category) async {
    emit(state.copyWith(isLoading: true));
    try {
      final menuList = await DataService.fetchMenus();
      emit(state.copyWith(
        menuList: menuList,
        isLoading: false,
        errorMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch menu',
      ));
    }
  }

  void createMenu(String name, String price, String rating, String description,
      String category, File? imageFile) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await DataService.createMenus(
          name, price, rating, description, category, imageFile);
      if (response.statusCode == 201) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to create menu',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to create menu',
      ));
    }
  }

  void updateVacancy(int idMenus, String name, String price, String rating,
      String description, String category, File? imageFile) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await DataService.updateMenus(
          idMenus, name, price, rating, description, category, imageFile);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to update menu',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update menu',
      ));
    }
  }

  void deleteVacancy(int idMenus) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await DataService.deleteMenus(idMenus);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete menu',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to delete menu',
      ));
    }
  }
}
