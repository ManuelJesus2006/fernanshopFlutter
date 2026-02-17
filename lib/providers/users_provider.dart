import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/services/users_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider with ChangeNotifier {
  Users? userLogued = null;
  bool loginFailed = false;
  bool registerFailed = false;
  bool isLoading = false;
  bool parametrosSinIntroducir = true;

  UsersProvider() {
    _comprobarUserLogueado();
  }

  void confirmarLogueoInvalido(){
    loginFailed = true;
    isLoading = false;
    notifyListeners();
  }

  void confirmarRegistroInvalido(){
    registerFailed = true;
    isLoading = false;
    notifyListeners();
  }

  void logoutAndRemove()async{
    userLogued = null;
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('userLogueado');
    notifyListeners();
  }

  void confirmarLogueo(Users? userFromRequest) async {
    userLogued = userFromRequest;
    final preferences = await SharedPreferences.getInstance();
    String jsonUser = jsonEncode(userFromRequest!.toJson());
    await preferences.setString('userLogueado', jsonUser);
    isLoading = false;
    notifyListeners();
  }

  void _comprobarUserLogueado() async {
    final preferences = await SharedPreferences.getInstance();
    String? jsonUser = preferences.getString('userLogueado');
    if (jsonUser != null) {
      Users userUnchecked = userFromJson(jsonUser);
      userLogued = await UsersService().getUserByID(userUnchecked.id!);
    }
    notifyListeners();
  }

  void mostrarCargando() {
    isLoading = true;
    loginFailed = false;
    notifyListeners();
  }
}
